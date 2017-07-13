#Autor: Ítalo de Pontes
#Os CSV's são gerados mensalmente, assim, para cada arquivo de dados, uma nova variável é atribuida
mes01 = "~/Dropbox/quebraquebra/camara/2015/RemuneracaoMensalServidores012015.csv"
mes02 = "~/Dropbox/quebraquebra/camara/2015/RemuneracaoMensalServidores022015.csv"
mes03 = "~/Dropbox/quebraquebra/camara/2015/RemuneracaoMensalServidores032015.csv"
mes04 = "~/Dropbox/quebraquebra/camara/2015/RemuneracaoMensalServidores042015.csv"
mes05 = "~/Dropbox/quebraquebra/camara/2015/RemuneracaoMensalServidores052015.csv"
mes06 = "~/Dropbox/quebraquebra/camara/2015/RemuneracaoMensalServidores062015.csv"
mes07 = "~/Dropbox/quebraquebra/camara/2015/RemuneracaoMensalServidores072015.csv"
mes08 = "~/Dropbox/quebraquebra/camara/2015/RemuneracaoMensalServidores082015.csv"
mes09 = "~/Dropbox/quebraquebra/camara/2015/RemuneracaoMensalServidores092015.csv"
mes10 = "~/Dropbox/quebraquebra/camara/2015/RemuneracaoMensalServidores102015.csv"
mes11 = "~/Dropbox/quebraquebra/camara/2015/RemuneracaoMensalServidores112015.csv"
mes12 = "~/Dropbox/quebraquebra/camara/2015/RemuneracaoMensalServidores122015.csv"

#Por convensão, decidiu-se utilizar o formato de arquivo CSV, logo
#o separador sempre será a vírgula. Essa decisão foi inspirada nos
#modelos fornecidos pela própria câmara, disponível em:
#http://www2.camara.leg.br/transparencia/recursos-humanos/remuneracao/relatorios-consolidados-por-ano-e-mes/esclarecimentos-consulta-remuneracao
janeiro <- read.csv(file=mes01, sep=";", header=FALSE, skip=1) #Skip o header
fevereiro <- read.csv(file=mes02, sep=";", header=FALSE, skip=1)
marco <- read.csv(file=mes03, sep=";", header=FALSE, skip=1)
abril <- read.csv(file=mes04, sep=";", header=FALSE, skip=1)
maio <- read.csv(file=mes05, sep=";", header=FALSE, skip=1)
junho <- read.csv(file=mes06, sep=";", header=FALSE, skip=1)
julho <- read.csv(file=mes07, sep=";", header=FALSE, skip=1)
agosto <- read.csv(file=mes08, sep=";", header=FALSE, skip=1)
setembro <- read.csv(file=mes09, sep=";", header=FALSE, skip=1)
outubro <- read.csv(file=mes10, sep=";", header=FALSE, skip=1)
novembro <- read.csv(file=mes11, sep=";", header=FALSE, skip=1)
dezembro <- read.csv(file=mes12, sep=";", header=FALSE, skip=1)

#Adiciona coluna mes a todos os dados e concatena em uma só variável
janeiro$mes <- 1
fevereiro$mes <- 2
marco$mes <- 3
abril$mes <- 4
maio$mes <- 5
junho$mes <- 6
julho$mes <- 7
agosto$mes <- 8
setembro$mes <- 9
outubro$mes <- 10
novembro$mes <- 11
dezembro$mes <- 12
data <- rbind(janeiro,fevereiro,marco,abril,maio,junho,julho,agosto,setembro,outubro,novembro,dezembro)
colnames(data) <-  c("cargo","grupo_funcional","folha_pagamento","ano_ingresso","remuneracao_fixa","vantagens_pessoais","funcao_comissao","gratificacao_natalina","ferias","remuneracoes_eventuais","abono_permanencia","redutor_constitucional","previdencia","imposto_renda","remuneracao_apos_desconto","diarias","auxilios","vantagens_indenizatorias", "mes")
rm(list= ls()[!(ls() %in% c('data'))])

#Quantos funcionários constam na folha de pagamento de cada mês?
nrow(data[data$mes==1,])
nrow(data[data$mes==2,])
nrow(data[data$mes==3,])
nrow(data[data$mes==4,])
nrow(data[data$mes==5,])
nrow(data[data$mes==6,])
nrow(data[data$mes==7,])
nrow(data[data$mes==8,])
nrow(data[data$mes==9,])
nrow(data[data$mes==10,])
nrow(data[data$mes==11,])
nrow(data[data$mes==12,])

#Quantos milhões/bilhões são pagos mensalmente?
sum(janeiro$remuneracao_fixa)

#Qual total anual? 

#Quais são os top 10 salários em 2016 (no geral)

#Quais cargos mais bem remunerados?

#Quantos deputados receberam no ano X acima do teto (33k)?



