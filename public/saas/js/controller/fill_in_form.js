rsasApp.controller('FillInForm', function($scope, $rootScope, formFactory, waitingIcon){
  $scope.forms = [];

  $scope.getApplicationFormList = function(){
    waitingIcon.open();
    formFactory.getApplicationFormList($rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success){
        $scope.forms = data.forms;
        $scope.permission_to_active = data.permission_to_active;
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function(data){
      $rootScope.rsasAlert({type: 'danger', msg: 'Failed to get the rank list.'});
      waitingIcon.close();
    });
  };

  $scope.updateFormRank = function(){
    waitingIcon.open();
    form_rank = [];
    for(index in $scope.forms){
      form_rank.push($scope.forms[index].id);
    };
    formFactory.updateFormRank(form_rank, $rootScope.current_year.id, $rootScope.current_process.id)
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
      $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to update the rank.'});
      waitingIcon.close();
    });
  };
  
  angular.element(document).ready(function(){
    if($rootScope.isRunNowProcess){
      $scope.getApplicationFormList();
    }
  });
});
