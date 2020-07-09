#### Script para descarga de datos base: NASAPOWER, CHIRPS, SOILGRIDS
### Rodriguez-Espinoza J., Esquivel A.
### 2020


#################################################
### 1 Cargar Paquetes
#################################################

library(tidyverse)
library(data.table)
library(lubridate)
library(skimr)
library(naniar)
library(jsonlite)
library(sirad)
library(soiltexture)


# Cargar funciones en desarrollo
source("https://raw.githubusercontent.com/jrodriguez88/csmt/master/get_data/get_data_nasapower.R", encoding = "UTF-8")
source("https://raw.githubusercontent.com/jrodriguez88/csmt/master/get_data/get_data_soilgrids.R", encoding = "UTF-8")


# Variables de NASAPOWER
#https://power.larc.nasa.gov/docs/v1/
fecha_inicial <- 19850101
fecha_final <- 20161231
#Precipitacion, Radiacion Solar, Humedad Relativa, Temp. Max, Temp. Min, Velocidad viento.
variables_clima <- c("PRECTOT", "ALLSKY_SFC_SW_DWN","RH2M", "T2M_MAX", "T2M_MIN","WS2M")


#Variables de SOILGRIDS
#https://www.isric.org/explore/soilgrids/faq-soilgrids
#Densidad Aparente, %Arcillas, %Arenas, %Grava, Carbono Organico, (Contenido agua a marchitez, Capacidad de campo, Saturacion) 
variables_suelo <- c("BLDFIE","CLYPPT","SNDPPT","CRFVOL","ORCDRC","WWP","AWCh1","AWCtS")
profundidades <- c("sl1", "sl2", "sl3", "sl4", "sl5")  # 60cm

# Datos de localidad
#localidad <- "jalapa"
#latitud <- 13.9
#longitud <- -86.0
#altitud <- 677

#Descarga de datos crudos
datos_clima_crudos <- get_data_nasapower(variables_clima, fecha_inicial, fecha_final, latitud, longitud)
datos_suelo_crudos <- get_data_soilgrids(variables_suelo, latitud, longitud, profundidades)


estaciones_ineter <- read_csv("data/data_ineter_temp.csv")

nasa_raw <- estaciones_ineter %>% 
  mutate(nasa_power_raw = map2(lat, lon, ~get_data_nasapower(variables_clima, fecha_inicial, fecha_final, .x, .y)))









