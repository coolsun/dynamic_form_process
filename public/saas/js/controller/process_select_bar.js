var processSelectBarModule = angular.module('processSelectBarModule', []);

processSelectBarModule.controller('processSelectBarCrtl',function ($scope, $rootScope, $location) {
  $scope.changeProcess = function(process){
    $rootScope.current_process = process;
    $location.path("/start/"+ $rootScope.current_year.name + "/" + $rootScope.current_process.acronym);
  };
});
