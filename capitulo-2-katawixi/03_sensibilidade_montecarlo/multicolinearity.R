library(terra)
library(usdm)

variaveis <- c(
  "/mnt/ssd/Mestrado/Capítulo 2/database/katawixi_sensibility_model/var/bertholletia_excelsa.tif",
  "/mnt/ssd/Mestrado/Capítulo 2/database/katawixi_sensibility_model/var/distance_to_palm_forest.tif",
  "/mnt/ssd/Mestrado/Capítulo 2/database/katawixi_sensibility_model/var/exclusion_zones.tif"
)

stack <- rast(variaveis)
names(stack) <- c("Castanheira", "Dist_Palhal", "IRPII")
#amostra / sample
set.seed(42) 
dados_amostra <- spatSample(stack, size = 10000, method = "random", na.rm = TRUE)

print(cor(dados_amostra))
#vif 
vif_resultados <- vif(as.data.frame(dados_amostra))

print(vif_resultados)
