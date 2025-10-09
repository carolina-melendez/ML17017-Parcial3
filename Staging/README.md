# Proceso ETL – Carga de datos al Staging

## Descripción general

Este proceso ETL permite **cargar automáticamente los archivos CSV** con información de vuelos desde una carpeta local hacia la base de datos **`staging_vuelos`**, dentro de la tabla **`stg.VuelosRaw`** en SQL Server.  

La carga se realiza mediante un **paquete SSIS (`Cargar_Staging_Multiples.dtsx`)**, que recorre cada archivo de la carpeta, lo lee y lo inserta en la tabla staging.

El objetivo del *staging* es **almacenar los datos crudos, sin transformaciones complejas**, para luego ser procesados hacia el Data Warehouse.

## Requisitos previos

Antes de ejecutar el proceso, asegúrate de tener:

1. **Microsoft SQL Server 2019 o superior**  
   - Base creada: `staging_vuelos`
   - Usuario con permisos de escritura (`sa` o equivalente)

2. **Visual Studio 2022 con la extensión Integration Services Projects**  
   - Permite abrir y ejecutar paquetes `.dtsx`

3. **Archivos CSV válidos**  
   - Deben contener las columnas esperadas (estructura del dataset “Flight Status Prediction” o similar).
   - Se recomienda nombrarlos con el patrón:
     ```
     Flights_YYYY_#.csv
     ```
     Ejemplo: `Flights_2018_1.csv`, `Flights_2019_2.csv`

---

## Configuración del paquete SSIS

### Variables del paquete
El flujo usa dos variables principales:

| Variable | Tipo | Valor por defecto | Descripción |
|-----------|------|------------------|--------------|
| `User::vRutaCarpeta` | String | Ruta de la carpeta donde están los CSV | Ejemplo: `C:\Users\diann\Documents\ESPECIALIZACIÓN\ML17017-Parcial3\DataSource\csv\` |
| `User::vRutaArchivoCompleta` | String | *(Vacío)* | Guarda temporalmente la ruta completa del archivo actual |

---

## Credenciales de conexión a la base remota 
Para conectarse a la base de datos remota, utiliza los siguientes parámetros en el administrador de conexiones de SSIS:

- **Servidor (host):** `165.227.22.226`
- **Base de datos:** `staging_vuelos`
- **Usuario:** `sa`
- **Contraseña:** `Sql2024@DW`

Asegúrate de seleccionar **Autenticación SQL Server** y probar la conexión antes de ejecutar el paquete.