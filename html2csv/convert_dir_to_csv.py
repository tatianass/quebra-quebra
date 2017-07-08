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
import os
import sys
from lxml import html
import requests

#################################################################################
#Adiciona zeros em alguns casos que faltam tais informações
#################################################################################
def append_zeros(data_servidor):
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
	return dados_servidor

'''
#################################################################################
# Funcao 'main'
#################################################################################
'''
if __name__ == '__main__':
	############################################################
	#Passing all arguments
	############################################################
	if len(sys.argv) == 4:
		diretorio_de_htmls = sys.argv[1]
		nome_arquivo_saida = sys.argv[2]
		arquivo_de_log = sys.argv[3]
	else:
		print("Você deve chamar: %s [diretorio_entrada] [csv_saida] [log]" % (sys.argv[0]))
		sys.exit()
	
	todos_arquivos = os.listdir(diretorio_de_htmls)
	
	for nome_arquivo in todos_arquivos:

		user_id = nome_arquivo.split("=")[1].split("&")[0]
		
		nome_do_arquivo = str("%s/%s" % (diretorio_de_htmls, nome_arquivo))

		mes = nome_do_arquivo.split("%2F")[1]
		
		ano = nome_do_arquivo.split("%2F")[2]
		
		try:
		
			page = codecs.open(nome_do_arquivo, 'r', encoding='utf-8')

			conteudo_arquivo = page.read().splitlines()

			tree = html.fromstring(conteudo_arquivo[187])

			dados_servidor = list()
		
			#Salva identificador unico do servidor
			dados_servidor.append(user_id)
		
			#################################################################################
			#Coleta (07) informações básicas do servidor:
			#	* Nome (e.g., Fulano de Tal)
			#	* Vínculo (e.g., Efetivo)
			#	* Situação (e.g., Aposentado)
			#	* Admissão (e.g., 1980)
			#	* Cargo/Plano: (e.g., IPC)
			#	* Padrão (e.g., SVAL, S45)
			#	* Especialidade (e.g., Aposetadoria Servidor IPC/PSSC)
			#################################################################################
			'''
			informacoes_servidor = tree.xpath('//div[@class="span3"]//div/text()')
			for index, item in enumerate(informacoes_servidor):
				if index == 7:
					break
				item = (item).split(": ")[-1]
				if item == "":
					item = "NaN"
				dados_servidor.append(item)

			#################################################################################
			#Coleta MES e ANO
			#################################################################################
			try:
				data_referencia = tree.xpath('//div[@class="detalhe_titulo"]/text()')
				data_referencia = (data_referencia[0]).split(": ")
				data_referencia = (data_referencia[1]).split("/")
				if len(data_referencia) > 1:
					dados_servidor.append(data_referencia[0])
					dados_servidor.append(data_referencia[1])
			except:
				dados_servidor.append(mes)
				dados_servidor.append(ano)
			
			'''
			#################################################################################
			#Coleta remuneracao completa
			#################################################################################
			
			'''
			tem_normal = False
			tem_suplementar = False
			try:
				folha_de_pagamento = tree.xpath('//td[@class="col2_resposta"]/text()')
				
				for index, dado in enumerate(folha_de_pagamento):
					if dado == "Normal":
						tem_normal = True
					if dado == "Suplementar":
						#Alguns servidores nao possuem remuneracao 'normal' ou 'suplementar',
						# de tal maneira, para deixarmos todos equivalentes,
						#adicionamos o valor 0 para todos que nao possuem
						if not tem_normal:
							dados_servidor.append("Normal")
							dados_servidor = append_zeros(dados_servidor)
						tem_suplementar = True
					dados_servidor.append(dado)
			
				if not tem_suplementar:
					dados_servidor.append("Suplementar")
					dados_servidor = append_zeros(dados_servidor)
			except:
				if not tem_normal:
					dados_servidor.append("Normal")
					dados_servidor = append_zeros(dados_servidor)
				if not tem_suplementar:
					dados_servidor.append("Suplementar")
					dados_servidor = append_zeros(dados_servidor)
			'''
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
			
			'''
			Em caso erro, salva o nome do arquivo no log
			'''	
		except:
			log = open(arquivo_de_log, "a")
			informacao_para_salvar = str("%s\n" % (nome_do_arquivo))
			log.write(informacao_para_salvar)
			log.close()
	
