CREATE DATABASE staging_vuelos;

USE staging_vuelos;

CREATE SCHEMA stg;

CREATE TABLE stg.VuelosRaw (
    Year                     INT,
    Quarter                  INT,
    Month                    INT,
    DayofMonth               INT,
    DayOfWeek                INT,
    FlightDate               DATE,
    Marketing_Airline_Network NVARCHAR(10),
    Operated_or_Branded_Code_Share_Partners NVARCHAR(50),
    DOT_ID_Marketing_Airline INT,
    IATA_Code_Marketing_Airline NVARCHAR(10),
    Flight_Number_Marketing_Airline INT,
    Operating_Airline         NVARCHAR(10),
    DOT_ID_Operating_Airline  INT,
    IATA_Code_Operating_Airline NVARCHAR(10),
    Tail_Number              NVARCHAR(20),
    Origin                   NVARCHAR(10),
    OriginCityName            NVARCHAR(60),
    OriginStateName           NVARCHAR(50),
    Dest                     NVARCHAR(10),
    DestCityName              NVARCHAR(60),
    DestStateName             NVARCHAR(50),
    CRSDepTime               INT,
    DepTime                  FLOAT,
    DepDelayMinutes          FLOAT,
    ArrDelayMinutes          FLOAT,
    Cancelled                BIT,
    CancellationCode          NVARCHAR(2),
    Diverted                 BIT,
    AirTime                  FLOAT,
    CRSElapsedTime           FLOAT,
    ActualElapsedTime        FLOAT,
    Distance                 FLOAT,
    DepDel15                 BIT,
    ArrDel15                 BIT,
    CarrierDelay             FLOAT,
    WeatherDelay             FLOAT,
    NASDelay                 FLOAT,
    SecurityDelay            FLOAT,
    LateAircraftDelay        FLOAT
);
