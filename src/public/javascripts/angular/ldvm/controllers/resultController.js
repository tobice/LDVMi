define(['angular', './controllers'], function (ng) {
    'use strict';

    return ng.module('ldvm.controllers')
        .controller('Result', [
            '$scope', '$routeParams', 'Evaluation',
            function ($scope, $routeParams, evaluation) {
            evaluation.result($routeParams.id).then(function (data) {
                $scope.results = data;
            });

            evaluation.get($routeParams.id).then(function(evaluation){
                $scope.evaluation = evaluation;
            });
        }]);
});