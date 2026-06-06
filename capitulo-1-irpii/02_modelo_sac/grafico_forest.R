library(ggplot2)
library(dplyr)

resumo <- summary(modelo_sac)
coef_df <- as.data.frame(resumo$Coef)
 # nomes mais legíveis
plot_data <- coef_df %>%
  mutate(Termo = rownames(.)) %>%
  filter(Termo != "(Intercept)") %>%
  mutate(Termo_Limpo = c(
    "Tamanho (Log Área)", "Densidade de Borda", "Categoria: Floresta",
    "Categoria: Parque", "Categoria: ReBio", "Categoria: RDS",
    "Categoria: Resex", "Sobreposição TI", "Adesão ao ARPA",
    "Nota de Efetividade", "Nota de Insumos"
  )) %>%
  # intervalos de confiança
  mutate(
    Estimativa = Estimate,
    Erro = `Std. Error`,
    IC_Inf = Estimativa - (1.96 * Erro),
    IC_Sup = Estimativa + (1.96 * Erro),
    P_valor = `Pr(>|z|)`
  ) %>%
  # significância
  mutate(Significancia = case_when(
    P_valor < 0.05 & Estimativa > 0 ~ "Aumenta o IRPII",
    P_valor < 0.05 & Estimativa < 0 ~ "Reduz o IRPII",
    TRUE ~ "Não Significativo"
  ))

# paleta managua do scientific color maps
paleta <- c(
  "Aumenta o IRPII" = "#dd9a55", 
  "Reduz o IRPII"   = "#6db1de",
  "Não Significativo" = "#56294a"  
)
#gráfico
forest_plot <- ggplot(plot_data, aes(x = Estimativa, y = reorder(Termo_Limpo, Estimativa), color = Significancia)) +
  geom_vline(xintercept = 0, linetype = "dashed", color = "black", alpha = 0.5) +
  geom_errorbarh(aes(xmin = IC_Inf, xmax = IC_Sup), height = 0.2, size = 0.8) +
  geom_point(size = 3.5, shape = 15) + 
  scale_color_manual(values = paleta) +
  labs(
    x = "Coeficiente (β)",
    y = NULL,
    color = "Significância"
  ) +
  theme_minimal() +
  theme(
    text = element_text(family = "serif", size = 16),
    plot.title = element_text(face = "bold", size = 16),
    axis.text = element_text(color = "black"),
    legend.position = "bottom",
    panel.grid.minor = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, size = 0.5)
  )

# salvar
print(forest_plot)
ggsave("Forest_Plot_SAC.png", plot = forest_plot, width = 8, height = 6, dpi = 300)
