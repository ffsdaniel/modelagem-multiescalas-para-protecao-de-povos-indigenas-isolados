library(terra)
library(car)

variaveis <- c(
  "data/VAR_CASTANHEIRA.tif",
  "data/VAR_DISTANCIA_DE_PALHAL.tif",
  "data/VAR_INDICE.tif"
)

stack <- rast(variaveis)
names(stack) <- c("Castanheira", "Dist_Palhal", "IRPII")

set.seed(42)
dados_amostra <- spatSample(stack, size = 10000, method = "random", na.rm = TRUE)

print(cor(dados_amostra))

modelo_vif <- lm(Castanheira ~ Dist_Palhal + IRPII, data = as.data.frame(dados_amostra))
# vif
vif_resultados <- vif(modelo_vif)

print(vif_resultados)
