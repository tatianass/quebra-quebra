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
