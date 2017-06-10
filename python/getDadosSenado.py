from bs4 import BeautifulSoup
import urllib.request
import unicodecsv as csv

def getHTML(url):
    return urllib.request.urlopen(url, timeout=20).read()

def valorToFloat(valor):
    valor = valor.replace('.', '')
    valor = valor.replace(',', '.')
    return float(valor)

def getRemuneracao(html_valores):
	valores = []
	for str in html_valores:
	    text = ''.join(str.findAll(text=True))
	    if (text != "Normal") and (len(text) > 1):
	        valores.append(text)
	remunecaracao = []
	remunecaracao.append(valorToFloat(valores[0]))
	remunecaracao.append(valorToFloat(valores[-5]))
	return remunecaracao

def getDescricao(html_descricao):
    i = {'nome':'', 'vinculo':'', 'situacao':'', 'admissao':'', 'cargo':'', 'funcao':'', 'funcao_nome':''}
    for str in html_descricao:
        text = ''.join(str.findAll(text=True))
        i['nome'] = text.split('Nome: ')[1].split('\n')[0]
        i['vinculo'] = text.split('Vínculo: ')[1].split('\n')[0]
        i['situacao'] = text.split('Situação: ')[1].split('\n')[0]
        i['admissao'] = text.split('Admissão: ')[1].split('\n')[0]
        i['cargo'] = text.split('Cargo/Plano: ')[1].split('\n')[0]
        i['funcao'] = text.split('Função: ')[1].split('\n')[0]
        i['funcao_nome'] = text.split('Nome da Função: ')[1].split('\n')[0]
        return i

datas = ["01/05/2017","05/2017","01/04/2017","04/2017","01/03/2017","03/2017","01/02/2017","02/2017","01/01/2017","01/2017","01/12/2016","12/2016","01/11/2016","11/2016","01/10/2016","10/2016","01/09/2016","09/2016","01/08/2016","08/2016","01/07/2016","07/2016","01/06/2016","06/2016","01/05/2016","05/2016","01/04/2016","04/2016","01/03/2016","03/2016","01/02/2016","02/2016","01/01/2016","01/2016","01/12/2015","12/2015","01/11/2015","11/2015","01/10/2015","10/2015","01/09/2015","09/2015","01/08/2015","08/2015","01/07/2015","07/2015","01/06/2015","06/2015","01/05/2015","05/2015","01/04/2015","04/2015","01/03/2015","03/2015","01/02/2015","02/2015","01/01/2015","01/2015","01/12/2014","12/2014","01/11/2014","11/2014","01/10/2014","10/2014","01/09/2014","09/2014","01/08/2014","08/2014","01/07/2014","07/2014","01/06/2014","06/2014","01/05/2014","05/2014","01/04/2014","04/2014","01/03/2014","03/2014","01/02/2014","02/2014","01/01/2014","01/2014","01/12/2013","12/2013","01/11/2013","11/2013","01/10/2013","10/2013","01/09/2013","09/2013","01/08/2013","08/2013","01/07/2013","07/2013","01/06/2013","06/2013","01/05/2013","05/2013","01/04/2013","04/2013","01/03/2013","03/2013","01/02/2013","02/2013"]

html = getHTML("http://www.senado.gov.br/transparencia/rh/servidores/remuneracao.asp?fcodigo=3287645&fvinculo=&mes=01/05/2017")

with open("../dados/remuneracao.html", encoding='utf8') as fp:
    soup = BeautifulSoup(fp)
    
html_valores = soup.find_all('td', class_='col2_resposta')
valores = getRemuneracao(html_valores)

html_descricao = soup.find_all('div', class_='span3')
descricao = getDescricao(html_descricao)

with open('../dados/senado_dados.csv', 'wb') as csvfile:
    fieldnames = ['nome','vinculo','situacao','admissao','cargo','funcao','funcao_nome','remuneracao_total','remuneracao_imposto']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    writer.writeheader()
    i = {}
    i['nome'] = descricao['nome']
    i['vinculo'] = descricao['vinculo']
    i['situacao'] = descricao['situacao']
    i['admissao'] = descricao['admissao']
    i['cargo'] = descricao['cargo']
    i['funcao'] = descricao['funcao']
    i['funcao_nome'] = descricao['funcao_nome']
    i['remuneracao_total'] = valores[0]
    i['remuneracao_imposto'] = valores[1]
    writer.writerow(i)
        
        
        
