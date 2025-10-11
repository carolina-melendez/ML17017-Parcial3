-- Descripción : Genera y llena la dimensión de fechas
-- Parámetros  :
--   @FechaInicio  -> Fecha mínima del rango
--   @FechaFin     -> Fecha máxima del rango

CREATE PROCEDURE GenerarDimFecha
    @FechaInicio DATE,
    @FechaFin    DATE
AS
BEGIN
    SET NOCOUNT ON;

    SET LANGUAGE Spanish;

    -- Validación básica
    IF @FechaInicio IS NULL OR @FechaFin IS NULL
    BEGIN
        RAISERROR('Debe especificar ambas fechas: @FechaInicio y @FechaFin.', 16, 1);
        RETURN;
    END;

    IF @FechaFin < @FechaInicio
    BEGIN
        RAISERROR('La fecha final no puede ser menor a la inicial.', 16, 1);
        RETURN;
    END;

    PRINT 'Generando registros de DimFecha entre ' 
          + CONVERT(VARCHAR(10), @FechaInicio, 120) + ' y ' 
          + CONVERT(VARCHAR(10), @FechaFin, 120);

    -- Generar la serie de fechas
    ;WITH FechaSerie AS (
        SELECT @FechaInicio AS Fecha
        UNION ALL
        SELECT DATEADD(DAY, 1, Fecha)
        FROM FechaSerie
        WHERE Fecha < @FechaFin
    )
    INSERT INTO dim.DimFecha (
        FechaKey,
        Fecha,
        Anio,
        Mes,
        DiaMes,
        Trimestre,
        Semana,
        EsFinDeSemana,
        NombreMes,
        NombreDia
    )
    SELECT
        CONVERT(INT, FORMAT(Fecha, 'yyyyMMdd'))            AS FechaKey,
        Fecha,
        DATEPART(YEAR, Fecha)                              AS Anio,
        DATEPART(MONTH, Fecha)                             AS Mes,
        DATEPART(DAY, Fecha)                               AS DiaMes,
        DATEPART(QUARTER, Fecha)                           AS Trimestre,
        DATEPART(WEEK, Fecha)                              AS Semana,
        CASE WHEN DATENAME(WEEKDAY, Fecha) IN ('Saturday','Sunday','sábado','domingo') THEN 1 ELSE 0 END AS EsFinDeSemana,
        DATENAME(MONTH, Fecha)                             AS NombreMes,
        DATENAME(WEEKDAY, Fecha)                           AS NombreDia
    FROM FechaSerie
    WHERE CONVERT(INT, FORMAT(Fecha, 'yyyyMMdd')) NOT IN (SELECT FechaKey FROM dim.DimFecha)
    OPTION (MAXRECURSION 0);

    PRINT 'DimFecha generada correctamente.';
END;
    