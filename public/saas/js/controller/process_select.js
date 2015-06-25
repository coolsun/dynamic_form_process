rsasApp.controller('processSelect',
  function($scope, processFactory, $rootScope, waitingIcon) {
    $scope.processes = [];

    $scope.mgrProceduresSelect = function(){
      waitingIcon.open();
      processFactory.mgrProceduresSelect($rootScope.current_year.id, $rootScope.current_process.id)
      .success(function(data){
        if(data.success){
          $scope.processes = data.procedures;
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function(data){
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the processes."});
        waitingIcon.close();
      });
    };

    $scope.changeProcess = function(){
      $rootScope.current_process = $scope.prcoess;
      location.href = "#/" + $rootScope.current_year.name + "/" + $rootScope.current_process.acronym + "/process_step/process/manage-applicants";
    };

    angular.element(document).ready(function () {
      $scope.mgrProceduresSelect();
    });
  }
);
