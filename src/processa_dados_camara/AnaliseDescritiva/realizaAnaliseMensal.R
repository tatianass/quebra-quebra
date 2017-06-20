#Autor: Ítalo de Pontes
#Os CSV's são gerados mensalmente, assim, para cada arquivo de dados, uma nova variável é atribuida
mesReferencia = "~/Dropbox/quebraquebra/camara/2015/RemuneracaoMensalServidores012015.csv"

#Por convensão, decidiu-se utilizar o formato de arquivo CSV, logo
#o separador sempre será a vírgula. Essa decisão foi inspirada nos
#modelos fornecidos pela própria câmara, disponível em:
#http://www2.camara.leg.br/transparencia/recursos-humanos/remuneracao/relatorios-consolidados-por-ano-e-mes/esclarecimentos-consulta-remuneracao
data <- read.csv(file=mesReferencia, sep=";", header=FALSE, skip=1) #Skip o header

#Adiciona coluna mes a todos os dados e concatena em uma só variável
colnames(data) <-  c("cargo","grupo_funcional","folha_pagamento","ano_ingresso","remuneracao_fixa","vantagens_pessoais","funcao_comissao","gratificacao_natalina","ferias","remuneracoes_eventuais","abono_permanencia","redutor_constitucional","previdencia","imposto_renda","remuneracao_apos_desconto","diarias","auxilios","vantagens_indenizatorias")

#Quantos funcionários constam na folha de pagamento de cada mês?
nrow(data)

#Quantos milhões/bilhões são pagos mensalmente?

#Qual total anual? 

#Quais são os top 10 salários em 2016 (no geral)

#Quais cargos mais bem remunerados?

#Quantos deputados receberam no ano X acima do teto (33k)?



