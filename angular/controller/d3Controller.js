(function() {
    'use strict';

    app.controller('d3Controller', ['APP_D3',
        function(APP_D3) {
            var self = this;
            self.dados = APP_D3.DADOS_CAMARA_PLENARIO;
            self.opcoes = [
                { "nome": "Plenário", "url": APP_D3.DADOS_CAMARA_PLENARIO },
                { "nome": "Propostas", "url": APP_D3.DADOS_CAMARA_PROPOSTAS }
            ]

            self.setDados = function(url) {
                self.dados = url;
            };
        }
    ]);

}());
