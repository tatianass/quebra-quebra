/*(function() {
    'use strict';

    angular.module('d3', [])
        .factory('dadosService', [
            function() {
                var self = this;

                var parserDado = function(d, columns) {
                    d.date = parseTime(d.date);
                    for (var i = 1, n = columns.length, c; i < n; ++i) {
                        d[c = columns[i]] = +d[c];
                    }
                    return d;
                };

                self.parserDados = function(dados) {
                    for (var i = 1; i < dados.length; i++) {
                        dados[i] = parserDado(dados[i]);
                    }

                    return dados;
                };
            }
        ]);
}());
*/
