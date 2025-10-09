USE staging_vuelos;

IF OBJECT_ID('stg.VuelosRaw') IS NOT NULL
    DROP TABLE stg.VuelosRaw;

CREATE TABLE stg.VuelosRaw (
    -- === Fecha / tiempo ===
    Year                    INT NULL,
    Quarter                 INT NULL,
    Month                   INT NULL,
    DayofMonth              INT NULL,
    DayOfWeek               INT NULL,
    FlightDate              DATE NULL,

    -- === Aerolínea / vuelo ===
    Marketing_Airline_Network           VARCHAR(250) NULL,
    Operated_or_Branded_Code_Share_Partners VARCHAR(250) NULL,
    IATA_Code_Marketing_Airline         VARCHAR(250) NULL,
    Flight_Number_Marketing_Airline     VARCHAR(250) NULL,
    Operating_Airline                   VARCHAR(250) NULL,
    IATA_Code_Operating_Airline         VARCHAR(250) NULL,
    Tail_Number                         VARCHAR(250) NULL,

    -- === Origen / destino ===
    Origin                  VARCHAR(250) NULL,
    OriginCityName          VARCHAR(250) NULL,
    OriginStateName         VARCHAR(250) NULL,
    Dest                    VARCHAR(250) NULL,
    DestCityName            VARCHAR(250) NULL,
    DestStateName           VARCHAR(250) NULL,

    -- === Horarios / retrasos ===
    CRSDepTime              VARCHAR(250) NULL,
    DepDelayMinutes         VARCHAR(250) NULL,
    ArrDelayMinutes         VARCHAR(250) NULL,

    -- === Estado del vuelo ===
    Cancelled               VARCHAR(250)  NULL,
    CancellationCode        VARCHAR(250) NULL,
    Diverted                VARCHAR(250)  NULL,

    -- === Duración / distancia ===
    CRSElapsedTime          VARCHAR(250) NULL,
    ActualElapsedTime       VARCHAR(250) NULL,
    AirTime                 VARCHAR(250) NULL,
    Distance                VARCHAR(250) NULL,

    -- === Causas de retraso (convertidas a texto para evitar error) ===
    CarrierDelay            VARCHAR(250) NULL,
    WeatherDelay            VARCHAR(250) NULL,
    NASDelay                VARCHAR(250) NULL,
    SecurityDelay           VARCHAR(250) NULL,
    LateAircraftDelay       VARCHAR(250) NULL
);
