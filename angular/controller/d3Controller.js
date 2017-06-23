(function() {
    'use strict';

    app.controller('d3Controller', ['APP_D3',
        function(APP_D3) {
            var self = this;
            self.dados = APP_D3.DADOS_FUNCOES2;
            self.opcoes = [
                { "nome": "Multiline1", "url": APP_D3.DADOS_CAMARA_PLENARIO },
                { "nome": "Multiline2", "url": APP_D3.DADOS_CAMARA_PROPOSTAS },
                { "nome": "Bolha1", "url": APP_D3.DADOS_FUNCOES },
                { "nome": "Bolha2", "url": APP_D3.DADOS_FUNCOES2 }
            ]

            self.setDados = function(url) {
                self.dados = url;
            };
        }
    ]);

}());
