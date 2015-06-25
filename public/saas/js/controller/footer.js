var footerModule = angular.module('footerModule', []);

footerModule.controller('footerController',
  function($rootScope, $scope, $location, waitingIcon, processHelpLandingFactory, saasFactory) {

    $scope.showManageProcessButton = function(){
      var show = false;
      var first_check = false;

      if($location.absUrl().search("/app/") == -1){
        if(location.hostname.indexOf("stanford.edu") == -1){
          first_check = true;
        }
        if(location.hostname == "saisappdev68.stanford.edu" || location.hostname == "saas.stanford.edu" || location.hostname.indexOf("test.stanford.edu") != -1){
          first_check = true;
        }
      }

      if(first_check){
        if(!$rootScope.current_user){
          show = true;
        }
        else if($rootScope.header_permissions && $rootScope.header_permissions.show_menu_process){
          show = true;
        };
      }
      return show;
    };

    $scope.getHelpLandings = function(){
      waitingIcon.open();
      processHelpLandingFactory.getHelpLandings($rootScope.current_process.id, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function(data){
        console.log(data);
        if(data.success) {
          $scope.all_help = data.all_help_landings;
        }
        else {
          $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to get the help landings.'});
        }
        waitingIcon.close();
      })
      .error(function(){
        $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to get the help landings.'});
        waitingIcon.close();
      });
    };

    $scope.contact_support = function(){
      waitingIcon.open();
      saasFactory.sendQuestion($scope.contact, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function(data){
        if(data.success) {
          angular.extend($scope.contact, {"name": "", "email": "", "message": ""});
          //$rootScope.rsasAlert({type: 'success', msg: 'Your message is sent.'});
        }
        else {
          //$rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to send your message.'});
        }
        waitingIcon.close();
      })
      .error(function(){
        //$rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to send your message.'});
        waitingIcon.close();
      });
    };
  }
);
