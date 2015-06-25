rsasApp.controller('SystemMessages',function($scope, $rootScope, waitingIcon, systemMessageFactory) {
  $scope.current_year_id = $rootScope.current_year.id;
  $scope.current_process_id = $rootScope.current_process.id;

  $scope.edit_message = {};

  $scope.get_system_message_list = function(){
    waitingIcon.open();
    systemMessageFactory.getSystemMessageList($scope.current_year_id, $scope.current_process_id)
    .success(function(data){
      if(data.success){
        $scope.system_messages = data.system_messages;
        $scope.permission_to_active = data.permission_to_active;
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the system message list."});
      waitingIcon.close();
    });
  };

  $scope.editSystemMessage = function(system_message){
    $scope.editing_system_message = system_message;
    $scope.edit_message[system_message.id] = system_message.message;
    $("#editSystemMessage").modal("show");
  };


  $scope.updateSystemMessage = function(system_message){
    waitingIcon.open();
    system_message.message = $scope.edit_message[system_message.id];
    systemMessageFactory.updateSystemMessage(system_message, $scope.current_year_id, $scope.current_process_id)
    .success(function(data){
      if(data.success){
        $("#editSystemMessage").modal("hide");
        $scope.system_messages = data.system_messages;
        $rootScope.rsasAlert({type: 'success', msg: data.msg});
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: "Failed to update system message list."});
      waitingIcon.close();
    });
  };

  angular.element(document).ready(function (){
    if($rootScope.isRunNowProcess){
      $scope.get_system_message_list();
    }
  });
});
