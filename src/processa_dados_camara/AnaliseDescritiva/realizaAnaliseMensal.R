#Autor: Ítalo de Pontes
#Os CSV's são gerados mensalmente, assim, para cada arquivo de dados, uma nova variável é atribuida
#Input in UTF-8 format
mesReferencia = "~/Dropbox/quebraquebra/camara/2015/RemuneracaoMensalServidores012015.csv"

#Por convensão, decidiu-se utilizar o formato de arquivo CSV, logo
#o separador sempre será a vírgula. Essa decisão foi inspirada nos
#modelos fornecidos pela própria câmara, disponível em:
#http://www2.camara.leg.br/transparencia/recursos-humanos/remuneracao/relatorios-consolidados-por-ano-e-mes/esclarecimentos-consulta-remuneracao
#Read without 'factors': https://stackoverflow.com/questions/5187745/imported-a-csv-dataset-to-r-but-the-values-becomes-factors
data <- read.csv2(file=mesReferencia, sep=";", header=FALSE, stringsAsFactors=FALSE, na.strings="unknown", skip=1) #Skip o header

#dec="." <- testar isso

###########################################################
#Adiciona coluna mes a todos os dados e concatena em uma só variável
###########################################################
colnames(data) <-  c("cargo","grupo_funcional","folha_pagamento","ano_ingresso","remuneracao_fixa","vantagens_pessoais","funcao_comissao","gratificacao_natalina","ferias","remuneracoes_eventuais","abono_permanencia","redutor_constitucional","previdencia","imposto_renda","remuneracao_apos_desconto","diarias","auxilios","vantagens_indenizatorias")

###########################################################
#Quantos funcionários constam na folha de pagamento deste mês?
###########################################################
qntdServidores <- nrow(data)

###########################################################
#Quantos milhões/bilhões são pagos mensalmente em <...>?
###########################################################
sum(data$remuneracao_fixa)
sum(data$vantagens_pessoais)
sum(data$funcao_comissao)
sum(data$gratificacao_natalina)
sum(data$ferias)
sum(data$remuneracoes_eventuais)
sum(data$abono_permanencia)
sum(data$redutor_constitucional)
#previdencia
#imposto_renda
sum(data$remuneracao_apos_desconto)
sum(data$diarias)
sum(data$auxilios)
sum(data$vantagens_indenizatorias)

###########################################################
#Qual total mensal?                                       #
###########################################################
sum(data$remuneracao_fixa,data$vantagens_pessoais,data$funcao_comissao,data$gratificacao_natalina,data$ferias,data$remuneracoes_eventuais,data$abono_permanencia,data$redutor_constitucional,data$previdencia,data$imposto_renda,data$diarias,data$auxilios,data$vantagens_indenizatorias)
#Removido "Remuneração apos descontos"

###########################################################
#Quais são os top 10 salários em 2016 (no geral)          #
###########################################################
salariosAgregados <- aggregate(remuneracao_apos_desconto~cargo, FUN=sum, data)
topSalarios <- salariosAgregados[order(salariosAgregados$remuneracao_apos_desconto, decreasing=TRUE)[1:10],]
rownames(topSalarios) <- NULL
colnames(topSalarios) <- c("Cargo", "Remuneracao após desconto")
topSalarios

###########################################################
#Quais cargos mais bem remunerados?                       #
###########################################################
library("dplyr")

topSalariosFunction <- function(data)
{
  salariosAgregados <- aggregate(remuneracao_apos_desconto~cargo, FUN=sum, data)
  topSalarios <- salariosAgregados[order(salariosAgregados$remuneracao_apos_desconto, decreasing=TRUE)[1:10],]
  rownames(topSalarios) <- NULL
  colnames(topSalarios) <- c("Cargo", "Remuneracao")
  return(topSalarios)
}


soAnalista <- filter(data, grepl("Analista Legislativo", cargo))
soTecnico <- filter(data, !grepl("cnico", cargo))
soSecretario <- filter(data, grepl("Secret", cargo))
soNaturezaEspecial <- filter(data, grepl("Cargo de Natureza Especial", cargo))
soDeputado <- filter(data, grepl("Deputado", cargo))

analistas <- topSalariosFunction(soAnalista)
tecnicos <- topSalariosFunction(soTecnico)
#secretarios <- topSalariosFunction(soSecretario)
especiais <- topSalariosFunction(soNaturezaEspecial)
deputado <- topSalariosFunction(soDeputado)

###########################################################
#Quantos deputados receberam no ano X acima do teto (33k)?
###########################################################
#install.packages("plotly")
library(plotly)
p <- plot_ly(y= data[data$mes=="1",]$remuneracao_total, type="box", name="Janeiro") %>%
  add_trace(y= deputadosAno2017[deputadosAno2017$mes=="2",]$remuneracao_total, name="Fevereiro") %>%
  add_trace(y= deputadosAno2017[deputadosAno2017$mes=="3",]$remuneracao_total, name="Marco") %>%
  add_trace(y= deputadosAno2017[deputadosAno2017$mes=="4",]$remuneracao_total, name="Abril") %>%
  layout(title="Remuneracao Total em 2017", xaxis=list(title="Mes"), yaxis=list(title="Valor Recebido"))
show(p)
