var homepageApp = angular.module('homepageApp', []);

homepageApp.controller('homePageCrtl',
  function ($scope, $rootScope, $sce, $routeParams, waitingIcon) {
    $scope.homePage = {};
    $scope.homePage.urlProcessAcronym = $routeParams.urlProcessAcronym;
    $scope.homePage.urlProcessYear = $routeParams.urlProcessYear;
    $scope.homePage.processNow = {};

    $scope.homePage.initProcess = function(){
      document.location.href = "/saas/index.html#/start/";
    };

    if (!$scope.homePage.urlProcessAcronym || !$scope.homePage.urlProcessYear){
      $scope.homePage.initProcess();
    }


    $scope.homePage.goMyApplication = function(){
      if($rootScope.current_process.apply_message){
        $rootScope.default_dialog_text = $rootScope.current_process.apply_message;
        $("#defaultDialog").modal("show");
      }
      else{
        var return_url = "/saas/app/index.html#/" + $scope.homePage.urlProcessYear + "/" + $scope.homePage.urlProcessAcronym +"/apply_now";
        $rootScope.setReturnUrl(return_url).success(function (data){
          document.location.href = return_url;
        });
      }
    };

    $scope.homePage.checkSelectProcess = function(category){
      switch (category){
        case 'goToApplication':
          if ($scope.homePage.urlProcessAcronym && $scope.landingHTML){
            return (true);
          }
          else{
            return (false);
          }
          break;
        case 'select':
          if (!$scope.homePage.urlProcessAcronym){
            return (true);
          }
          else{
            return (false);
          }
          break;
        default:
          return(false);
      }
    };

    $rootScope.$watch("index.processes", function(){
      if($rootScope.index.processes){
        var processExist = false;
        for (var i = 0; i < $rootScope.index.processes.length; i++){
          if ($rootScope.index.processes[i].acronym == $scope.homePage.urlProcessAcronym){
            $rootScope.current_process = $rootScope.index.processes[i];
            $scope.landingHTML = $sce.trustAsHtml($rootScope.index.processes[i].landing);
            processExist = true;
            break;
          }
        }

        if (!processExist){
          $scope.homePage.initProcess();
        }
      }
    });
  }
);
