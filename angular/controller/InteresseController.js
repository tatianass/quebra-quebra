(function() {
    'use strict';

    /**
     * Implementing Interesse controller
     * @author Tatiana Saturno
     */
    app.controller("InteresseController", [
        function() {
            var self = this;
            self.perguntasList = [];
            self.perguntaSelected = false;
            self.pergunta = {}
            self.perguntas = [
                { id: 0, nome: "Quem e quanto?", img: "assets/img/perguntas/1.png", texto: "Atualmente o site da câmara dos deputados (http://www.camara.leg.br/) permite a consulta das remunerações dos seus servidores somente via consulta nominal. Isso quer dizer que a única forma de obter todos os salários de uma vez é sabendo o nome de todos os servidores e fazendo as consultas uma a uma que é demorado, trabalhoso e consequentemente pouco transparente. Nós conseguimos coletar todos os dados de remuneração de todos os servidores da câmara de deputados de 2016/2017 e os disponibilizamos abaixo. Tanto para consulta quanto o .csv com esses dados.", texto2: "Abaixo segue o link com o gráfico da quantidade de servidores por cargo para o ano de 2016:", grafico: "view/quebra-quebra.html" },
                { id: 1, nome: "Dobrando a meta?", img: "assets/img/perguntas/2.png", texto: "No Brasil, os deputados federais ocupam um dos cargos publicos federais de mais alto salario no pais. Esses salarios sao comumente questionados pela populacao devido o trabalho desenvolvido por eles, que deixam a desejar pela qualidade. Alem desse alto salario, observamos que os deputados tem recebido taxas adicionais elevadas, comparando-se a um salário extra! Nesta nossa análise, buscamos destacar quem são esses indivíduos que tem recebido remuneracoes adicionais elevadas.", texto2: "", grafico: "view/quebra-quebra.html" },
                { id: 2, nome: "Cargos ostentação?", img: "assets/img/perguntas/3.png", texto: "", texto2: "", grafico: "view/quebra-quebra.html" },
                { id: 3, nome: "Meses ostentação?", img: "assets/img/perguntas/4.png", texto: "", texto2: "", grafico: "view/quebra-quebra.html" }
            ]

            self.setPergunta = function(pergunta) {
                self.pergunta = self.perguntas[pergunta.id];
                self.perguntaSelected = true;
            };
        }
    ]);
})();
