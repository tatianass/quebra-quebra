#######################################################################################################
#Autor: Ítalo de Pontes Oliveira                                                                      #
#Os CSV's são gerados mensalmente, assim, para cada arquivo de dados, uma nova variável é atribuida   #
#######################################################################################################
data_filename = "~/workspace/quebra-quebra/dados_senado_limpo.csv"

#######################################################################################################
#Por convensão, decidiu-se utilizar o formato de arquivo CSV, logo o separador sempre será a vírgula  #
#######################################################################################################
data <- read.csv2(file=data_filename, sep=",", header=FALSE, stringsAsFactors=FALSE, na.strings="unknown")
colnames(data) <-  c("id","nome","vinculo","situacao","ano_de_admissao","cargo","padrao","especialidade","mes","ano","remuneracao_basica","vantagens_pessoais","funcao_comissao","gratificacao_natalina","horas_extras","outras_remuneracoes","adicional_periculosidade","adicional_noturno","abono_permanencia","reversao","imposto_de_renda","psss","faltas","remuneracao_apos_descontos","diarias","auxilios","auxilio_alimentacao","vantagens_indenizatorias","licenca_premio","remuneracao_basica_s","vantagens_pessoais_s","funcao_comissao_s","gratificacao_natalina_s","horas_extras_s","outras_remuneracoes_s","adicional_periculosidade_s","adicional_noturno_s","abono_permanencia_s","reversao_s","imposto_de_renda_s","psss_s","faltas_s","remuneracao_apos_descontos_s","diarias_s","auxilios_s","auxilio_alimentacao_s","vantagens_indenizatorias_s","licenca_premio_s")

data$mes <- as.numeric(as.character(data$mes))
data$ano <- as.numeric(as.character(data$ano))

data$remuneracao_basica <- as.numeric(as.character(data$remuneracao_basica))/100
data$vantagens_pessoais <- as.numeric(as.character(data$vantagens_pessoais))/100
data$funcao_comissao <- as.numeric(as.character(data$funcao_comissao))/100
data$gratificacao_natalina <- as.numeric(as.character(data$gratificacao_natalina))/100
data$horas_extras <- as.numeric(as.character(data$horas_extras))/100
data$outras_remuneracoes <- as.numeric(as.character(data$outras_remuneracoes))/100
data$adicional_periculosidade <- as.numeric(as.character(data$adicional_periculosidade))/100
data$adicional_noturno <- as.numeric(as.character(data$adicional_noturno))/100
data$abono_permanencia <- as.numeric(as.character(data$abono_permanencia))/100
data$reversao <- as.numeric(as.character(data$reversao))/100                 ###############
data$imposto_de_renda <- as.numeric(as.character(data$imposto_de_renda))/100 # NEGATIVE    #
data$psss <- as.numeric(as.character(data$psss))/100                         #   VALUES    #
data$faltas <- as.numeric(as.character(data$faltas))/100                     ###############
data$remuneracao_apos_descontos <- as.numeric(as.character(data$remuneracao_apos_descontos))/100
data$diarias <- as.numeric(as.character(data$diarias))/100
data$auxilios <- as.numeric(as.character(data$auxilios))/100
data$auxilio_alimentacao <- as.numeric(as.character(data$auxilio_alimentacao))/100
data$vantagens_indenizatorias <- as.numeric(as.character(data$vantagens_indenizatorias))/100
data$licenca_premio <- as.numeric(as.character(data$licenca_premio))/100

data$remuneracao_basica_s <- as.numeric(as.character(data$remuneracao_basica_s))/100
data$vantagens_pessoais_s <- as.numeric(as.character(data$vantagens_pessoais_s))/100
data$funcao_comissao_s <- as.numeric(as.character(data$funcao_comissao_s))/100
data$gratificacao_natalina_s <- as.numeric(as.character(data$gratificacao_natalina_s))/100
data$horas_extras_s <- as.numeric(as.character(data$horas_extras_s))/100
data$outras_remuneracoes_s <- as.numeric(as.character(data$outras_remuneracoes_s))/100
data$adicional_periculosidade_s <- as.numeric(as.character(data$adicional_periculosidade_s))/100
data$adicional_noturno_s <- as.numeric(as.character(data$adicional_noturno_s))/100
data$abono_permanencia_s <- as.numeric(as.character(data$abono_permanencia_s))/100
data$reversao_s <- as.numeric(as.character(data$reversao_s))/100                  ##############
data$imposto_de_renda_s <- as.numeric(as.character(data$imposto_de_renda_s))/100  # NEGATIVE   #
data$psss_s <- as.numeric(as.character(data$psss_s))/100                          #   VALUES   #
data$faltas_s <- as.numeric(as.character(data$faltas_s))/100                      ##############
data$remuneracao_apos_descontos_s <- as.numeric(as.character(data$remuneracao_apos_descontos_s))/100
data$diarias_s <- as.numeric(as.character(data$diarias_s))/100
data$auxilios_s <- as.numeric(as.character(data$auxilios_s))/100
data$auxilio_alimentacao_s <- as.numeric(as.character(data$auxilio_alimentacao_s))/100
data$vantagens_indenizatorias_s <- as.numeric(as.character(data$vantagens_indenizatorias_s))/100
data$licenca_premio_s <- as.numeric(as.character(data$licenca_premio_s))/100

#######################################################################################################
#Gastos públicos em todos os anos (desde 2012)
#######################################################################################################
library("dplyr")

data <- mutate(data, remuneracao_total=remuneracao_basica + vantagens_pessoais + funcao_comissao + gratificacao_natalina + horas_extras + outras_remuneracoes + adicional_periculosidade + adicional_noturno + abono_permanencia + reversao + imposto_de_renda + psss + faltas + diarias + auxilios + auxilio_alimentacao + vantagens_indenizatorias + licenca_premio)
data <- mutate(data, remuneracao_total_s=remuneracao_basica_s + vantagens_pessoais_s + funcao_comissao_s + gratificacao_natalina_s + horas_extras_s + outras_remuneracoes_s + adicional_periculosidade_s + adicional_noturno_s + abono_permanencia_s + reversao_s + imposto_de_renda_s + psss_s + faltas_s + diarias_s + auxilios_s + auxilio_alimentacao_s + vantagens_indenizatorias_s + licenca_premio_s)
data <- mutate(data, remuneracao_total_liquida=remuneracao_total+remuneracao_total_s)

sum(data$remuneracao_basica, na.rm=T)       #6,286,684,115 ~ 6 bilhões
sum(data$remuneracao_total_s, na.rm=T)      #357,531,624 ~ 357 milhões
sum(data$remuneracao_total_liquida, na.rm=T)#6,394,801,513 != 6,644,215,739

#######################################################################################################
#organizando os dados por ano                                                                         #
#######################################################################################################
senado_2017 <- data[data$ano==2017,]
senado_2016 <- data[data$ano==2016,]
senado_2015 <- data[data$ano==2015,]
senado_2014 <- data[data$ano==2014,]
senado_2013 <- data[data$ano==2013,]
senado_2012 <- data[data$ano==2012,]
senado_2011 <- data[data$ano==2011,]

#######################################################################################################
#Quantos funcionários constam na folha de pagamento de cada ano?                                      #
#######################################################################################################
nrow(senado_2017) #46.164
nrow(senado_2016) #103.743
nrow(senado_2015) #102.861
nrow(senado_2014) #111.956
nrow(senado_2013) #109.511
nrow(senado_2012) #69.062
nrow(senado_2011) #0

#######################################################################################################
#Plotar boxplot
#######################################################################################################
library(reshape2)
library(ggplot2)

plotBoxplots <- function(data, fileName, variables)
{
  require(scales)
  allDatam <- data[variables]
  allDatam <- melt(allDatam)
  colnames(allDatam) <- c("grupos", "variable", "value")
  graphic <- ggplot(data=allDatam) +
    geom_boxplot(aes(x=grupos,y=value,fill=grupos)) +
    facet_wrap(~variable) +
    scale_y_continuous(labels = scales::comma)
  show(graphic)
  pdf(fileName, width=25, height=8, paper='special')
  show(graphic)
  dev.off()
}

keeps <- c("remuneracao_total","cargo")
plotBoxplots(data, "remuneracao_cargo.pdf", keeps)

keeps <- c("remuneracao_total_s","cargo")
plotBoxplots(data, "remuneracao_s_cargo.pdf", keeps)

keeps <- c("licenca_premio_s","especialidade")
plotBoxplots(data, "licenca_premio_especialidade.pdf", keeps)

keeps <- c("licenca_premio_s","cargo")
plotBoxplots(data, "licenca_premio_cargo.pdf", keeps)

keeps <- c("remuneracao_total","especialidade")
plotBoxplots(data, "remuneracao_total_especialidade.pdf", keeps)

keeps <- c("remuneracao_total_s","especialidade")
plotBoxplots(data, "remuneracao_total_s_especialidade.pdf", keeps)

keeps <- c("situacao","remuneracao_total_liquida")
plotBoxplots(data, "situacao_remuneracao_total_liquida.pdf", keeps)

keeps <- c("vinculo","remuneracao_total_liquida")
plotBoxplots(data, "vinculo_remuneracao_total_liquida.pdf", keeps)


#######################################################################################################
#Quais são os top 10 salários                                                                         #
#######################################################################################################
topSalarios <- function(data, column_ref, column_dst) {
  salariosAgregados <- aggregate(column_ref~column_dst, FUN=sum, data)
  topSalarios <- salariosAgregados[order(salariosAgregados$column_ref, decreasing=TRUE)[1:10],]
  rownames(topSalarios) <- NULL
  colnames(topSalarios) <- c("Cargo", "Remuneração após desconto")
  return(topSalarios)
}

#salariosAgregados <- aggregate(remuneracao_apos_descontos~id+cargo, FUN=sum, data)
#a<-data.frame(table(salariosAgregados[,c("cargo","id")]))

remuneracao_cargo_todos <- topSalarios(data, data$remuneracao_total, data$cargo)
remuneracao_s_cargo_todos <- topSalarios(data, data$remuneracao_total_s, data$cargo)

remuneracao_ano_todos <- topSalarios(data, data$remuneracao_total, data$ano)
remuneracao_s_ano_todos <- topSalarios(data, data$remuneracao_total_s, data$ano)

remuneracao_id_2017 <- topSalarios(senado_2017, data$remuneracao_total, data$id)
remuneracao_s_id_2017 <- topSalarios(senado_2017, data$remuneracao_total_s, data$id)

remuneracao_nome_2017 <- topSalarios(senado_2017, data$remuneracao_total, data$nome)
remuneracao_s_nome_2017 <- topSalarios(senado_2017, data$remuneracao_total_s, data$nome)

remuneracao_nome_2016 <- topSalarios(senado_2016, data$remuneracao_total, data$nome)
remuneracao_s_nome_2016 <- topSalarios(senado_2016, data$remuneracao_total_s, data$nome)

remuneracao_vinculo_2017 <- topSalarios(senado_2017, data$remuneracao_total, data$vinculo)
remuneracao_s_vinculo_2017 <- topSalarios(senado_2017, data$remuneracao_total_s, data$vinculo)

remuneracao_situacao_2017 <- topSalarios(senado_2017, data$remuneracao_total, data$situacao)
remuneracao_s_situacao_2017 <- topSalarios(senado_2017, data$remuneracao_total_s, data$situacao)

remuneracao_cargo_2017 <- topSalarios(senado_2017, data$remuneracao_total, data$cargo)
remuneracao_s_cargo_2017 <- topSalarios(senado_2017, data$remuneracao_total_s, data$cargo)

remuneracao_especialidade_2017 <- topSalarios(senado_2017, data$remuneracao_total, data$especialidade)
remuneracao_s_especialidade_2017 <- topSalarios(senado_2017, data$remuneracao_total_s, data$especialidade)

###########################################################
topSalarios <- function(data, column_ref, column_dst, column_aux) {
  salariosAgregados <- aggregate(column_ref~column_dst+column_aux, FUN=sum, data)
  topSalarios <- salariosAgregados[order(salariosAgregados$column_ref, decreasing=TRUE)[1:10],]
  rownames(topSalarios) <- NULL
  colnames(topSalarios) <- c("Cargo", "Remuneração após desconto")
  return(topSalarios)
}

remuneracao_id_2017 <- topSalarios(senado_2017, senado_2017$remuneracao_total, senado_2017$id, senado_2017$nome)
remuneracao_s_id_2017 <- topSalarios(senado_2017, senado_2017$remuneracao_total_s, senado_2017$id, senado_2017$nome)

