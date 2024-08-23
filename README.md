# Dominican Republic Central Bank Monetary Policy Rate Data Processing | Procesamiento de Datos de la Tasa de Política Monetaria del Banco Central de la República Dominicana

This R script processes "Tasa de Política Monetaria" (TPM) data from an Excel file provided by the Central Bank of the Dominican Republic. TPM rates reflect the cost of borrowing from the central bank and are used to gauge monetary policy stance.

Este script de R procesa los datos de "Tasa de Política Monetaria" (TPM) de un archivo Excel proporcionado por el Banco Central de la República Dominicana. Las tasas TPM reflejan el costo de los préstamos del banco central y se utilizan para evaluar la política monetaria.

## Features
- Downloads TPM data from a specified URL.
- Cleans and transforms the data.
- Automatically uploads the processed data to a database.

## Requirements
- `readxl`
- `tidyverse`
- `ggplot2`
- `DBI`

## Data Cleaning

The script performs the following steps:
1. **Corrects Month Names:** Fixes errors in month names from the dataset.
2. **Maps Months to Numbers:** Converts month names to numeric values for easier analysis.
3. **Completes Missing Years:** Fills in missing year values based on the most recent non-NA year.
4. **Transforms Data:** Converts the data to a long format, making it suitable for analysis and upload.

El script realiza los siguientes pasos:
1. **Corrige Nombres de Meses:** Corrige errores en los nombres de los meses del conjunto de datos.
2. **Asocia Meses con Números:** Convierte los nombres de los meses en valores numéricos para facilitar el análisis.
3. **Completa Años Faltantes:** Rellena los valores de años faltantes basándose en el año más reciente no NA.
4. **Transforma Datos:** Convierte los datos a un formato largo, haciéndolos adecuados para análisis y carga.

**Data Extracted:** Monthly monetary policy rates, along with deposit and loan values, used to analyze the central bank's monetary policy in the Dominican Republic.

**Datos Extraídos:** Tasas mensuales de política monetaria, junto con valores de depósitos y préstamos, utilizados para analizar la política monetaria del Banco Central de la República Dominicana.
