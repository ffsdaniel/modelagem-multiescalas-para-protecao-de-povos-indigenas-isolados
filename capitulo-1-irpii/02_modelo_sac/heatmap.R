library(ggplot2)
library(readxl)
library(tidyr)
library(scico)

ucs <- read_excel("data/CNUC_ZONAIS.xlsx")

# Fazer dataframe e pivotar
data <- ucs %>%
  select(Nome, PC1, PC2, PC3, PC4)

data_longa <- data %>%
  pivot_longer(
    cols = c(PC1, PC2, PC3, PC4),
    names_to = "Componente",
    values_to = "Valor"
  )

# Heatmap
ggplot(data_longa, aes(x = Componente, y = reorder(Nome, Valor), fill = Valor)) +
  theme_minimal(base_family = "serif") +
  scale_fill_scico(palette = "managua", direction = -1) + #paleta managua <3  
  labs(y = "Unidades de Conservação", title = "Heatmap de Principais Componentes",
       caption = "Valores maiores indicam maior ameaça") +
  geom_tile()

# Salvar
ggsave(
  filename = "Heatmap.png",
  plot = last_plot(),
  height = 297,
  width = 210,
  units = "mm",
  dpi = 600
)
