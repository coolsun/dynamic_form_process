rsasApp.controller('SelectPositions',
  function($scope, applicationFactory, $rootScope, waitingIcon) {
    $scope.select_position_settings = {};

    $scope.getSelectPositionSettings = function(){
      waitingIcon.open();
      applicationFactory.getSelectPositionSettings($rootScope.current_year.id, $rootScope.current_process.id)
      .success(function(data){
        if(data.success){
          $scope.select_position_settings = data.select_position_settings;
          $scope.permission_to_active = data.permission_to_active;
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the selected position settings."});
        waitingIcon.close();
      });
    };

    $scope.updateSelectPositionSettings = function(){
      waitingIcon.open();
      applicationFactory.updateSelectPositionSettings($scope.select_position_settings, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function(data){
        if(data.success){
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to select the position."});
        waitingIcon.close();
      });
    };

    angular.element(document).ready(function(){
      if($rootScope.isRunNowProcess){
        $scope.getSelectPositionSettings();
      }
    });

  }
);

rsasApp.controller('UserSelectPositions',
  function($scope, applicationFactory, $rootScope, waitingIcon) {
    $scope.positions = [];

    $scope.getSelectPositionList = function(){
      waitingIcon.open();
      applicationFactory.getSelectPositionList($rootScope.current_year.id, $rootScope.current_process.id, $rootScope.applicant_sub_step.identify_name)
      .success(function(data){
        $scope.permission_to_active = data.permission_to_active;
        $scope.positions = data.positions;
        $scope.locations = data.locations;
        $scope.roles = data.roles;
        $scope.select_position_limit = data.select_position_limit;
        $scope.one_year_up_message = data.one_year_up_message;
        $scope.remaining_year = data.remaining_year;
        $scope.checkDisabledToSelect();
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to load the selected position list."});
        waitingIcon.close();
      });
    };

    $scope.updatePositionsSelect = function(){
      waitingIcon.open();
      applicationFactory.updatePositionsSelect($scope.position_selest_add_ids, $scope.position_selest_delete_ids, $rootScope.current_year.id, $rootScope.current_process.id, $rootScope.applicant_sub_step.identify_name)
      .success(function(data){
        if(data.success){
          $scope.position_selest_add_ids = [];
          $scope.position_selest_delete_ids = [];
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
          $rootScope.getApplicantStatus(false);
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to select the position."});
        waitingIcon.close();
      });
    };

    $scope.position_selest_add_ids = [];
    $scope.position_selest_delete_ids = [];
    $scope.checkPositionsSelect = function(position){
      if (position.is_select){
        var index_of = $scope.position_selest_delete_ids.indexOf(position.id);
        if(index_of != -1){
          $scope.position_selest_delete_ids.splice(index_of, 1);
        }
        $scope.position_selest_add_ids.push(position.id);
      }
      else{
        var index_of = $scope.position_selest_add_ids.indexOf(position.id);
        if(index_of != -1){
          $scope.position_selest_add_ids.splice(index_of, 1);
        }
        $scope.position_selest_delete_ids.push(position.id);
      }
      $scope.checkDisabledToSelect();
    };

    $scope.checkDisabledToSelect = function(){
      selected_count = 0;
      $scope.positions.forEach(function(position){
        if(position.is_select){
          selected_count +=1;
        }
      });
      if(selected_count >= $scope.select_position_limit && $scope.select_position_limit != 0){
        $scope.disabled_to_select = true;
      }else{
        $scope.disabled_to_select = false;
      }
    };

    angular.element(document).ready(function () {
      if($rootScope.isRunNowProcess){
        $scope.getSelectPositionList();
      }
    });

  }
);
