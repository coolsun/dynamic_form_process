rsasApp.controller('SubmitApplication', function($scope, $rootScope, applicantFactory, waitingIcon) {

  $scope.submitApplication = function(){
    waitingIcon.open();
    applicantFactory.submitApplication($rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success){
        $rootScope.rsasAlert({type: 'success', msg: data.msg});
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      };
      $rootScope.getApplicantStatus(false);
      waitingIcon.close();
    })
    .error(function(data){
      if($rootScope.applicantApplicationStatus.submit_application){
      	$rootScope.rsasAlert({type: 'danger', msg: "Failed to withdraw the application."});
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to submit the application."});
      };
      waitingIcon.close();
    });
  };

});