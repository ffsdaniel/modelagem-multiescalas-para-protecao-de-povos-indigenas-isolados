library(sf)
library(spdep)
library(spatialreg)
library(dplyr)
library(bblme)

arquivo_entrada <- "data/CNUC_FINAL.gpkg"
dados_brutos <- st_read(arquivo_entrada, quiet = TRUE)

# Corrects decimals / Corrige decimais
corrigir_decimal <- function(x) {
  as.numeric(gsub(",", ".", as.character(x)))
}
# Serão analisados 2 modelos, um modelo mais parcimonioso (2), e outro mais complexo (1)

# Modelo 1
# Seleciona variáveis
dados_modelo1 <- dados_brutos %>%
  mutate(
    # Y
    IND_final = corrigir_decimal(INDICE),

    # X
    log_area   = log(as.numeric(area_ha)),
    Dens_Borda = as.numeric(Densidade_borda),
    Categoria  = as.factor(trimws(as.character(categoria))),
    Sobreposicao_TI = as.factor(Sobreposicao_TI),
    Arpa            = as.factor(Arpa),
    Nota_Efetividade = corrigir_decimal(SAMGE_Cálculo.Efetividade),
    Nota_Insumos     = corrigir_decimal(SAMGE_Cálculo.Insumos)
  ) %>%
  # Remove NAs
  dplyr::select(IND_final, log_area, Dens_Borda, Categoria,
                Sobreposicao_TI, Arpa, Nota_Efetividade, Nota_Insumos) %>%
  na.omit()

# K Nearest neighbors
coords <- st_coordinates(st_centroid(dados_modelo1))
vizinhos <- knn2nb(knearneigh(coords, k = 3))
pesos_espaciais <- nb2listw(vizinhos, style = "W")

# Formula
formula_final1 <- IND_final ~ log_area + Dens_Borda + Categoria +
  Sobreposicao_TI + Arpa + Nota_Efetividade + Nota_Insumos

modelo_sac1 <- sacsarlm(formula_final,
                       data = dados_modelo,
                       listw = pesos_espaciais,
                       zero.policy = TRUE)


print(summary(modelo_sac1))


#Modelo 2

# Seleciona variáveis
dados_modelo2 <- dados_brutos %>%
  mutate(
    # Y 
    IND_final = corrigir_decimal(INDICE),
    
    # X 
    log_area   = log(as.numeric(area_ha)),
    Dens_Borda = as.numeric(Densidade_borda),
    Categoria  = as.factor(trimws(as.character(cat_iucn))),
    Sobreposicao_TI = as.factor(Sobreposicao_TI),         
    Nota_Efetividade = corrigir_decimal(SAMGE_Cálculo.Efetividade),
    Nota_Insumos     = corrigir_decimal(SAMGE_Cálculo.Insumos) 
  ) %>%
  # Remove NAs 
  dplyr::select(IND_final, log_area, Dens_Borda, Categoria, 
                Sobreposicao_TI, Arpa, Nota_Efetividade, Nota_Insumos) %>%
  na.omit()

# K Nearest neighbors 
coords <- st_coordinates(st_centroid(dados_modelo2))
vizinhos <- knn2nb(knearneigh(coords, k = 3))
pesos_espaciais <- nb2listw(vizinhos, style = "W")

# Formula 
formula_final2 <- IND_final ~ log_area + Dens_Borda + Categoria + 
  Sobreposicao_TI + Arpa + Nota_Efetividade + Nota_Insumos
modelo_sac2 <- sacsarlm(formula_final2, 
                       data = dados_modelo2, 
                       listw = pesos_espaciais, 
                       zero.policy = TRUE)

print(summary(modelo_sac2))

# Comparação de modelos usando AIC

AICtab(modelo_sac1,modelo_sac2)
