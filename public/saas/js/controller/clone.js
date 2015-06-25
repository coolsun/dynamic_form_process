rsasApp.controller('Clone',function($scope, $rootScope, waitingIcon, yearFactory, processFactory) {
  $scope.current_year_id = $rootScope.current_year.id;
  $scope.current_process_id = $rootScope.current_process.id;

  $scope.source_year = {};
  $scope.target_year = {};

  $scope.get_year_list = function(){
    waitingIcon.open();
    yearFactory.getYearList($scope.current_year_id, $scope.current_process_id)
    .success(function(data){
      if(data.success){
        $scope.years = data.years;
        $scope.permission_to_active = data.permission_to_active;
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the year list."});
      waitingIcon.close();
    });
  };

  $scope.showCloneConfirm = function(){
    if(!$scope.source_year.id || !$scope.target_year.id){
      $rootScope.defaultDialog("Source Year and Target Year are required.");
    }
    else if($scope.source_year.procedures.length == 0){
      $rootScope.defaultDialog("No process need to clone.");
    }
    else if($scope.source_year.id == $scope.target_year.id){
      $rootScope.defaultDialog("Source Year and Target Year can not be the same year.");
    }
    else{
      $("#cloneConfirm").modal("show");
    }
  };

  $scope.cloneAllProcedures = function(){
    waitingIcon.open();
    processFactory.cloneAllProcess($scope.source_year.id, $scope.target_year.id, $scope.current_year_id, $scope.current_process_id)
    .success(function(data){
      if(data.success){
        $scope.years = data.years;
        $rootScope.rsasAlert({type: 'success', msg: data.msg});
        $("#cloneConfirm").modal("hide");
      }
      else{
        $scope.clone_messages = data.clone_messages;
      }
      waitingIcon.close();
    })
    .error(function (data) {
      $scope.clone_messages = ["Clone process error"];
      waitingIcon.close();
    });
  };

  angular.element(document).ready(function (){
    $scope.get_year_list();
  });
});
