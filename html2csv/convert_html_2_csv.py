#coding=utf-8
#################################################################################
#Author: Italo de Pontes Oliveira						#
#Based on Spotipy API								#
#created in: 08, july, 2017							#
#e-mail: italooliveira at copin dot ufcg dot edu dot br				#
#Github link: github.com/italoPontes/PhdWorks					#
#Whatsapp: +55 83 993 554 224							#
#################################################################################
import codecs
import io
import sys
from lxml import html
import requests

'''
#################################################################################
# Funcao 'main'
#################################################################################
'''
if __name__ == '__main__':
	############################################################
	#Passing all arguments
	############################################################
	if len(sys.argv) == 3:
		nome_arquivo_entrada = sys.argv[1]
		nome_arquivo_saida = sys.argv[2]
	else:
		print("Você deve chamar: %s [html_entrada] [csv_saida]" % (sys.argv[0]))
		sys.exit()
	
	page = codecs.open(nome_arquivo_entrada, 'r', encoding='utf-8')

	conteudo_arquivo = page.read().splitlines()

	tree = html.fromstring(conteudo_arquivo[187])

	dados_servidor = list()

	#################################################################################
	#Coleta informações básicas do servidor:
	#	* Nome (e.g., Fulano de Tal)
	#	* Vínculo (e.g., Efetivo)
	#	* Situação (e.g., Aposentado)
	#	* Admissão (e.g., 1980)
	#	* Cargo/Plano: (e.g., IPC)
	#	* Padrão (e.g., SVAL, S45)
	#	* Especialidade (e.g., Aposetadoria Servidor IPC/PSSC)
	#################################################################################
	informacoes_servidor = tree.xpath('//div[@class="span3"]//div/text()')
	for item in informacoes_servidor:
		dados_servidor.append((item).split(": ")[-1])

	#################################################################################
	#Coleta MES e ANO
	#################################################################################
	data_referencia = tree.xpath('//div[@class="detalhe_titulo"]/text()')
	data_referencia = (data_referencia[0]).split(": ")
	mes = (data_referencia[1]).split("/")[0]
	ano = (data_referencia[1]).split("/")[1]
	dados_servidor.append(mes)
	dados_servidor.append(ano)

	#################################################################################
	#Coleta remuneracao completa
	#################################################################################
	folha_de_pagamento = tree.xpath('//td[@class="col2_resposta"]/text()')
	for dado in folha_de_pagamento:
		dados_servidor.append(dado)
	#Alguns servidores nao possuem remuneracao 'suplementar', de tal maneira, para
	#deixarmos todos equivalentes, adicionamos o valor 0 para todos que nao possuem
	if len(dados_servidor) == 25:
		dados_servidor.append("Suplementar")
		dados_servidor.append("0.00")
		dados_servidor.append("0.00")
		dados_servidor.append("0.00")
		dados_servidor.append("0.00")
		dados_servidor.append("0.00")
		dados_servidor.append("0.00")
		dados_servidor.append("0.00")
		dados_servidor.append("0.00")
		dados_servidor.append("0.00")
		dados_servidor.append("0.00")
		dados_servidor.append("0.00")
		dados_servidor.append("0.00")
		dados_servidor.append("0.00")
		dados_servidor.append("0.00")
		dados_servidor.append("0.00")
	
	#################################################################################
	#Salva os dados do html em um csv
	#################################################################################
	arquivo_saida = open(nome_arquivo_saida, "a")
	ultima_posicao = (len(dados_servidor)-1)
	for pos, item in enumerate(dados_servidor):
		item = item.encode('utf-8')
		item = item.replace(',', '.')
		arquivo_saida.write(item)
		if pos != ultima_posicao:
			arquivo_saida.write(",")
		else:
			arquivo_saida.write("\n")
	arquivo_saida.close()
	
