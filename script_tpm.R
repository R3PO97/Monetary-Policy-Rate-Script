# ---- LIBRARIES ----
library(readxl)
library(tidyverse)
library(ggplot2)
library(DBI)

# ---- SETUP & ENVIRONMENT VARIABLES ----
setwd("...")
link <- "https://cdn.bancentral.gov.do/documents/estadisticas/sector-monetario-y-financiero/documents/Serie_TPM.xlsx?v=1646769230448?v=1646769230452"
fileName <- "tpm.xlsx"
col_names_1 <- c("ano", "mes", "tpm", "deposito", "prestamo")

map <- list("Ene" = "01",
            "Feb" = "02",
            "Mar" = "03",
            "Abr" = "04",
            "May" = "05",
            "Jun" = "06",
            "Jul" = "07",
            "Ago" = "08",
            "Sep" = "09",
            "Oct" = "10",
            "Nov" = "11",
            "Dic" = "12")

# ---- FUNCTIONS ----

year_setup <- function(df, col){
  len <- nrow(df)                                                               # Get df length
  
  for(x in 1:len){                                                              # Loop through every row
    if (is.na(df[x,1])){                                                        # If NA:
      df[x,1] <- current_year                                                   #   Substitute NA for year value
      
    }else {                                                                     # Else:
      current_year <- df[x,1]                                                   #   save year to local variable
      
    }
  }
  return(df)                                                                    # Return df
}

uploadData <- function(data){
  
  con <- dbConnect(odbc::odbc(), "BIDATA")                                      # establish connection
  dbWriteTable(con,                                                             # Pass previously set connection
               "TPM_BC",                                                        # Pass name
               data,                                                            # Pass df
               overwrite = T)                                                   # Write to table (Overwrite)
  dbDisconnect(con)                                                             # disconnect from server
}

# ---- MAIN & DATA CLEANING ----
download.file(link, destfile = fileName, mode="wb")                             # Download file

df <- import(file = fileName)                                                   # Import File to df

df[195,2] <- "Mar"                                                              # Fix few mistakes in doc
df[110,2] <- "Feb"

df <- df %>%                                                                    
  `colnames<-`(col_names_1) %>%                                                 # Rename Cols
  select(col_names_1) %>%                                                       # Keep columns we need
  slice(6:n()) %>%                                                              # Keep rows we need
  drop_na(mes) %>%                                                              # Drop last few rows with useless info
  year_setup("ano") %>%                                                         # Complete year col
  mutate(mes = recode(mes, !!!map),                                             # Map month to number values
         fecha = paste0(ano, mes, "01")) %>%                                    # Create date col
  pivot_longer(!c("fecha", "mes", "ano"),
               names_to = "tasa",
               values_to = "valor") %>%                                         # Pivot longer 
  mutate(valor=as.numeric(valor)) %>%                                           # Cast values in value col to numeric
  select(-c(ano, mes))                                                          # Remove useless cols

uploadData(df)                                                                  # Upload data to server


