(function() {
    'use strict';

    angular.module('app')
        .directive('d3Chart', [function() {
            return {
                restrict: 'EA',
                scope: {
                    dados: '='
                },
                link: function(scope, iElement, iAttrs) {

                    var margin = { top: 20, right: 80, bottom: 30, left: 50 }
                    var dimensoes = getDimensoes();
                    var wl = 10;
                    var hl = 30;
                    var charOpacidadeOut = "0.1";
                    var charOpacidadeOver = "0.6";

                    //definindo tamanho do gráfico
                    var svg = d3.select("#chart")
                        .append("svg")
                        .attr("width", dimensoes.w)
                        .attr("height", dimensoes.h)
                        .attr("class", "graph-svg-component"),
                        margin = { top: 20, right: 40, bottom: 30, left: 30 },
                        width = svg.attr("width") - margin.left - margin.right,
                        height = svg.attr("height") - margin.top - margin.bottom,
                        g = svg.append("g").attr("transform", "translate(" + margin.left + "," + margin.top + ")");

                    var svgLegenda = d3.select("#legenda")
                        .append("svg")
                        .attr('class', 'legenda')
                        .attr("width", wl * 5)
                        .attr("height", hl * 5);

                    //formatando linguagem das datas
                    var locale = dataPTBR();

                    //formatando data
                    var formatMillisecond = locale.format(".%L"),
                        formatSecond = locale.format(":%S"),
                        formatMinute = locale.format("%I:%M"),
                        formatHour = locale.format("%I %p"),
                        formatDay = locale.format("%a %d"),
                        formatWeek = locale.format("%b %d"),
                        formatMonth = locale.format("%B"),
                        formatYear = locale.format("%Y");

                    //certifica que as dimensões do gráfico não excedão a tela
                    var x = d3.scaleTime().range([0, width]),
                        y = d3.scaleLinear().range([height, 0]),
                        z = d3.scaleOrdinal(d3.schemeCategory10);

                    //add a linha baseado nos dados
                    var line = d3.line()
                        .curve(d3.curveBasis)
                        .x(function(d) {
                            return x(d.date);
                        })
                        .y(function(d) {
                            return y(d.remuneracao);
                        });

                    //parser do tempo
                    var parseTime = d3.timeParse("%Y%m%d");

                    // Define the div for the tooltip
                    var tooltip = d3.select("body").append("div")
                        .attr("class", "tooltip")
                        .style("opacity", 0);
                    var tooltipLeg = d3.select("body").append("div")
                        .attr("class", "tooltipLeg")
                        .style("opacity", 0);

                    /**
                     * Atualiza o gráfico quando os dados mudam.
                     * 
                     * @param {String} newVals - novo valor.
                     * @param {String} oldVals -  valor antigo.
                     * 
                     * @return {Function} função de atualização.
                     */
                    scope.$watch('dados', function(newVals, oldVals) {
                        return scope.render(newVals);
                    }, true);

                    /**
                     * Cria o gráfico.
                     * 
                     * @param {String} dados - path para os dados.
                     */
                    scope.render = function(dados) {

                        // remover itens do grafico antigo
                        svg.selectAll(".funcionario").remove();
                        svg.selectAll(".axis").remove();
                        svgLegenda.selectAll(".legenda").remove();
                        svgLegenda.selectAll("g").remove();

                        /**
                         * Carrega os dados.
                         * 
                         * @param {String} dados - path para os dados.
                         */
                        d3.json(dados, function(error, data) {
                            if (error) throw error;

                            var data = data["columns"];

                            var columns = ["New York", "San Francisco"];

                            var funcionarios = [];
                            columns.forEach(function(c) {
                                var i = { "id": "", "values": [] }
                                i["id"] = c;
                                data.forEach(function(d) {
                                    var j = { "date": 0, "remuneracao": 0 };
                                    j.date = d.date;
                                    j.remuneracao = d[c];
                                    i.values.push(j);
                                })
                                funcionarios.push(i);
                            })

                            carregaCoordenadas(funcionarios, data);
                            addEixos();
                            addGrids();

                            //adicionando os dados do funcionario
                            var funcionario = g.selectAll(".funcionario")
                                .data(funcionarios)
                                .enter()
                                .append("g")
                                .attr("class", "funcionario");

                            addLinhas(funcionario);

                            //criando legenda
                            var legenda = svgLegenda.append("g")
                                .attr('transform', 'translate(-20,30)');

                            addTextoLegenda(legenda, funcionarios);

                            onFilter(funcionarios);
                            d3.select('#filterOn').on('change', function() {
                                onFilter(funcionarios);
                            });
                            d3.select('#search').on('click', function() {
                                onFilter(funcionarios);
                            });
                        });
                    };

                    function onFilter(dados) {
                        var filterText = d3.select('#filterOn').property('value');

                        filteredData = dados;
                        if (filterText !== "") {
                            var filteredData = dados.filter(function(d) {
                                var checaFiltro = d.id.indexOf(filterText) === 0;
                                if (checaFiltro) {
                                    d.active = false;
                                    checaChart(d);
                                } else {
                                    d.active = true;
                                    checaChart(d);
                                }

                                return checaFiltro;
                            });
                        };

                        d3.select('#filteredList').html(
                            filteredData.map(function(d) {
                                return d.id;
                            }).join("<br/>")
                        );
                    };

                    /**
                     * Parser dos dados para json.
                     * 
                     * @param {Object} d - dados do tsv.
                     * @param {String} columns -  colunas do tsv.
                     * 
                     * @return {Object} d - dados transformados.
                     */
                    function type(d, _, columns) {
                        d.date = parserDatas(d.date);
                        for (var i = 1, n = columns.length, c; i < n; ++i) d[c = columns[i]] = +d[c];
                        return d;
                    };

                    /**
                     * Parser da string pra Date.
                     * 
                     * @param {string} date - data a ser formatada.
                     * 
                     * @return {Date} data formatada.
                     */
                    function parserDatas(date) {
                        return parseTime(date);
                    };

                    /**
                     * Parser da data para o formato pt-br.
                     * 
                     * @return {Object} objeto de formatação.
                     */
                    function dataPTBR() {
                        return d3.timeFormatLocale({
                            "decimal": ",",
                            "thousands": ".",
                            "grouping": [3],
                            "currency": ["R$", ""],
                            "dateTime": "%a %b %e %X %Y",
                            "date": "%d/%m/%Y",
                            "time": "%H:%M:%S",
                            "periods": ["AM", "PM"],
                            "days": 'Domingo_Segunda-feira_Terça-feira_Quarta-feira_Quinta-feira_Sexta-feira_Sábado'.split('_'),
                            "shortDays": 'Dom_Seg_Ter_Qua_Qui_Sex_Sáb'.split('_'),
                            "months": 'Janeiro_Fevereiro_Março_Abril_Maio_Junho_Julho_Agosto_Setembro_Outubro_Novembro_Dezembro'.split('_'),
                            "shortMonths": 'Jan_Fev_Mar_Abr_Mai_Jun_Jul_Ago_Set_Out_Nov_Dez'.split('_')
                        });
                    };

                    //Função que carrega as coordenadas do gráfico.
                    function carregaCoordenadas(funcionarios, data) {
                        /**
                         * Retorna a escala do eixo x.
                         * 
                         * @param {Object} d - dados.
                         * 
                         * @return {Date} data a ser usada no eixo x.
                         */
                        x.domain(d3.extent(data, function(d) {
                            return d.date;
                        }));

                        /**
                         * Retorna a escala do eixo x.
                         * 
                         * @param {f} f - dados do funcionario.
                         * 
                         * @return {Float} valor da remuneracao.
                         */
                        y.domain([
                            d3.min(funcionarios, function(f) {
                                return d3.min(f.values, function(d) {
                                    return d.remuneracao;
                                });
                            }),
                            d3.max(funcionarios, function(f) {
                                return d3.max(f.values, function(d) {
                                    return d.remuneracao;
                                });
                            })
                        ]);

                        /**
                         * Retorna a escala do eixo z.
                         * 
                         * @param {f} f - dados do funcionario.
                         * 
                         * @return {Number} valor da remuneracao.
                         */
                        z.domain(d3.extent(funcionarios, function(f) {
                            return f.id;
                        }));
                    };

                    //Função que add os eixos do gráfico.
                    function addEixos() {
                        //addndo eixo x
                        g.append("g")
                            .attr("class", "axis axis--x")
                            .attr("transform", "translate(0," + height + ")")
                            .call(d3.axisBottom(x)
                                .tickFormat(multiFormat));

                        //addndo eixo y
                        g.append("g")
                            .attr("class", "axis axis--y")
                            .attr("transform", "translate(" + width + ",0)")
                            .call(d3.axisRight(y));
                    };

                    //Função que add as grades do gráfico.
                    function addGrids() {
                        // add the X gridlines
                        g.append("g")
                            .attr("class", "grid")
                            .attr("transform", "translate(0," + height + ")")
                            .call(cria_grade_x()
                                .tickSize(-height)
                                .tickFormat("")
                            );

                        // add the Y gridlines
                        g.append("g")
                            .attr("class", "grid")
                            .call(cria_grade_y()
                                .tickSize(-width)
                                .tickFormat("")
                            );
                    };

                    //Desenha as linhas do gráfico.
                    function addLinhas(funcionario) {
                        funcionario.append("path")
                            .attr("class", "line")
                            .attr("d", function(d) {
                                return line(d.values);
                            })
                            .attr("id", function(d) {
                                return 'tag' + d.id.replace(/\s+/g, '');
                            })
                            .style("stroke", function(d) {
                                return z(d.id);
                            })
                            .style("stroke-width", "2px")
                            .style("opacity", charOpacidadeOut)
                            .on("mouseover", function(d) {
                                checaChart(d);
                                addLegendaChart(d, d3.mouse(this));
                            })
                            .on("mouseout", function(d) {
                                checaChart(d);
                                delLegendaChart();
                            });
                    };

                    function addLegendaChart(d, mouse) {
                        //encontra a posição do mouse no mapa em relação ao dado.
                        var xDate = x.invert(mouse[0]),
                            bisect = d3.bisector(function(d) {
                                return d.date;
                            }).left;
                        var idx = bisect(d.values, xDate);
                        tooltip.transition()
                            .duration(200)
                            .style("opacity", .9);
                        tooltip.html(d.id + "<br/> - <br/>" + formatMonth(d.values[idx].date) + "<br/>" + formatYear(d.values[idx].date))
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
                     * Ativa ou desativa a linha.
                     * 
                     * @param {Object} d - linha selecionada.
                     */
                    function checaChart(d) {
                        // Determine if current line is visible 
                        var active = d.active ? false : true,
                            newOpacity = active ? charOpacidadeOver : charOpacidadeOut;
                        // Hide or show the elements based on the ID
                        d3.select("#tag" + d.id.replace(/\s+/g, ''))
                            .transition().duration(100)
                            .style("opacity", newOpacity);
                        // Update whether or not the elements are active
                        d.active = active;
                    };

                    /**
                     * Retorna a opacidade se o retângulo for clicado.
                     * 
                     * @param {String} opacidade - 1 padrão e 0.4 desativado.
                     * 
                     * @return {String} opacidade - nova opacidade.
                     */
                    function checaOpacidadeLegenda(opacidade) {
                        if (opacidade === "0.4") {
                            opacidade = "1";
                        } else {
                            opacidade = "0.4";
                        }

                        return opacidade;
                    };

                    /**
                     * Adciona legenda ao mapa.
                     * 
                     * @param {Object} legenda - informações da legenda.
                     * @param {Object} funcionarios - dados dos funcionários.
                     */
                    function addTextoLegenda(legenda, funcionarios) {
                        legenda.selectAll('text')
                            .data(funcionarios)
                            .enter()
                            .append("text")
                            .attr("x", 60)
                            .attr("width", 20)
                            .attr("height", 20)
                            .attr("y", function(d, i) {
                                return (i - 1) * 30 + 15;
                            });
                    };

                    /**
                     * Parser da data para o formato especificado.
                     * 
                     * @param {Date} date - data a ser formatada.
                     * 
                     * @return {Date} data formatada.
                     */
                    function multiFormat(date) {
                        return (d3.timeSecond(date) < date ? formatMillisecond : d3.timeMinute(date) < date ? formatSecond : d3.timeHour(date) < date ? formatMinute : d3.timeDay(date) < date ? formatHour : d3.timeMonth(date) < date ? (d3.timeWeek(date) < date ? formatDay : formatWeek) : d3.timeYear(date) < date ? formatMonth : formatYear)(date);
                    };

                    /**
                     * Faz a grade do eixo x.
                     * 
                     * @return {Object} propriedade de ticks.
                     */
                    function cria_grade_x() {
                        return d3.axisBottom(x)
                            .ticks(5)
                    };

                    /**
                     * Faz a grade do eixo y.
                     * 
                     * @return {Object} propriedade de ticks.
                     */
                    function cria_grade_y() {
                        return d3.axisLeft(y)
                            .ticks(5)
                    };

                    /**
                     * Get das dimensões da div do chart.
                     * 
                     * @return {Object} dimensões.
                     */
                    function getDimensoes() {
                        //60% of the height
                        return { 'h': window.innerHeight * 0.6, 'w': angular.element(document.querySelector('#charts'))[0].offsetWidth };
                    };
                }
            };
        }]);

}());