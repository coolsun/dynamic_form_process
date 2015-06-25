rsasApp.controller('Reports',function($scope, $rootScope, waitingIcon, reportFactory) {
  $scope.current_year_id = $rootScope.current_year.id;
  $scope.current_process_id = $rootScope.current_process.id;

  //init
  $scope.procedures = [];
  $scope.init = function(){
    waitingIcon.open();
    reportFactory.index($rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success){
        $scope.permission_to_show = data.permission_to_show;
        $scope.procedures = data.procedures;
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function(data){
      $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to get the relevant information of report."});
      waitingIcon.close();
    });
  };

  //Applicant List
  $scope.applicant_list = {};

  $scope.exportFormSchema = function(){
    waitingIcon.open();
    reportFactory.ExportFormSchema($rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success){
        $rootScope.rsasAlert({type: 'success', msg: data.msg});
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function(data){
      $rootScope.rsasAlert({type: 'danger', msg: "Failed to export the form schema."});
      waitingIcon.close();
    });
  };

  angular.element(document).ready(function (){
    $scope.init();
  });
});
