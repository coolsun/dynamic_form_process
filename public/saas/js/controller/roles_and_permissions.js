rsasApp.controller('RolesAndPermissions',function($scope, $rootScope, waitingIcon, permissionFactory) {

  $scope.getPermissionList = function(){
    $scope.permission_list = [];
    waitingIcon.open();
    permissionFactory.getPermissionList($rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success){
        $scope.permission_list = data.permission_list;
        $scope.permission_to_active = data.permission_to_active;
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function(data){
      $rootScope.rsasAlert({type: 'danger', msg: 'Failed to get the permission list.'});
      waitingIcon.close();
    });
  };

  $scope.updatePermissions = function(){
    waitingIcon.open();
    permissionFactory.updatePermissions($scope.permission_list, $rootScope.current_year.id, $rootScope.current_process.id)
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
      $rootScope.rsasAlert({type: 'danger', msg: 'Failed to get the permission list.'});
      waitingIcon.close();
    });
  };

  angular.element(document).ready(function () {
    if($rootScope.isRunNowProcess){
      $scope.getPermissionList();
    }
  });
});
