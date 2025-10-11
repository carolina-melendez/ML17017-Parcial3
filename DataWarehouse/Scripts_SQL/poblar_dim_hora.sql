DECLARE @Hora INT = 0;
DECLARE @Minuto INT = 0;

WHILE @Hora < 24
BEGIN
    SET @Minuto = 0;
    WHILE @Minuto < 60
    BEGIN
        INSERT INTO dim.DimHora (HoraKey, Hora, Minuto, BloqueHora)
        VALUES (
            (@Hora * 100) + @Minuto,              
            @Hora,
            @Minuto,
            RIGHT('0' + CAST(@Hora AS VARCHAR(2)), 2) + ':00 - ' +
            RIGHT('0' + CAST(@Hora AS VARCHAR(2)), 2) + ':59'
        );
        SET @Minuto = @Minuto + 1;
    END;
    SET @Hora = @Hora + 1;
END;