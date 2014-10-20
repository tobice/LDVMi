define(['angular', 'underscorejs'], function (ng, _) {
    'use strict';

    ng.module('map.controllers', []).
        controller('Map',
        ['$scope', 'MapService', 'DataCubeService', '$q', '$location', '$routeParams', '$timeout',
            function ($scope, MapService, DataCubeService, $q, $location, $routeParams, $timeout) {

                var $id = $routeParams.id;
                var $permaToken = $routeParams.p;

                if (!$id) {
                    return;
                }

                $scope.init = true;
                $scope.currentLanguage = "";
                $scope.mainProperty = null;

                $scope.queryingDataset = "properties of geolocated entities";
                MapService.polygonEntitiesProperties({visualizationId: $id}, function (properties) {
                    $scope.properties = properties;

                    $scope.mainProperty = properties[0] || null;

                    var uris = properties.map(function (p) {
                        return p.uri;
                    });

                    $scope.queryingDataset = "values of properties";
                    DataCubeService.getValues({ visualizationId: $id}, {uris: uris }, function (propertiesValuesMap) {
                        $scope.queryingDataset = null;
                        $scope.values = propertiesValuesMap;
                        $scope.colors = {};

                        if ($scope.mainProperty) {
                            angular.forEach($scope.values[$scope.mainProperty.uri], function (v) {
                                var key = v.uri || v.label.variants[$scope.currentLanguage];
                                $scope.colors[key] = "rgba(" + random() + ", " + random() + ", " + random() + ", 0.7)";
                                v.colorStyle = {"background-color": $scope.colors[key]};
                            });
                        }
                    });
                });

                function random() {
                    return Math.floor(Math.random() * 256);
                }

                $scope.refresh = function () {
                    $scope.queryingDataset = "geolocated entities";

                    var filters = {};

                    angular.forEach($scope.values, function (array, k) {
                        if (k.substr(0, 1) != "$") {
                            angular.forEach(array, function (v, key) {
                                if (parseInt(key) > -1) {
                                    filters[k] = filters[k] || [];
                                    filters[k].push({
                                        label: v.label.variants[$scope.currentLanguage],
                                        uri: v.uri,
                                        isActive: v.isActive || false
                                    });
                                }
                            });
                        }
                    });

                    MapService.polygonEntities({visualizationId: $id}, {filters: filters}, function (data) {
                        $scope.queryingDataset = null;
                        $scope.entities = data;
                    });
                };

            }])
});