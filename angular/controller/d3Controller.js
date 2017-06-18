(function() {
    'use strict';

    app.controller('d3Controller', ['APP_D3',
        function(APP_D3) {
            var self = this;
            self.dados = APP_D3.DADOS_CAMARA_PLENARIO;

            self.setDados = function() {
                if (self.dados === APP_D3.DADOS_CAMARA_PLENARIO) {
                    self.dados = APP_D3.DADOS_CAMARA_PROPOSTAS;
                } else {
                    self.dados = APP_D3.DADOS_CAMARA_PLENARIO;
                }
            };
        }
    ]);

}());
