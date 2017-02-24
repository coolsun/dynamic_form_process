rsasApp.controller('Matching', function($scope, $rootScope, matchingFactory, waitingIcon){
  $scope.matching = {};
  $scope.match_conditions = [];
  $scope.mathematical = [
    {key:"==",value: "="},
    {key:">",value: ">"},
    {key:"<",value: "<"},
    {key:">=",value: "≥"},
    {key:"<=",value: "≤"}
  ];
  $scope.sexes = [
    {key:"Male",value: "Male"},
    {key:"Female",value: "Female"}
    //{key:"Other",value: "Either gender"}
  ];

  $scope.getMatchData = function(){
    waitingIcon.open();
    matchingFactory.getMatchData($rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success){
        $scope.matching = data.match_data;
        $scope.locations = data.locations;
        $scope.permission_to_active = data.permission_to_active;
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function(data){
      $rootScope.rsasAlert({type: 'danger', msg: 'Failed to get match info.'});
      waitingIcon.close();
    });
  };

  $scope.match = function(){
    waitingIcon.open();
    matchingFactory.match($scope.match_conditions, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success){
        $scope.matching = data.match_data;
        $rootScope.rsasAlert({type: 'success', msg: data.msg});
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function(data){
      $rootScope.rsasAlert({type: 'danger', msg: 'Failed to match.'});
      waitingIcon.close();
    });
  };

  angular.element(document).ready(function () {
    if($rootScope.isRunNowProcess){
      $scope.getMatchData();
    }
  });
});
