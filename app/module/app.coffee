'use strict'

angular.module('spike', [])
angular.module('spike').controller 'versionController', ($scope, $http) ->
  $http.get('module/resource/version.json').success (data) ->
    $scope.version = data
