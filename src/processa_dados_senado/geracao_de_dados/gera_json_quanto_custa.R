library(dplyr)
library(jsonlite)

#carregando dados
data_filename = "../../dados/dados_senado.csv"
data <- read.csv2(file=data_filename, sep=",", header=FALSE, stringsAsFactors=FALSE, na.strings="unknown", dec=".", encoding = "UTF-8")
colnames(data) <-  c("id","nome","vinculo","situacao","ano_de_admissao","cargo","padrao","especialidade","mes","ano","remuneracao_basica","vantagens_pessoais","funcao_comissao","gratificacao_natalina","horas_extras","outras_remuneracoes","adicional_periculosidade","adicional_noturno","abono_permanencia","reversao","imposto_de_renda","psss","faltas","remuneracao_apos_descontos","diarias","auxilios","auxilio_alimentacao","vantagens_indenizatorias","adicional_ferias","ferias_indenizatorias","licenca_premio","remuneracao_basica_s","vantagens_pessoais_s","funcao_comissao_s","gratificacao_natalina_s","horas_extras_s","outras_remuneracoes_s","adicional_periculosidade_s","adicional_noturno_s","abono_permanencia_s","reversao_s","imposto_de_renda_s","psss_s","faltas_s","remuneracao_apos_descontos_s","diarias_s","auxilios_s","auxilio_alimentacao_s","vantagens_indenizatorias_s","adicional_ferias_s","ferias_indenizatorias_s","licenca_premio_s")

#calculando remuneração total
data <- mutate(data, remuneracao_total=remuneracao_basica + vantagens_pessoais + funcao_comissao + gratificacao_natalina + horas_extras + outras_remuneracoes + abono_permanencia + reversao + imposto_de_renda + psss + faltas + diarias + auxilios + vantagens_indenizatorias)
data <- mutate(data, remuneracao_total_s=remuneracao_basica_s + vantagens_pessoais_s + funcao_comissao_s + gratificacao_natalina_s + horas_extras_s + outras_remuneracoes_s + abono_permanencia_s + reversao_s + imposto_de_renda_s + psss_s + faltas_s + diarias_s + auxilios_s + vantagens_indenizatorias_s)
data <- mutate(data, remuneracao_total_liquida=remuneracao_total+remuneracao_total_s)

geraJson <- function(coluna){
  data_chart_cols <- c(coluna, "ano", "remuneracao_total_liquida")
  data_chart_cols <- match(data_chart_cols,names(data))
  
  #selecionando colunas a se trabalhar
  data_chart <- data %>%
    select(data_chart_cols)
  
  #renomeando pra fazer o group_by
  colnames(data_chart) <- c("name", "ano", "remuneracao_total_liquida")
  
  #gerando remuneração por coluna e por ano
  #transformando em milhao
  rem_coluna <- data_chart %>%
    group_by(ano, name) %>%
    summarize(remuneracao = sum(remuneracao_total_liquida)/1000000)
  
  #renomeando para ser usado no gráfico
  colnames(rem_coluna) <- c("d", "name", "kincaid")
  
  #gerando remuneração média
  #transformando em milhao
  avg_coluna <- rem_coluna %>%
    group_by(name) %>%
    mutate(avg_kincaid = mean(kincaid)) %>%
    ungroup()
  
  #convertendo para json
  #data para string
  avg_coluna$d <- as.character(avg_coluna$d)
  avg_coluna$d <- paste(avg_coluna$d,"12-31", sep = "-")
  
  #Passo 1: criar dataframe com as variáveis externas ao array
  df1 <- avg_coluna %>%
    select(name, avg_kincaid) %>%
    distinct(name, avg_kincaid)
  
  #Passo 2: criar dataframe com variávies internas ao array +
  #uma variável em comum com o primeiro dataframe
  df.details <- avg_coluna %>%
    select(-avg_kincaid)
  
  #Passo3: fazer o split dos dados, removendo a variável em comum
  df2 <- df1
  df2$speeches <- split(df.details[-2], df.details$name)[df1$name]
  
  #Passo4: transformação
  json_data <- toJSON(df2, pretty = T)
  
  #qc = quanto custa
  write(json_data, paste(paste("../../dados/qc_", coluna, sep = ""), ".json", sep = ""))                         
  
}

geraJson("vinculo")
geraJson("cargo")
geraJson("especialidade")