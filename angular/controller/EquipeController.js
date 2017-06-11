(function() {
    'use strict';

    /**
     * Implementing Interesse controller
     * @author Tatiana Saturno
     */
    app.controller("EquipeController", [
        function() {
            var self = this;
            self.perguntasList = [];
            self.perguntaSelected = false;
            self.equipe = [
                { id: "1", nome: "Fagner Lima", img: "assets/img/1.jpg" },
                { id: "2", nome: "Ítalo Oliveira", img: "assets/img/1.jpg" },
                { id: "3", nome: "Jesus Mercado", img: "assets/img/1.jpg" },
                { id: "4", nome: "Leandro Balby", img: "assets/img/1.jpg" },
                { id: "5", nome: "Tatiana", img: "assets/img/1.jpg" }
            ]
        }
    ]);
})();
