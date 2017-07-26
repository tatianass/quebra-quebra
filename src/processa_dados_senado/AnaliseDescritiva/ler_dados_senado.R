data_filename = "../../../senado_federal/dados/dados_senado.csv"
data <- read.csv2(file=data_filename, sep=",", header=FALSE, stringsAsFactors=FALSE, na.strings="unknown", dec=".")
colnames(data) <-  c("id","nome","vinculo","situacao","ano_de_admissao","cargo","padrao","especialidade","mes","ano","remuneracao_basica","vantagens_pessoais","funcao_comissao","gratificacao_natalina","horas_extras","outras_remuneracoes","adicional_periculosidade","adicional_noturno","abono_permanencia","reversao","imposto_de_renda","psss","faltas","remuneracao_apos_descontos","diarias","auxilios","auxilio_alimentacao","vantagens_indenizatorias","adicional_ferias","ferias_indenizatorias","licenca_premio","remuneracao_basica_s","vantagens_pessoais_s","funcao_comissao_s","gratificacao_natalina_s","horas_extras_s","outras_remuneracoes_s","adicional_periculosidade_s","adicional_noturno_s","abono_permanencia_s","reversao_s","imposto_de_renda_s","psss_s","faltas_s","remuneracao_apos_descontos_s","diarias_s","auxilios_s","auxilio_alimentacao_s","vantagens_indenizatorias_s","adicional_ferias_s","ferias_indenizatorias_s","licenca_premio_s")


library(plotly)
10^3
