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
#Cria a classe contendo dados sobre a remuneracao do servidor
#################################################################################
class remuneracao:
	tipo_de_folha = "NaN"
	remuneracao_basica = 0.0
	vantagens_pessoais = 0.0
	#vantagens_eventuais = 0.0
	funcao_comissionada = 0.0
	gratificacao_natalina = 0.0
	horas_extras = 0.0
	outras_remuneracoes = 0.0
	adicional_periculosidade = 0.0
	adicional_noturno = 0.0
	abono_permanencia = 0.0
	#descontos_obrigatorios = 0.0
	reversao = 0.0
	imposto_de_renda = 0.0
	psss = 0.0
	faltas = 0.0
	remuneracao_apos_descontos = 0.0
	#vantagens_indenizatorias = 0.0
	diarias = 0.0
	auxilios = 0.0
	auxilio_alimentacao = 0.0
	vantagens_indenizatorias = 0.0
	licenca_premio = 0.0
	
	def to_string(self):
		information = str("%s," % (self.tipo_de_folha))
		information += str("%s," % (self.remuneracao_basica))
		information += str("%s," % (self.vantagens_pessoais))
		information += str("%s," % (self.funcao_comissionada))
		information += str("%s," % (self.gratificacao_natalina))
		information += str("%s," % (self.horas_extras))
		information += str("%s," % (self.outras_remuneracoes))
		information += str("%s," % (self.adicional_periculosidade))
		information += str("%s," % (self.adicional_noturno))
		information += str("%s," % (self.abono_permanencia))
		information += str("%s," % (self.reversao))
		information += str("%s," % (self.imposto_de_renda))
		information += str("%s," % (self.psss))
		information += str("%s," % (self.faltas))
		information += str("%s," % (self.remuneracao_apos_descontos))
		information += str("%s," % (self.diarias))
		information += str("%s," % (self.auxilios))
		information += str("%s," % (self.auxilio_alimentacao))
		information += str("%s," % (self.vantagens_indenizatorias))
		information += str("%s" % (self.licenca_premio))
		return information
		
		
#################################################################################
#Cria a classe servidor com informacoes obtidas no html
#################################################################################
class servidor_camara:
	user_id = 0
	nome = "NaN"
	vinculo = "NaN"
	situacao = "NaN"
	admissao = "NaN"
	cargo = "NaN"
	padrao = "NaN"
	especialidade = "NaN"
	nome_da_funcao = "NaN"
	funcao = "NaN"
	mes = 0
	ano = 0
	remuneracao_normal = remuneracao()
	remuneracao_suplementar = remuneracao()
	
	def __init__(self):
		self.remuneracao_normal = remuneracao()
		self.remuneracao_suplementar = remuneracao()
		self.remuneracao_normal.tipo_de_folha = "Normal"
		self.remuneracao_suplementar.tipo_de_folha = "Suplementar"
		
	
	def to_string(self):
		information = str("%s," % (self.user_id))
		information += str("%s," % (self.nome))
		information += str("%s," % (self.vinculo))
		information += str("%s," % (self.situacao))
		information += str("%s," % (self.admissao))
		information += str("%s," % (self.cargo))
		information += str("%s," % (self.padrao))
		information += str("%s," % (self.especialidade))
		information += str("%s," % (self.mes))
		information += str("%s," % (self.ano))
		information += str("%s," % (self.remuneracao_normal.to_string()))
		information += str("%s\n" % (self.remuneracao_suplementar.to_string()))
		return information

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
		nome_do_arquivo = sys.argv[1]
		nome_arquivo_saida = sys.argv[2]
		arquivo_de_log = sys.argv[3]
	else:
		print("Você deve chamar: %s [diretorio_entrada] [csv_saida] [log]" % (sys.argv[0]))
		sys.exit()
	
	user_id = nome_do_arquivo.split("=")[1].split("&")[0]
	data = nome_do_arquivo.split("%2F")
	mes = data[1]
	ano = data[2]
	
	try:
		page = codecs.open(nome_do_arquivo, 'r', encoding='utf-8')
		
		conteudo_arquivo = page.read().splitlines()
		dado_servidor = conteudo_arquivo[187]
		dado_servidor = dado_servidor.replace("col1tab_resposta", "col1_resposta")
		dado_servidor = dado_servidor.replace("col2_resposta\"></td>", "col2_resposta\">0,00</td>")
		dado_servidor = dado_servidor.replace("<span style=\"padding-left:20px\">", "<td class=\"col1_resposta\">")
		
		tree = html.fromstring(dado_servidor)
		
		servidor = servidor_camara()
		servidor.mes = mes
		servidor.ano = ano
		
		#Salva identificador unico do servidor
		servidor.user_id = user_id
				
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
		informacoes_servidor = tree.xpath('//div[@class="span3"]//div/text()')
		for item in informacoes_servidor:
			second_part = (item).split(": ")[-1]
			if "Nome:" in item:
				servidor.nome = second_part
			#Vínculo:
			elif "nculo:" in item:
				servidor.vinculo = second_part
			#Situação:
			elif "Situa" in item:
				servidor.situacao = second_part
			#Admissão:
			elif "Admiss" in item:
				servidor.admissao = second_part
			#Cargo/Plano:
			elif "Plano:" in item:
				servidor.cargo = second_part
			#Padrão:
			elif "Padr" in item:
				servidor.padrao = second_part
			#Especialidade:
			elif "Especialidade:" in item:
				servidor.especialidade = second_part
			#Nome da Função:
			elif "Nome da Fun" in item:
				servidor.nome_da_funcao = second_part
			#Função:
			elif "Fun" in item:
				servidor.funcao = second_part
			
			
				
		#################################################################################
		#Coleta MES e ANO
		#################################################################################
		try:
			data_referencia = tree.xpath('//div[@class="detalhe_titulo"]/text()')
			data_referencia = (data_referencia[0]).split(": ")
			data_referencia = (data_referencia[1]).split("/")
			if len(data_referencia) > 1:
				mes = data_referencia[0]
				ano = data_referencia[1]
				servidor.mes = mes
				servidor.ano = ano
		except:
			servidor.mes = mes
			servidor.ano = ano
		
		#################################################################################
		#Coleta remuneracao completa
		#################################################################################
		dados_remuneratorios = tree.xpath('//td[@class="col1_resposta"]/text()')
		folha_de_pagamento = tree.xpath('//td[@class="col2_resposta"]/text()')
		is_normal = False
		
		for tipo_dado, valor in zip(dados_remuneratorios, folha_de_pagamento):
			valor = valor.replace(",", ".")
			
			if "Tipo da Folha" in tipo_dado:
				if valor == "Normal":
					is_normal = True
				elif valor == "Suplementar":
					is_normal = False
			#Estrutura Remuneratória Básica
			elif "Estrutura Remunerat" in tipo_dado:
				if is_normal:
					servidor.remuneracao_normal.remuneracao_basica = valor
				else:
					servidor.remuneracao_suplementar.remuneracao_basica = valor
			#Vantagens Pessoais
			elif "Vantagens Pessoais" in tipo_dado:
				if is_normal:
					servidor.remuneracao_normal.vantagens_pessoais = valor
				else:
					servidor.remuneracao_suplementar.vantagens_pessoais = valor
			#Vantagens Eventuais
			#Função Comissionada
			elif "o Comissionada" in tipo_dado:
				if is_normal:
					servidor.remuneracao_normal.funcao_comissionada = valor
				else:
					servidor.remuneracao_suplementar.funcao_comissionada = valor
			#Antecipação e Gratificação Natalina
			elif "o Natalina" in tipo_dado:
				if is_normal:
					servidor.remuneracao_normal.gratificacao_natalina = valor
				else:
					servidor.remuneracao_suplementar.gratificacao_natalina = valor
			#Horas Extras
			elif "Horas Extras" in tipo_dado:
				if is_normal:
					servidor.remuneracao_normal.horas_extras = valor
				else:
					servidor.remuneracao_suplementar.horas_extras = valor
			#Outras Remunerações Eventuais/Provisórias
			elif "Outras Remunera" in tipo_dado:
				if is_normal:
					servidor.remuneracao_normal.outras_remuneracoes = valor
				else:
					servidor.remuneracao_suplementar.outras_remuneracoes = valor
			#Adicional de Periculosidade
			elif "Adicional de Periculosidade" in tipo_dado:
				if is_normal:
					servidor.remuneracao_normal.adicional_de_periculosidade = valor
				else:
					servidor.remuneracao_suplementar.outras_remuneracoes = valor
			#Adicional Noturno
			elif "Adicional Noturno" in tipo_dado:
				if is_normal:
					servidor.remuneracao_normal.adicional_noturno = valor
				else:
					servidor.remuneracao_suplementar.adicional_noturno = valor
			#Abono de Permanência
			elif "Abono de Perman" in tipo_dado:
				if is_normal:
					servidor.remuneracao_normal.abono_permanencia = valor
				else:
					servidor.remuneracao_suplementar.abono_permanencia = valor
			#Reversão do Teto Constitucional
			elif "o do Teto Constitucional" in tipo_dado:
				if is_normal:
					servidor.remuneracao_normal.reversao = valor
				else:
					servidor.remuneracao_suplementar.reversao = valor
			#Imposto de Renda
			elif "Imposto de Renda" in tipo_dado:
				if is_normal:
					servidor.remuneracao_normal.imposto_de_renda = valor
				else:
					servidor.remuneracao_suplementar.imposto_de_renda = valor
			#PSSS
			elif "PSSS" in tipo_dado:
				if is_normal:
					servidor.remuneracao_normal.psss = valor
				else:
					servidor.remuneracao_suplementar.psss = valor
			#Faltas
			elif "Faltas" in tipo_dado:
				if is_normal:
					servidor.remuneracao_normal.faltas = valor
				else:
					servidor.remuneracao_suplementar.faltas = valor
			#Remuneração Após Descontos Obrigatórios
			elif "s Descontos Obrigat" in tipo_dado:
				if is_normal:
					servidor.remuneracao_normal.remuneracao_apos_descontos = valor
				else:
					servidor.remuneracao_suplementar.remuneracao_apos_descontos = valor
			#Diárias
			elif "Di" in tipo_dado:
				if is_normal:
					servidor.remuneracao_normal.diarias = valor
				else:
					servidor.remuneracao_suplementar.diarias = valor
			#Auxílio-Alimentação
			elif "lio-Alimenta" in tipo_dado:
				if is_normal:
					servidor.remuneracao_normal.auxilio_alimentacao = valor
				else:
					servidor.remuneracao_suplementar.auxilio_alimentacao = valor
			#Auxílios
			elif "lios" in tipo_dado:
				if is_normal:
					servidor.remuneracao_normal.auxilios = valor
				else:
					servidor.remuneracao_suplementar.auxilios = valor
			#Outras Vantagens Indenizatórias
			elif "Outras Vantagens Indenizat" in tipo_dado:
				if is_normal:
					servidor.remuneracao_normal.vantagens_indenizatorias = valor
				else:
					servidor.remuneracao_suplementar.vantagens_indenizatorias = valor
			#Licença-prêmio convertida em pecúnia - aposentado
			elif "mio convertida em pec" in tipo_dado:
				if is_normal:
					servidor.remuneracao_normal.licenca_premio = valor
				else:
					servidor.remuneracao_suplementar.licenca_premio = valor

		#################################################################################
		#Salva os dados do html em um csv
		#################################################################################
		arquivo_saida = open(nome_arquivo_saida, "a")
		arquivo_saida.write(servidor.to_string())
		arquivo_saida.close()
		
		'''
		Em caso erro, salva o nome do arquivo no log
		'''	
	except:
		log = open(arquivo_de_log, "a")
		informacao_para_salvar = str("%s\n" % (nome_do_arquivo))
		log.write(informacao_para_salvar)
		log.close()
	
