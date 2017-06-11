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
            self.perguntas = [{
                id: 0,
                nome: "Quem e quanto?",
                img: "assets/img/perguntas/1.png",
                texto: "Atualmente o site da câmara dos deputados (http://www.camara.leg.br/) permite a consulta das remunerações dos seus servidores somente via consulta nominal. Isso quer dizer que a única forma de obter todos os salários de uma vez é sabendo o nome de todos os servidores e fazendo as consultas uma a uma que é demorado, trabalhoso e consequentemente pouco transparente. Nós conseguimos coletar todos os dados de remuneração de todos os servidores da câmara de deputados de 2016/2017 e os disponibilizamos abaixo. Tanto para consulta quanto o .csv com esses dados.",
                texto2: "Nesse sentido, este projeto não só obteve as informações de remuneração de todos os servidores da câmara de deputados (2016/2017) e senado (2017) como também realizou várias análises e visualizações dessas informações para ajudar o cidadão a melhor entendê-las.",
                grafico: "view/quem-quando.html"
            }, {
                id: 1,
                nome: "Dobrando a meta?",
                img: "assets/img/perguntas/2.png",
                texto: "No Brasil, os deputados federais ocupam um dos cargos públicos federais de mais alto salário no pais. Esses salários são comumente questionados pela populacao devido o trabalho desenvolvido por eles, que deixam a desejar pela qualidade. Alem desse alto salário, observamos que os deputados tem recebido taxas adicionais elevadas, comparando-se a um salário extra! Nesta nossa análise, buscamos destacar quem são esses indivíduos que tem recebido remunerações adicionais elevadas.",
                texto2: "",
                grafico: "view/dobrando.html"
            }, {
                id: 2,
                nome: "Cargos ostentação?",
                img: "assets/img/perguntas/3.png",
                texto: “Os dados obtidos para a câmara dos deputados apresentam folhas de pagamento para alem dos deputados federais, o que incluem os analistas e técnicos do legislativo. O gráfico apresentado nessa pagina, permite ao usuário visualizar as despesas com as folhas de pagamento desses funcionários.“,
                texto2: "",
                grafico: "view/cargos-ostentacao.html"
            }, {
                id: 3,
                nome: "E a mesada?",
                img: "assets/img/perguntas/4.png",
                texto: “Com os dados das folhas de pagamento dos servidores da câmara, podemos visualizar os valores recebidos ao longo do tempo, procurando monitorar possíveis anomalias nos salários públicos.”,
                texto2: "",
                grafico: "view/mesada.html"
            }]

            self.setPergunta = function(pergunta) {
                self.pergunta = self.perguntas[pergunta.id];
                self.perguntaSelected = true;
            };
        }
    ]);
})();
