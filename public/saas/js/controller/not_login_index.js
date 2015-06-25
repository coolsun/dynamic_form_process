'use strict';

/* App Module */

var notLoginIndexApp = angular.module('notLoginIndexApp', [
  'ngRoute',
  'waitingIconModule',
  'homepageApp',
  'recommendationFormApp',
  'factoryModule',
  'processSelectBarModule',
  'footerModule'
]);

notLoginIndexApp.controller('notLoginIndexCrtl',
  function($scope, $rootScope, $http, $location, waitingIcon, $window) {
    $rootScope.index = {};
    $scope.index = {};
    $scope.page_complete = false;

    $scope.logout = function(){
      $http({
        url: JSON_URL + "/users/logout",
        method: "GET"
      })
      .success(function (data){
        console.log("logout");
        $window.location.href = "/";
      });
    };

    $rootScope.getUserAuthority = function(){
      waitingIcon.open();
      $http({
        url: JSON_URL + "/users/get_user_authority",
        method: "GET"
      })
      .success(function(data){
        if (data.success){
          $rootScope.current_user = data.authorities;
          $rootScope.header_permissions = data.permissions;
        }
        else{
          console.log("$rootScope.getUserAuthority Fail, maybe it's not login, or no session at RSAS.");
        }
        waitingIcon.close();
        $scope.page_complete = true;
      })
      .error(function(data){
        $("#modalSystemError").modal('show');
        waitingIcon.close();
        $scope.page_complete = true;
      });
    };

    $scope.changeProcess = function(process){
      $rootScope.current_process = process;
      $location.path("/start/"+ $rootScope.current_year.name + "/" + $rootScope.current_process.acronym);
    };

    $scope.setCurrentProcessFromDomain = function(){
      var matched_process = $.grep($rootScope.index.processes, function(e){ return e.domain == location.hostname; })[0];
      if(location.hostname == "saas.stanford.edu" || location.hostname == "sca"){
        $rootScope.getManageUrl();
      }
      else{
        if(matched_process && NOT_IN_PROCESS_PAGE.indexOf($location.path().split("/")[1]) == -1){
          $scope.changeProcess(matched_process);
        }
        $rootScope.getUserAuthority();
      }
    };

    $scope.index.getProcessList = function(){
      waitingIcon.open();
      $http.post(JSON_URL + "/procedures/show_all_procedure?get_landing=true")
      .success(function(data){
        $rootScope.index.processes = data.procedures;
        $rootScope.current_year = data.year;
        $scope.setCurrentProcessFromDomain();
        waitingIcon.close();
      })
      .error(function(data){
        $("#modalSystemError").modal('show');
        waitingIcon.close();
      });
    };

    $rootScope.getManageUrl = function(){
      waitingIcon.open();
      var return_url = "/saas/app/index.html#/process";
      $rootScope.setReturnUrl(return_url)
      .success(function (data){
        document.location.href = data.return_url;
        waitingIcon.close();
      })
      .error(function(data){
        waitingIcon.close();
      });
    };

    $rootScope.setReturnUrl = function(return_url){
       return $http({
        url: JSON_URL + "/years/set_return_url",
        method: "GET",
        params: {return_url: return_url}
      });
    };

    angular.element(document).ready(function () {
      $scope.index.getProcessList();
    });
  }
);

notLoginIndexApp.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      //when('/', { //The virtual URL after the '#' sign
      //  templateUrl: '/saas/partials/not_login/not_login_homepage.html', // The really each page at the partials/ dir
      //}).
      when('/start/', { //The virtual URL after the '#' sign
        templateUrl: '/saas/partials/homepage.html', // The really each page at the partials/ dir
      }).
      when('/start/:urlProcessYear/:urlProcessAcronym', {
        templateUrl: '/saas/partials/homepage.html',
      }).
      when('/recommendation_form', {
        templateUrl: '/saas/partials/recommendation_form.html',
      }).
      otherwise({
        redirectTo: '/start/'
      });
  }
]);
