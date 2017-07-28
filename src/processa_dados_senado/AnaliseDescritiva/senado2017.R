#######################################################################################################
#Autor: Ítalo de Pontes Oliveira                                                                      #
#Os CSV's são gerados mensalmente, assim, para cada arquivo de dados, uma nova variável é atribuida   #
#######################################################################################################
data_filename = "../../../senado_federal/dados/dados_senado.csv"

#######################################################################################################
#Por convensão, decidiu-se utilizar o formato de arquivo CSV, logo o separador sempre será a vírgula  #
#######################################################################################################
data <- read.csv2(file=data_filename, sep=",", header=FALSE, stringsAsFactors=FALSE, na.strings="unknown", dec=".")
colnames(data) <-  c("id","nome","vinculo","situacao","ano_de_admissao","cargo","padrao","especialidade","mes","ano","remuneracao_basica","vantagens_pessoais","funcao_comissao","gratificacao_natalina","horas_extras","outras_remuneracoes","adicional_periculosidade","adicional_noturno","abono_permanencia","reversao","imposto_de_renda","psss","faltas","remuneracao_apos_descontos","diarias","auxilios","auxilio_alimentacao","vantagens_indenizatorias","adicional_ferias","ferias_indenizatorias","licenca_premio","remuneracao_basica_s","vantagens_pessoais_s","funcao_comissao_s","gratificacao_natalina_s","horas_extras_s","outras_remuneracoes_s","adicional_periculosidade_s","adicional_noturno_s","abono_permanencia_s","reversao_s","imposto_de_renda_s","psss_s","faltas_s","remuneracao_apos_descontos_s","diarias_s","auxilios_s","auxilio_alimentacao_s","vantagens_indenizatorias_s","adicional_ferias_s","ferias_indenizatorias_s","licenca_premio_s")

#######################################################################################################
#Quanto foi pago em remuneração em 2017?
#######################################################################################################
library("dplyr")

data <- mutate(data, remuneracao_total=remuneracao_basica + vantagens_pessoais + funcao_comissao + gratificacao_natalina + horas_extras + outras_remuneracoes + adicional_periculosidade + adicional_noturno + abono_permanencia + reversao + imposto_de_renda + psss + faltas + diarias + auxilios + auxilio_alimentacao + vantagens_indenizatorias + adicional_ferias + ferias_indenizatorias + licenca_premio)
data <- mutate(data, remuneracao_total_s=remuneracao_basica_s + vantagens_pessoais_s + funcao_comissao_s + gratificacao_natalina_s + horas_extras_s + outras_remuneracoes_s + adicional_periculosidade_s + adicional_noturno_s + abono_permanencia_s + reversao_s + imposto_de_renda_s + psss_s + faltas_s + diarias_s + auxilios_s + auxilio_alimentacao_s + vantagens_indenizatorias_s + adicional_ferias_s + ferias_indenizatorias_s + licenca_premio_s)
data <- mutate(data, remuneracao_total_liquida=remuneracao_total+remuneracao_total_s)

nrow(data) #46,164 = 46164

sum(data$remuneracao_total, na.rm=T)        #520,648,967 = 520648967
sum(data$remuneracao_total_s, na.rm=T)      #31,284,518 = 31284518
sum(data$remuneracao_total_liquida, na.rm=T)#551,933,485 = 551933485

#######################################################################################################
#Qual a representatividade de aposentados?
#Em remuneração e em quantidade? Mais representação em porcetagem
#######################################################################################################
aposentados_2017 <- filter(data, grepl("APOSENTADO", situacao))

nrow(aposentados_2017) #13,071 = 13071 (28,31%)

sum(aposentados_2017$remuneracao_total, na.rm=T)        #266,028,494 = 266028494 (51,1%)
sum(aposentados_2017$remuneracao_total_s, na.rm=T)      #26,564,406 = 26564406 (84,91%)
sum(aposentados_2017$remuneracao_total_liquida, na.rm=T)#292,592,900 = 292592900 (53%)

#######################################################################################################
#Quanto de licença prêmio foi pago?
#######################################################################################################
sum(data$licenca_premio)    #0
sum(data$licenca_premio_s)  #10,841,166 = 10841166

sum(aposentados_2017$licenca_premio_s)  #10,841,166 = 10841166 (100%)
                                        #remuneração total líquida dos aposentados / licença prêmio
                                        #10841166 / 292592900 = (3,7%)

topSalariosFunc <- function(salariosAgregados, column_ref, title) {
  topSalarios <- salariosAgregados[order(column_ref, decreasing=TRUE)[1:10],]
  rownames(topSalarios) <- NULL
  colnames(topSalarios) <- title
  return(topSalarios)
}

#APOSENTADOS 2017
salariosAgregados <- aggregate(licenca_premio_s~nome+cargo+id+ano_de_admissao, FUN=sum, aposentados_2017)
keeps <- c("Nome", "Cargo", "Id", "Ano de Admissão", "Licença Prêmio")
topSalarios <- topSalariosFunc(salariosAgregados, salariosAgregados$licenca_premio_s,  keeps)

#SERVIDORES 2017
salariosAgregados <- aggregate(licenca_premio_s~cargo, FUN=sum, data)
keeps <- c("Cargo", "Licença Prêmio")
topSalarios <- topSalariosFunc(salariosAgregados, salariosAgregados$licenca_premio_s, keeps)
topSalarios # Tecnico, Analista e Consultor
            # 5.2, 5.0, 0.56 milhões

#######################################################################################################
#Quais são os tops em cada cargo?
#Advogado, administração, médico, psicólogo, etc
#Comparar com salários médios no setor privado
#######################################################################################################

install.packages("DT")
library("DT")
install.packages("shiny")
install.packages("flexdashboard")
library(flexdashboard)
topSalarios <- function(salariosAgregados, column_ref, keeps) {
  topSalarios <- salariosAgregados[order(column_ref, decreasing=TRUE)[1:10],]
  rownames(topSalarios) <- NULL
  colnames(topSalarios) <- keeps
  return(topSalarios)
}

keeps <- c("Cargo", "Remuneração após desconto")
salariosAgregados <- aggregate(remuneracao_total_liquida~nome+cargo+ano_de_admissao, FUN=sum, data)
top_servidores_licenca_premio <- topSalarios(salariosAgregados, salariosAgregados$remuneracao_total_liquida, keeps)
top_servidores_licenca_premio

library("knitr")
library("dplyr")

data <- mutate(data, remuneracao_total=remuneracao_basica + vantagens_pessoais + funcao_comissao + gratificacao_natalina + horas_extras + outras_remuneracoes + adicional_periculosidade + adicional_noturno + abono_permanencia + reversao + imposto_de_renda + psss + faltas + diarias + auxilios + auxilio_alimentacao + vantagens_indenizatorias + adicional_ferias + ferias_indenizatorias + licenca_premio)
data <- mutate(data, remuneracao_total_s=remuneracao_basica_s + vantagens_pessoais_s + funcao_comissao_s + gratificacao_natalina_s + horas_extras_s + outras_remuneracoes_s + adicional_periculosidade_s + adicional_noturno_s + abono_permanencia_s + reversao_s + imposto_de_renda_s + psss_s + faltas_s + diarias_s + auxilios_s + auxilio_alimentacao_s + vantagens_indenizatorias_s + adicional_ferias_s + ferias_indenizatorias_s + licenca_premio_s)
data <- mutate(data, remuneracao_total_liquida=remuneracao_total+remuneracao_total_s)

sum(data$remuneracao_total, na.rm=T)        #520,648,967 = 520648967
sum(data$remuneracao_total_s, na.rm=T)      #31,284,518 = 31284518

ano_max <- max(data$ano)
ano_min <- min(data$ano)

options(scipen=999, OutDec= ",")

senado_recente <- data[data$ano==ano_max,]

remuneracao_total_liquida <- sum(data$remuneracao_total_liquida, na.rm=T)


aposentados_recente <- senado_recente[senado_recente$situacao=="APOSENTADO",]
aposentados_totais <- data[data$situacao=="APOSENTADO",]

receita_total_recente <- sum(senado_recente$remuneracao_total_liquida)
receita_aposentados_todos <- sum(aposentados_totais$remuneracao_total_liquida)
receita_aposentados_recente <- sum(aposentados_recente$remuneracao_total_liquida)



library("ggplot2")
demais_servidores_total <- remuneracao_total_liquida-receita_aposentados_todos
demais_servidores_recente <- receita_total_recente-receita_aposentados_recente

df2 <- data.frame(data=rep(c(ano_max, "Todos os Anos"), each=2),
                  situacao=rep(c("Aposentados", "Demais Servidores"),2),
                  remuneracao=c(receita_aposentados_recente/10^9, demais_servidores_recente/10^9, receita_aposentados_todos/10^9, demais_servidores_total/10^9))

g <- ggplot(data=df2, aes(x=data, y=remuneracao, fill=situacao)) +
  geom_bar(stat="identity", position=position_dodge(width=0.6), width=0.5) +
  theme_minimal() +
  labs(title="Remuneração dos Pensionistas", 
       x="Data de Referência", y = "Remuneração em Bilhões de Reais",
       fill = "Situação")

library(ggplot2)
library(plotly) 
packageVersion("plotly")
help(signup())

p <- ggplot(iris, aes(Sepal.Length, Petal.Length, colour=Species)) + geom_point()
p
library(plotly)
ggplotly(p)
ggplotly(g)
dolibrary(ggplot2)

Sys.setenv("plotly_username"="italooliveira")
Sys.setenv("plotly_api_key"="pJKE0nesUNVr1HveyY3i")





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

#######################################################################################################
#3 variáveis
#######################################################################################################
topSalarios <- function(data, column_ref, column_dst, column_aux) {
  salariosAgregados <- aggregate(column_ref~column_dst+column_aux, FUN=sum, data)
  topSalarios <- salariosAgregados[order(salariosAgregados$column_ref, decreasing=TRUE)[1:10],]
  rownames(topSalarios) <- NULL
  colnames(topSalarios) <- c("Cargo", "Remuneração após desconto")
  return(topSalarios)
}

remuneracao_id_2017 <- topSalarios(data, data$remuneracao_total, data$id, data$nome)
remuneracao_s_id_2017 <- topSalarios(data, senado_2017$remuneracao_total_s, senado_2017$id, senado_2017$nome)

#######################################################################################################
#4 variáveis
#######################################################################################################
topSalarios <- function(data, column_ref, column_dst, column_aux, column_aux2) {
  salariosAgregados <- aggregate(column_ref~column_dst+column_aux+column_aux2, FUN=sum, data)
  topSalarios <- salariosAgregados[order(salariosAgregados$column_ref, decreasing=TRUE)[1:10],]
  rownames(topSalarios) <- NULL
  colnames(topSalarios) <- c("Cargo", "Remuneração após desconto")
  return(topSalarios)
}

remuneracao_id_2017 <- topSalarios(data, data$remuneracao_total, data$id, data$nome, data$especialidade)
