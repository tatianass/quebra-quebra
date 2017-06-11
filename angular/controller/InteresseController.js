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
            self.perguntas = [
                { id: "20th-century", nome: "20th-century", img: "assets/img/equipe/1.jpg" },
                { id: "21st-century", nome: "21st-century", img: "assets/img/equipe/1.jpg" },
                { id: "3-stars", nome: "3-stars", img: "assets/img/equipe/1.jpg" },
                { id: "4-stars", nome: "4-stars", img: "assets/img/equipe/1.jpg" },
                { id: "5-stars", nome: "5-stars", img: "assets/img/equipe/1.jpg" }
            ]

            self.setPerguntas = function(pergunta) {
                self.perguntasList = self.perguntasList[pergunta.id];
                self.perguntaSelected = true;
            };
        }
    ]);
})();
