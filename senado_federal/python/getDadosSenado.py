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
        i['nome'] = text.split('Nome: ')[1].split('Vínculo')[0]
        i['vinculo'] = text.split('Vínculo: ')[1].split('Situação')[0]
        i['situacao'] = text.split('Situação: ')[1].split('Admissão')[0]
        i['admissao'] = text.split('Admissão: ')[1].split('Cargo/Plano')[0]
        try:
            i['cargo'] = text.split('Cargo/Plano: ')[1].split('Função')[0]
            i['funcao'] = text.split('Função: ')[1].split('Nome da Função')[0]
            i['funcao_nome'] = text.split('Nome da Função: ')[1].split('\n')[0]
        except Exception:
            i['cargo'] = text.split('Cargo/Plano: ')[1].split('Padrão')[0]
            i['funcao'] = text.split('Padrão: ')[1].split('Especialidade')[0]
            i['funcao_nome'] = text.split('Especialidade: ')[1].split('\n')[0]
        return i

#datas = ["01/05/2017","05/2017","01/04/2017","04/2017","01/03/2017","03/2017","01/02/2017","02/2017","01/01/2017","01/2017","01/12/2016","12/2016","01/11/2016","11/2016","01/10/2016","10/2016","01/09/2016","09/2016","01/08/2016","08/2016","01/07/2016","07/2016","01/06/2016","06/2016","01/05/2016","05/2016","01/04/2016","04/2016","01/03/2016","03/2016","01/02/2016","02/2016","01/01/2016","01/2016","01/12/2015","12/2015","01/11/2015","11/2015","01/10/2015","10/2015","01/09/2015","09/2015","01/08/2015","08/2015","01/07/2015","07/2015","01/06/2015","06/2015","01/05/2015","05/2015","01/04/2015","04/2015","01/03/2015","03/2015","01/02/2015","02/2015","01/01/2015","01/2015","01/12/2014","12/2014","01/11/2014","11/2014","01/10/2014","10/2014","01/09/2014","09/2014","01/08/2014","08/2014","01/07/2014","07/2014","01/06/2014","06/2014","01/05/2014","05/2014","01/04/2014","04/2014","01/03/2014","03/2014","01/02/2014","02/2014","01/01/2014","01/2014","01/12/2013","12/2013","01/11/2013","11/2013","01/10/2013","10/2013","01/09/2013","09/2013","01/08/2013","08/2013","01/07/2013","07/2013","01/06/2013","06/2013","01/05/2013","05/2013","01/04/2013","04/2013","01/03/2013","03/2013","01/02/2013","02/2013"]
codigos = ["2915421","2210983","2130980","2109000","2145715","2049716","2090201","2126435","2193604","3287645","3125564","2027682","2027704","3347516","2683857","2407949","2387077","3383334","2323982","2226260","2044706","2235994","2301300","2242508","2144654","2296918","3367070","2142635","2203782","2837846","2117401","3171710","2365588","2179636","2276992","2123711","2261456","2606640","2324059","2062658","2229269","2057298","2057263","2106213","2150522","2191164","2236109","3292681","2278740","2091739"]
datas = ['01%2F05%2F2017', '01%2F04%2F2017', '01%2F03%2F2017', '01%2F02%2F2017', '01%2F01%2F2017']

with open('../dados/senado_dados.csv', 'wb') as csvfile:
    fieldnames = ['nome','vinculo','situacao','admissao','cargo','funcao','funcao_nome','remuneracao_total','remuneracao_imposto']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    writer.writeheader()
    for data in datas:
        for codigo in codigos:
            try:
                with open("../dados/remuneracao/remuneracao.asp_fcodigo=" + codigo + "%0D&fvinculo=&mes=" + data, encoding='utf8') as fp:
                    soup = BeautifulSoup(fp)
                    
                html_valores = soup.find_all('td', class_='col2_resposta')
                if(len(html_valores)!=0):
                    valores = getRemuneracao(html_valores)

                    html_descricao = soup.find_all('div', class_='span3')
                    descricao = getDescricao(html_descricao)
                    
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
                else:
                    print("erro no html")
            except Exception:
                pass
        
        
        
