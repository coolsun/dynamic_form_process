var indexModule = angular.module('indexApp', []);

indexModule.controller('indexCtrl',
  function($scope, $sce, $rootScope, $http, $location, waitingIcon, $timeout, $window, $routeParams) {
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

    $rootScope.alerts = [];
    $rootScope.rsasAlert = function(elm){
      //$rootScope.rsasAlert({msg: 'no type'});
      //$rootScope.rsasAlert({type: 'success', msg: 'success'});
      //$rootScope.rsasAlert({type: 'danger', msg: 'danger'});

      switch (elm.type){
        case 'success':
          var alertKey = (new Date()).valueOf().toString() + (Math.random() * 10000000000000000).toString();
          elm.alertKey = alertKey;
          $rootScope.alerts.push(elm);
          $timeout(function(){
            for (var i = 0; i < $rootScope.alerts.length; i++)
            {
              if (alertKey == $rootScope.alerts[i].alertKey)
              {
                $rootScope.alerts.splice(i,1);
                break;
              }
            }
          }, 5000);
          break;
        case undefined:
        case 'danger':
          $rootScope.alerts.push(elm);
          break;
        default:
          //do nothing
      };
    };

    $rootScope.checkUrlYearAndProcedure = function(urlProcessYear, urlProcessAcronym){
      $scope.get_default_year_and_procedure = false;
      $scope.get_return_url = false;
      if($location.path() == "/"){
        $scope.get_return_url = true;
      }
      else if(NOT_IN_PROCESS_PAGE.indexOf($location.path().split("/")[1]) != -1){
        $scope.get_default_year_and_procedure = true;
      }

      return $http({
        url: JSON_URL + "/years/check_url_year_and_procedure",
        method: "POST",
        data: {
          year: urlProcessYear,
          procedure: urlProcessAcronym,
          get_default_year_and_procedure: $scope.get_default_year_and_procedure,
          get_return_url: $scope.get_return_url
        }
      });
    };

    $rootScope.index = {};
    $rootScope.header_permissions = {};
    $scope.index = {};
    $scope.index.init = function(){
      urlProcessYear = $location.path().split("/")[1];
      urlProcessAcronym = $location.path().split("/")[2];

      waitingIcon.open();

      $rootScope.checkUrlYearAndProcedure(urlProcessYear, urlProcessAcronym)
      .success(function (data){
        if (data.success){
          $rootScope.current_year = data.year;
          $rootScope.current_process = data.procedure;
          $scope.index.processId = $rootScope.current_process.id;
          $rootScope.getUserAuthority();
        }
        else{
          document.location.href = data.return_url;
          if(data.return_url != "/saas/index.html"){
            location.reload();
          }
        }

        waitingIcon.close();
      })
      .error(function (data){
        waitingIcon.close();
      });
    };

    $rootScope.getUserAuthority = function(){
      waitingIcon.open();
      $http({
        url: JSON_URL + "/applicants/get_user_authority",
        method: "GET"
      })
      .success(function (data){
        if (data.success || $location.path().split("/")[3] == "apply_now"){
          $rootScope.current_user = data.authorities;
          $rootScope.header_permissions = data.permissions;

          $rootScope.show_content = true;
          $scope.index.getProcessList();
        }
        else{
          $("#modalLoginFail").modal('show');
        }

        waitingIcon.close();
      })
      .error(function (data){
        $("#modalSystemError").modal('show');
        waitingIcon.close();
      });
    };

    $scope.userSelectBar = {};
    $scope.getChangeUserList = function()
    {
      waitingIcon.open();
      if($rootScope.current_year){
        current_year_id = $rootScope.current_year.id;
      }

      $http({
        url: JSON_URL + "/users/get_user_all",
        method: "GET",
        params: {current_year_id : current_year_id}
      })
      .success(function (data){
        $scope.userSelectBar.useres = data.users;
        waitingIcon.close();
      })
      .error(function (data){
        waitingIcon.close();
      });
    };

    $scope.userSelectBar.changeUser = function(){
      $http({
        url: JSON_URL + "/users/get_user_authority?user_id=" + $scope.userSelectBar.userSelect.id,
        method: "GET"
      })
      .success(function (data){
        if (data.success){
          $rootScope.current_user = data.authorities;
          $rootScope.header_permissions = data.permissions;
          $window.location.href = "/";
        }
        else{
          $("#modalSystemError").modal('hide');
        }
        $("#changeUser").modal("hide");
      })
      .error(function (data){
        console.log("change user error");
      });
    };

    $scope.index.getProcessList = function(){
      waitingIcon.open();
      $http.post(JSON_URL + "/procedures/show_all_procedure")
      .success(function (data){
        $rootScope.index.processes = data.procedures;
        $rootScope.current_year = data.year;
        $scope.updateSelectProcessBarWhenEntryNotStart();
        waitingIcon.close();
      })
      .error(function (data){
        $("#modalSystemError").modal('show');
        waitingIcon.close();
      });
    };

    $scope.updateSelectProcessBarWhenEntryNotStart = function()
    {
      if ($location.url().indexOf("/start/") == -1)
      {
        for (var i = 0; i < $rootScope.index.processes.length; i++)
        {
          if ($rootScope.index.processes[i].id == $scope.index.processId)
          {
            $rootScope.current_process = $rootScope.index.processes[i];
            break;
          }
        }
      }
    };

    $scope.showMenuList = function(){
      show_menu_list = false;
      angular.forEach($rootScope.header_permissions, function(value){
        if(value){
          show_menu_list = true;
        }
      });
      return show_menu_list;
    };

    $rootScope.defaultDialog = function(text)
    {
      $scope.default_dialog_text = text;
      $("#default_dialog").modal('show');
    };

    $rootScope.defaultConfirm = function(title, body, confirmDo, confirmDoParams){
      $scope.default_confirm = {
        title: title,
        body: body,
        confirmDo: confirmDo,
        confirmDoParams: confirmDoParams
      };
      $("#defaultConfirm").modal('show');
    };

    $scope.defaultConfirmDo = function(){
      $scope.default_confirm.confirmDo($scope.default_confirm.confirmDoParams);
      $("#defaultConfirm").modal('hide');
    };


    $rootScope.systemMessage = function(message){
      $scope.system_message = $sce.trustAsHtml(message);
      $("#systemMessage").modal('show');
    };

    angular.element(document).ready(function () {
      $scope.index.init();
    });
  }
);

























