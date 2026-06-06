
## Modelagem Espacial Multiescalas para Proteção de Povos Indígenas Isolados da Amazônia

Repositório de scripts da dissertação de mestrado no Programa de Pós-Graduação em Ecologia, Conservação e Manejo da Vida Silvestre (ECMVS/UFMG).

Autor: Daniel Fernandes

2026
---
### Estrutura

capitulo-1-irpii/

    01_pca_irpii/             # preparo de variáveis, PCA, soma ponderada e teste de normalidade
    02_modelo_sac/            # modelo SAC, forest plot e heatmap dos PCs

capitulo-2-katawixi/

    01_classificacao_uso_cobertura/   # preparo Sentinel-2 + Random Forest
    02_nicho_maxent/                  # nicho de B. excelsa
    03_sensibilidade_montecarlo/      # Monte Carlo, VIF, desvio-padrão

documentos

    figuras/                      # figuras de gráficos
    tabelas/                      # tabelas de construcao de gráfico

---
### Capítulo 1
| Etapa | Arquivo | Uso |
|-------|-----------------|------------|
| Preparo de variáveis | `01_pca_irpii/1_variable_preparation.egomlx` | distâncias, `ln(d+1)` e normalização |
| PCA | `01_pca_irpii/2_pca.egomlx` | análise de componentes principais |
| Soma ponderada | `01_pca_irpii/3_sum_of_pcs.egomlx` |  IRPII |
| Teste de normalidade | `01_pca_irpii/4_normality_test_submodel.egomlx` |  diagnóstico |
| Modelo SAC | `02_modelo_sac/SAC.R` | R (`spatialreg`, `spdep`) | teste estatístico |
| Forest plot | `02_modelo_sac/grafico_forest.R` · `grafico_forest_en.R` | gráfico |
| Heatmap dos PCs | `02_modelo_sac/heatmap.R` | gráfico |


---
### Capítulo 2
| Etapa | Arquivo | Uso |
|-------|-----------------|------------|
| Preparo Sentinel-2 | `01_classificacao_uso_cobertura/01_prepare_variables_sentinel2a.egomlx` |calcula os índices (NDVI, NDRE, NDWI, NBR) |
| Random Forest | `01_classificacao_uso_cobertura/02_random_forest.egomlx` | classificação usando geopackage e calcula índices de acurácia |
| Nicho ecológico | `02_nicho_maxent/maxent.egomlx` · `maxent.sh` |adequabilidade de habitat e curvas de resposta |
| Multicolinearidade | `03_sensibilidade_montecarlo/multicolinearity.R` | testa VIF |
| Cenários estocásticos | `03_sensibilidade_montecarlo/simulate_stochastic_scenarios.egomlx` | 501 simulações de Cenários estocásticos |
| Desvio-padrão | `03_sensibilidade_montecarlo/standard_deviation.egomlx` · `stdev.R` | mapa de incerteza e histograma |

---
### Como usar

**Scripts R**. Com excessão de `SAC.R` > `grafico_forest.R` todos outros scripts R são independentes.
**R** versão 4.5.1
Pacotes: 
```r

   install.packages(c("terra","sf","exactextractr","spatialreg","spdep","car","ENMeval","scico","ggplot2","ggridges","readr","readxl","dplyr","tidyr"))
```
**Modelos Dinamica EGO.** Os arquivos `.egoml`/`.egomlx` executam dentro do  Dinamica EGO:

1. Abra o `.egomlx` no Dinamica EGO (8.11)
2. Nos funtores de entrada (*Load Map* e *Load Categorical Map*), aponte o caminho para o arquivo local
3. Execute o modelo. 

---
### Ética

Este projeto trata de Povos Indígenas Isolados. A Política do Não-Contato, a Convenção 169 da OIT (Consentimento Livre, Prévio e Informado) e as regras da FUNAI/CGIIRC impedem a disponibilidade de dados sensíveis. Este repositório só apresenta os códigos de análise e geração de gráficos. 


---
### Como citar

FERNANDES, Daniel. Modelagem espacial multiescalas para a proteção de Povos Indígenas Isolados da Amazônia. Dissertação (Mestrado em Ecologia, Conservação e Manejo da Vida Silvestre) — Instituto de Ciências Biológicas, Universidade Federal de Minas Gerais, Belo Horizonte, 2026.

---
### Licença:
CC BY-NC-SA 4.0
