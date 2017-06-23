(function() {
    'use strict';

    app.controller('d3Controller', ['APP_D3', '$scope',
        function(APP_D3, $scope) {
            var self = this;
            self.dadosBubble = APP_D3.DADOS_FUNCOES2;
            self.dadosMultiline = APP_D3.DADOS_CAMARA_PLENARIO;
            self.opcoes = [
                { "nome": "Multiline1", "url": APP_D3.DADOS_CAMARA_PLENARIO, "chart": "multiline" },
                { "nome": "Multiline2", "url": APP_D3.DADOS_CAMARA_PROPOSTAS, "chart": "multiline" },
                { "nome": "Bolha1", "url": APP_D3.DADOS_FUNCOES, "chart": "bubble" },
                { "nome": "Bolha2", "url": APP_D3.DADOS_FUNCOES2, "chart": "bubble" }
            ]
            $scope.chartSelecionado = "Multiline1";

            self.setDados = function(opcao) {
                if ('multiline' === opcao.chart) {
                    self.dadosMultiline = opcao.url;
                } else {
                    self.dadosBubble = opcao.url;
                }

                $scope.chartSelecionado = opcao.nome;
            };
        }
    ]);

}());
