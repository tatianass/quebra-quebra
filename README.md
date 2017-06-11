# Quebra-Quebra

Os orçamentos da Câmara dos Deputados e do Senado, juntos, para 2017 totalizam R$  10,2 bilhões. As despesas com "pessoal e encargos sociais somam cerca de R$ 8 bilhões!!! Um dos objetivos do HackFest contra a corrupção é o aprimoramento do uso dos recursos públicos .É essencial termos todas as remunerações abertas ( e não uma a uma) para uma análise mais aprofundada da estrutura de cargos e salários para eventuais correções. Os cidadãos, que pagam os salários,  têm o direito de saber quanto ganham os seus empregados.

Nesse sentido, este projeto não só obteve as informações de remuneração de todos os servidores da câmara de deputados (2016/2017) e senado (2017) como também realizou várias análises e visualizações dessas informações para ajudar o cidadão a melhor entendê-las.

## Scripts PHP

O diretório __php__ contém os seguintes arquivos:

- **deputados.json** - JSON com o perfil de todos os deputados, resultado da conversão de um arquivo de XML disponível no [site da Câmara dos Deputados](http://www.camara.leg.br/SitCamaraWS/Deputados.asmx/ObterDeputados).
- **dep-nomes-encode.php** - Retorna os nomes de todos os deputados a partir do arquivo __deputados.json__.
- **dep-links.php** - Retorna o link de acesso às informações remunerações de cada deputado de acordo com o nome e o período informados via QueryString.
  - **Exemplo:** dep-links.php?periodoFolha=201704&nome=NOME-DO-DEPUTADO

Para executar os scripts acima, basta executá-los em um servidor web (local ou remoto) com suporte a PHP.

## Website
A branch _ph-pages_ contém os arquivos responsáveis pela criação do site.
Para exevutar o mesmo localmente basta:

1. Clone o repositório com:
```
git clone https://github.com/tatianass/quebra-quebra.git
```
2. Abra o arquivo index.html em seu navegador.

## Crawler e scrapping dos dados da camara de deputados

Accedendo a pasta `camara_deputados` voce cai encontrar diferentes programas para accesar os dados da camara de deputados

### lotacoes.sh

Gera um arquivo data/lotacoes.txt que tem todas as locatacoes (departamentos) da camera.

### outro_servidores.sh

Gera um arquivo data/outros_servidores.txt com a lista de nomes de todos os servidores (não deputados) que trabalham na camera de deputados.

### remuneracao_deputados_ano.sh

Gera arquivos SQL com comandos INSERT INTO data/deputados_inserts_${ANO}${MES}.sql que contem todas as remunerações de todos os deputados duramte um ano.

### remuneracao_funcionario.sh

Gera comandos SQL INSERT INTO das remunerações para um deputado num periodo especifico (YYYYMM).

### remuneracao_outros_servidores_ano.sh

Gera arquivos SQL com comandos INSERT INTO data/outros_inserts_${ANO}${MES} que contem todas as remunerações de todos os servidores (não deputados) duramte um ano.

### servidores_lotacao.sh

Gera uma lista de nomes de servidores que trabalham numa especifica lotação da camera.

## Tutorial para dados do Senado

Segue os passos utilizados para o download dos dados do site do senado.leg.gov: 

1. Adicionar a extensão de baixar cookies no Mozilla: https://addons.mozilla.org/pt-BR/firefox/addon/export-cookies/?src=api

2. Entrar no site: http://www.senado.gov.br/transparencia/rh/servidores/

3. Selecionar um servidor qualquer

4. Escolher a data para a qual quer obter os dados

5. Colocar o captcha e clicar em mais informações

6. Vá em Ferramentas, na barra superior do Mozilla, e clique em baixar cookies

7. Baixe os dados utilizando o shell do linux com o comando (há comandos semelhantes em outros sistemas operacionais, porém não foram testados): ''' cat codigos.txt | xargs -i wget "http://www.senado.gov.br/transparencia/rh/servidores/remuneracao.asp?fcodigo={}&fvinculo=&mes=01/01/2017" --load-cookies=cookies.txt ''' OBS: codigos.txt está disponível no github do projeto, a data deve ser conforme a selecionada no passo 4 e, os cookies são os que foram baixados no passe 7

## Tutorial para carregar as analises do Tableau

As nossas analises de dados foram feitas no software de vizualizacao de dados chamado Tableau. Abaixo os passos para abrir e fazer uso dessas analises:

1. Se ainda nao tiver, baixe a ultima versao do Tableau Public (versao free do Tableau) em: https://public.tableau.com/en-us/s/download. 
2. Apos isso, baixe o workbook (arquivo com todas as analises que fizemos) da pasta workbook tableau.
3. Finalmente, inicie o Tableau e abra o arquivo baixado no passo anterior.
