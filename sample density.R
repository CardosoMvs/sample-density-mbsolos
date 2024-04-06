## Script para somar a área de polígonos por província e dividir o número de pontos por esta área
## Autor: Marcos Cardoso 2024/04
## MapBiomas Solo - StockCos

# Carrega o pacote tidyverse
# install.packages("tidyverse")
# install.packages("readxl")
# install.packages("dplyr")
library(readxl)
library(tidyverse)
library(dplyr)

# Lê o arquivo Excel
dados_area <- read_excel("D:/0_Projetos/3_analytics-mapbiomas/densidade amostral/matriz/geol_tabela_area.xlsx")

dados_npoints <- read_excel("D:/0_Projetos/3_analytics-mapbiomas/densidade amostral/matriz/points_per_provincias.xlsx")

# Soma a coluna "ar_poli_km" para cada classe "nm_provincia"
soma_ar_poli_km <- dados_area %>%
  group_by(nm_provincia) %>%
  summarise(soma_ar_poli_km = sum(ar_poli_km))

  #view(soma_ar_poli_km)

## Para fitofissiomia usar legenda_1, para o provincias usar nm_provincia

 # print(soma_ar_poli_km)

# Junta os dados usando a coluna comum "provincia"
tabela_final <- left_join(dados_npoints, soma_ar_poli_km, by = c("provincia" = "nm_provincia"))

# Divide o valor da coluna npoints pela soma_ar_poli_km (dividido por 1000)
tabela_final <- tabela_final %>%
  mutate(npoints_normalized = npoints / (soma_ar_poli_km / 1000))

# Exibe o resultado
print(tabela_final)


