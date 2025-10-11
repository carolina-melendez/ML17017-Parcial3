-- Creación de la base de datos DWVuelos y los esquemas dim y fact
IF DB_ID('DWVuelos') IS NULL
    CREATE DATABASE DWVuelos;
    
USE DWVuelos;

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name='dim') EXEC('CREATE SCHEMA dim');
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name='fact') EXEC('CREATE SCHEMA fact');

-- Creación de las tablas de dimensiones

CREATE TABLE dim.DimFecha (
    FechaKey        INT PRIMARY KEY,           
    Fecha           DATE NOT NULL,
    Anio            INT  NOT NULL,
    Mes             INT  NOT NULL,
    DiaMes          INT  NOT NULL,
    Trimestre       INT  NOT NULL,
    Semana          INT  NOT NULL,
    EsFinDeSemana   BIT  NOT NULL,
    NombreMes       VARCHAR(20),
    NombreDia       VARCHAR(20)
);

CREATE TABLE dim.DimHora (
    HoraKey     INT PRIMARY KEY,               
    Hora        INT NOT NULL,
    Minuto      INT NOT NULL,
    BloqueHora  VARCHAR(20)
);

CREATE TABLE dim.DimAerolinea (
    AerolineaKey             INT IDENTITY PRIMARY KEY,
    MarketingNetwork          VARCHAR(250) NULL,   
    BrandedPartner            VARCHAR(250) NULL,   
    CodigoIATA_Marketing      VARCHAR(10)  NULL,   
    NumeroVuelo_Marketing     VARCHAR(20)  NULL,   
    NombreAerolinea           VARCHAR(250) NULL,   
    CodigoIATA_Operadora      VARCHAR(10)  NULL,   
    NumeroDeCola              VARCHAR(50)  NULL,   
    Activo                    BIT DEFAULT 1
);

CREATE TABLE dim.DimAeropuerto (
    AeropuertoKey INT IDENTITY PRIMARY KEY,
    CodigoIATA    VARCHAR(10) NOT NULL,
    Ciudad        VARCHAR(250),
    EstadoNombre  VARCHAR(250),
    FechaInicio   DATE NOT NULL DEFAULT (GETDATE()),
    FechaFin      DATE NOT NULL DEFAULT ('9999-12-31'),
    Activo        BIT NOT NULL DEFAULT 1
);

CREATE TABLE dim.DimCausa (
    CausaKey     INT IDENTITY PRIMARY KEY,
    Codigo       VARCHAR(2)  NOT NULL,
    Descripcion  VARCHAR(100),
    Tipo         VARCHAR(50)
);

-- Creación de la tabla de hechos
CREATE TABLE fact.FT_Vuelo (
    VueloKey              BIGINT IDENTITY PRIMARY KEY,

    -- Relaciones
    FechaKey              INT NOT NULL FOREIGN KEY REFERENCES dim.DimFecha(FechaKey),
    AeropuertoOrigenKey   INT NOT NULL FOREIGN KEY REFERENCES dim.DimAeropuerto(AeropuertoKey),
    AeropuertoDestinoKey  INT NOT NULL FOREIGN KEY REFERENCES dim.DimAeropuerto(AeropuertoKey),
    AerolineaKey          INT NOT NULL FOREIGN KEY REFERENCES dim.DimAerolinea(AerolineaKey),
    HoraSalidaKey         INT NULL  FOREIGN KEY REFERENCES dim.DimHora(HoraKey),
    HoraLlegadaKey        INT NULL  FOREIGN KEY REFERENCES dim.DimHora(HoraKey),
    CausaKey              INT NULL  FOREIGN KEY REFERENCES dim.DimCausa(CausaKey),

    -- Tiempos de retraso
    MinutosRetardoSalida       FLOAT NULL,   
    MinutosRetardoLlegada      FLOAT NULL,   

    -- Retrasos por causa
    RetrasoPorAerolinea        FLOAT NULL,   
    RetrasoPorClima            FLOAT NULL,   
    RetrasoPorSistemaAereo     FLOAT NULL,   
    RetrasoPorSeguridad        FLOAT NULL,   
    RetrasoPorAeronavePrevia   FLOAT NULL,   

    -- Indicadores de estado
    VueloRetrasado15min        BIT NULL,
    LlegadaRetrasada15min      BIT NULL,
    Cancelado                  BIT NULL,
    Desviado                   BIT NULL,

    -- Duraciones y distancia
    TiempoProgramado           FLOAT NULL,   
    TiempoReal                 FLOAT NULL,   
    TiempoEnAire               FLOAT NULL,   
    Distancia                  FLOAT NULL    
);