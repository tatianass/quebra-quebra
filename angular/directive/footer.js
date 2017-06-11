(function() {
    'use strict';

    /**
     * Diretiva para o footer.
     *
     * @author tatiana.saturno
     */
    app.directive('footer', [
        DiretivaFooter]);

    /**
     * Implementação da diretiva do footer.
     */
    function DiretivaFooter() {
        return {
            restrict: 'A',
            templateUrl: 'view/directive/footer.html',
            replace: true,
            link: function() {}
        };
    }
})();