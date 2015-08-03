rsasApp.controller('Users',
  function($scope, $window, CTableRsas, userFactory, $rootScope, waitingIcon) {
    $scope.userTable = {};
    $scope.userTable.tbl = new CTableRsas('userTable.tbl', JSON_URL + '/users');
    $scope.userTable.tbl.setHeader(['Name', 1], ["SUNet ID", 1], ['Status', 1], ['Admin', 1], ['Hiring Manager', 0],['Location Manager', 0], ['Role Manager', 0], ['Interviewer', 0]);
    $scope.userTable.tbl.setDataAndRequest = function(){
      var data = {
        /////////  Need User Data  //////////
        pageCount: $scope.userTable.tbl.perPage,
        page: $scope.userTable.tbl.goPage,
        searchText: $scope.userTable.tbl.searchText,
        orderBy: $scope.userTable.tbl.orderBy,
        ascOrDesc: $scope.userTable.tbl.sortOrder,
        "current_year_id": $rootScope.current_year.id,
        "current_process_id": $rootScope.current_process.id
      };
      $scope.userTable.tbl.linkServerGetData($scope.userTable.tbl, data);
    };

    $scope.userTable.tbl.successDo = function(data){
      $scope.permission_to_active = data.permission_to_active;
    };

    $scope.init_new_user = function(){
      $scope.new_user = {
        "year_id": $rootScope.current_year.id,
        "status": "Staff",
        "is_admin": false
      };
    };

    $scope.edit_user = {};
    $scope.update_user = {};
    $scope.insertUser = function() {
      waitingIcon.open();
      userFactory.insertUser(this.new_user, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function(data){
        if(data.success){
          $scope.init_new_user();
          $scope.reloadTable();
          $("#addUser").modal("hide");
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to create the user."});
        waitingIcon.close();
      });
    };
    $scope.editUser = function(){
      $scope.edit_user = angular.copy(this.tblTr);
      $scope.update_user = this.tblTr;
    };
    $scope.updateUser = function(){
      waitingIcon.open();
      userFactory.updateUser(this.edit_user, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function (data) {
        if(data.success){
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
          $scope.reloadTable();
          $("#editUser").modal("hide");
          $scope.edit_user = {};
          $scope.update_user = {};
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to update the user."});
        waitingIcon.close();
      });
    };
    $scope.changeUser = function(user_id){
      if($window.confirm("Are you sure?")){
        waitingIcon.open();
        userFactory.changeUser(user_id, $rootScope.current_year.id, $rootScope.current_process.id)
        .success(function(data){
          if (data.success){
            $rootScope.current_user = data.authorities;
            $rootScope.header_permissions = data.permissions;
            $rootScope.rsasAlert({type: 'success', msg: data.msg});
            $window.location.reload();
          }
          else{
            $rootScope.rsasAlert({type: 'danger', msg: data.msg});
          }
          $("#editUser").modal("hide");
          waitingIcon.close();
        })
        .error(function (data){
          $rootScope.rsasAlert({type: 'danger', msg: "Failed to change the user."});
          waitingIcon.close();
        });
      }
    };

    $scope.deleteUser = function(input_arr) {
      waitingIcon.open();
      index = input_arr[0];
      user_id = input_arr[1];
      userFactory.deleteUser(user_id, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function(data){
        if(data.success){
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
          $scope.reloadTable();
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function(data){
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to delete the user."});
        waitingIcon.close();
      });
    };

    $scope.setRemoveUserConfirm = function(user_id){
      $rootScope.defaultConfirm(
        'Remove User',
        "You will remove all the data of this user, including the manager's setting in other processes for this user and the user's application. Are you sure to remove this user?",
        $scope.removeUser,
        user_id
      );
    };

    $scope.removeUser = function(user_id) {
      waitingIcon.open();
      userFactory.removeUser(user_id, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function(data){
        if(data.success){
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
          $scope.reloadTable();
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function(data){
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to remove the user."});
        waitingIcon.close();
      });
    };

    $scope.reloadTable = function(){
      $scope.userTable.tbl.searchClick($scope.userTable.tbl);
    };

    angular.element(document).ready(function () {
      $scope.init_new_user();
      $scope.userTable.tbl.init($scope, $scope.userTable.tbl);
    });
  }
);
