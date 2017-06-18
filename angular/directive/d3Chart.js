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
                    //definindo tamanho do gráfico
                    var svg = d3.select("svg"),
                        margin = { top: 20, right: 80, bottom: 30, left: 50 },
                        width = svg.attr("width") - margin.left - margin.right,
                        height = svg.attr("height") - margin.top - margin.bottom,
                        g = svg.append("g").attr("transform", "translate(" + margin.left + "," + margin.top + ")");

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

                    //desenha a linha baseado nos dados
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


                        d3.tsv(dados, type, function(error, data) {
                            if (error) throw error;

                            //transformando para json
                            var funcionarios = data.columns.slice(1).map(function(id) {
                                return {
                                    id: id,
                                    values: data.map(function(d) {
                                        return { date: d.date, remuneracao: d[id] };
                                    })
                                };
                            });

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
                            z.domain(funcionarios.map(function(f) {
                                return f.id;
                            }));

                            //desenhando eixo x
                            g.append("g")
                                .attr("class", "axis axis--x")
                                .attr("transform", "translate(0," + height + ")")
                                .call(d3.axisBottom(x)
                                    .tickFormat(multiFormat));

                            //desenhando eixo y
                            g.append("g")
                                .attr("class", "axis axis--y")
                                .call(d3.axisLeft(y))
                                .append("text")
                                .attr("transform", "rotate(-90)")
                                .attr("y", 6)
                                .attr("dy", "0.71em")
                                .attr("fill", "#000")
                                .text("Remuneração, R$");

                            //adicionando os dados do funcionario
                            var funcionario = g.selectAll(".funcionario")
                                .data(funcionarios)
                                .enter().append("g")
                                .attr("class", "funcionario");

                            funcionario.append("path")
                                .attr("class", "line")
                                .attr("d", function(d) {
                                    return line(d.values);
                                })
                                .style("stroke", function(d) {
                                    return z(d.id);
                                });

                            funcionario.append("text")
                                .datum(function(d) {
                                    return { id: d.id, value: d.values[d.values.length - 1] };
                                })
                                .attr("transform", function(d) {
                                    return "translate(" + x(d.value.date) + "," + y(d.value.remuneracao) + ")";
                                })
                                .attr("x", 3)
                                .attr("dy", "0.35em")
                                .style("font", "10px sans-serif")
                                .text(function(d) {
                                    return d.id;
                                });
                        });
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
                    }

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
                }
            };
        }]);

}());
