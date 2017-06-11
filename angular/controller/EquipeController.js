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
                { id: "1", nome: "Fagner Lima", img: "assets/img/perguntas/cabin.png" },
                { id: "5", nome: "Gil Branco", img: "assets/img/perguntas/cabin.png" },
                { id: "2", nome: "Ítalo Oliveira", img: "assets/img/perguntas/cabin.png" },
                { id: "3", nome: "Jesus Mercado", img: "assets/img/perguntas/cabin.png" },
                { id: "4", nome: "Leandro Balby", img: "assets/img/perguntas/cabin.png" },
                { id: "5", nome: "Tatiana", img: "assets/img/perguntas/cabin.png" }
            ]
        }
    ]);
})();
