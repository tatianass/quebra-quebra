(function() {
    'use strict';

    angular.module('app')
        .directive('d3BubbleChart', [function() {
            return {
                restrict: 'EA',
                scope: {
                    dados: '='
                },
                link: function(scope, iElement, iAttrs) {

                    var dimensoes = getDimensoes();
                    var wl = 10;
                    var hl = 30;
                    var charOpacidadeOut = "0.4";
                    var charOpacidadeOver = "1";
                    // Define the div for the tooltip
                    var tooltip = d3.select("body").append("div")
                        .attr("class", "tooltip")
                        .style("opacity", 0);
                    var tooltipLeg = d3.select("body").append("div")
                        .attr("class", "tooltipLeg")
                        .style("opacity", 0);
                    var diameter = dimensoes.w,
                        format = d3.format(",d"),
                        z = d3.scaleOrdinal(d3.schemeCategory20c);

                    var bubble = d3.pack()
                        .size([diameter, diameter])
                        .padding(1.5);

                    var svg = d3.select("#chart")
                        .append("svg")
                        .attr("width", diameter)
                        .attr("height", diameter)
                        .attr("class", "bubble");

                    var svgLegenda = d3.select("#legenda")
                        .append("svg")
                        .attr('class', 'legenda')
                        .attr("width", wl * 5)
                        .attr("height", hl * 5);

                    scope.$watch('dados', function(newVals, oldVals) {
                        return scope.render(newVals);
                    }, true);

                    scope.render = function(dados) {
                        d3.json(scope.dados, function(error, data) {
                            if (error) throw error;

                            // remover itens do grafico antigo
                            svg.selectAll(".node").remove();

                            var root = d3.hierarchy(classes(data))
                                .sum(function(d) {
                                    return d.value;
                                })
                                .sort(function(a, b) {
                                    return b.value - a.value;
                                });

                            bubble(root);
                            var node = svg.selectAll(".node")
                                .data(root.children)
                                .enter().append("g")
                                .attr("class", "node")
                                .attr("transform", function(d) {
                                    return "translate(" + d.x + "," + d.y + ")";
                                });

                            node.append("circle")
                                .attr("r", function(d) {
                                    return d.r;
                                })
                                .style("fill", function(d) {
                                    return z(d.data.packageName);
                                })
                                .style("opacity", charOpacidadeOut)
                                .attr("id", function(d) {
                                    return 'tag' + d.data.className.replace(/\s+/g, '');
                                })
                                .on("mouseover", function(d) {
                                    checaChart(d);
                                    addLegendaChart(d, d3.mouse(this));
                                })
                                .on("mouseout", function(d) {
                                    checaChart(d);
                                    delLegendaChart();
                                });;

                            //criando legenda
                            var legenda = svgLegenda.append("g")
                                .attr('transform', 'translate(-20,30)');
                            addTextoLegenda(legenda, root.children);

                            onFilter(root.children);

                            d3.select('#search').on('click', function() {
                                onFilter(root.children);
                            });
                        });
                    };

                    d3.select(self.frameElement).style("height", diameter + "px");

                    function onFilter(dados) {
                        var filterText = d3.select('#filterOn').property('value');

                        filteredData = dados;
                        if (filterText !== "") {
                            var filteredData = dados.filter(function(d) {
                            var checaFiltro = d.data.className.indexOf(filterText) === 0;
                                if(checaFiltro){
                                    d.active = false;
                                    checaChart(d);
                                }else{
                                    d.active = true;
                                    checaChart(d);
                                }

                                return checaFiltro;
                            });
                        }

                        d3.select('#filteredList').html(
                            filteredData.map(function(d) {
                                return d.data.className;
                            }).join("<br/>")
                        );
                    };

                    /**
                     * Ativa ou desativa a linha.
                     * 
                     * @param {Object} d - linha selecionada.
                     */
                    function checaChart(d) {
                        // Determine if current line is visible 
                        var active = d.active ? false : true,
                            newOpacity = active ? charOpacidadeOver : charOpacidadeOut;
                        // Hide or show the elements based on the ID
                        d3.select("#tag" + d.data.className.replace(/\s+/g, ''))
                            .transition().duration(100)
                            .style("opacity", newOpacity);
                        // Update whether or not the elements are active
                        d.active = active;
                    };

                    function addLegendaChart(d, mouse) {
                        tooltip.transition()
                            .duration(200)
                            .style("opacity", .9);
                        tooltip.html("Nome: " + d.data.className + "<br/>" + "Função: " + d.data.packageName + "<br/>" + "Valor: " + d.data.value)
                            .style("left", (d3.event.pageX) + "px")
                            .style("top", (d3.event.pageY - 28) + "px");
                    };

                    function delLegendaChart() {
                        tooltip.transition()
                            .duration(500)
                            .style("opacity", 0);
                        tooltipLeg.transition()
                            .duration(500)
                            .style("opacity", 0);
                    };

                    /**
                     * Retorna a opacidade se o retângulo for clicado.
                     * 
                     * @param {String} opacidade - 1 padrão e 0.4 desativado.
                     * 
                     * @return {String} opacidade - nova opacidade.
                     */
                    function checaOpacidadeLegenda(opacidade) {
                        if (opacidade === charOpacidadeOut) {
                            opacidade = charOpacidadeOver;
                        } else {
                            opacidade = charOpacidadeOut;
                        }

                        return opacidade;
                    };

                    /**
                     * Adciona legenda ao mapa.
                     * 
                     * @param {Object} legenda - informações da legenda.
                     * @param {Object} node - dados dos funcionários.
                     */
                    function addTextoLegenda(legenda, node) {
                        legenda.selectAll('text')
                            .data(node)
                            .enter()
                            .append("text")
                            .attr("x", 60)
                            .attr("width", 20)
                            .attr("height", 20)
                            .attr("y", function(d, i) {
                                return (i - 1) * 30 + 15;
                            });
                    };

                    // Returns a flattened hierarchy containing all leaf nodes under the root.
                    function classes(root) {
                        var classes = [];

                        function recurse(name, node) {
                            if (node.children) node.children.forEach(function(child) { recurse(node.name, child); });
                            else classes.push({ packageName: name, className: node.name, value: node.size });
                        }

                        recurse(null, root);
                        return { children: classes };
                    }

                    /**
                     * Get das dimensões da div do chart.
                     * 
                     * @return {Object} dimensões.
                     */
                    function getDimensoes() {
                        //60% of the height
                        return { 'h': window.innerHeight, 'w': angular.element(document.querySelector('#charts'))[0].offsetWidth * 0.8 };
                    };
                }
            };
        }]);

}());