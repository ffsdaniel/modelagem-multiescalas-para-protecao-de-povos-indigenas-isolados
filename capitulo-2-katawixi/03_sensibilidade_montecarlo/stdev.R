library(readr)
library(scico)


# histograma do mapa de stdev
dados <- read_csv("data/stdev_histogram.csv")
dados$values = dados$`Values*`
spec(dados)
summary(dados)

library(ggplot2)

plot = ggplot(data = dados, mapping = aes(x = values, y = Relative_Frequencies, color = values)) +
  geom_line() +
  scale_color_scico(palette = "batlow") +
  xlim(2.400e-08, 0.12) +
  theme_minimal(base_family = "serif") +
  theme(axis.title.x = element_text(size = 18),
        axis.title.y = element_text(size = 18),
        axis.text.x = element_text(size = 16),
        axis.text.y = element_text(size = 10),
        legend.position = "none"
        ) +
  labs(x = "Desvio Padrão dos Cenários Estocásticos do Modelo de Sensibilidade", y = "Frequências")

ggsave(plot = plot, filename = "stdev_histogram.png", dpi = 600, width = 11, height = 6)
