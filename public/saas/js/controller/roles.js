rsasApp.controller('Roles',
  function($scope, $rootScope, $window, CTableRsas, roleFactory, roleMgrFactory, waitingIcon) {
    $scope.current_process_id = $rootScope.current_process.id;
    $scope.RoleTable = {};
    $scope.RoleTable.tbl = new CTableRsas('RoleTable.tbl', JSON_URL + '/roles');
    $scope.RoleTable.tbl.setHeader(['Name', 1], ['Tag', 1], ['Description', 1], ['Role Manager', 0]);
    $scope.RoleTable.tbl.setDataAndRequest = function(){
      var data = {
        /////////  Need Role Data  //////////
        pageCount: $scope.RoleTable.tbl.perPage,
        page: $scope.RoleTable.tbl.goPage,
        searchText: $scope.RoleTable.tbl.searchText,
        orderBy: $scope.RoleTable.tbl.orderBy,
        ascOrDesc: $scope.RoleTable.tbl.sortOrder,
        procedureId : $scope.current_process_id,
        "current_year_id": $rootScope.current_year.id,
        "current_process_id": $rootScope.current_process.id
      };
      $scope.RoleTable.tbl.linkServerGetData($scope.RoleTable.tbl, data);
    };

    $scope.RoleTable.tbl.successDo = function(data){
      $scope.permission_to_active = data.permission_to_active;
    };

    $scope.new_role = {"procedure_id": $scope.current_process_id};
    $scope.edit_role = {};
    $scope.update_role = {};
    $scope.combineUserName = function(user){
      return combineUserName(user);
    };
    $scope.deleteRole = function(input_arr) {
      waitingIcon.open();
      index = input_arr[0];
      role_id = input_arr[1];
      roleFactory.deleteRole(role_id, $rootScope.current_year.id, $rootScope.current_process.id).success(function (data) {
        if(data.success){
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
          $scope.RoleTable.tbl.show.splice(index, 1);
          $scope.RoleTable.tbl.pTotal -= 1;
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function(data){
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to delete the role."});
        waitingIcon.close();
      });
    };
    $scope.insertRole = function() {
      waitingIcon.open();
      roleFactory.insertRole(this.new_role, $rootScope.current_year.id, $rootScope.current_process.id).success(function (data) {
        if(data.success){
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
          $scope.RoleTable.tbl.show.splice(0 , 0, data.role);
          $scope.RoleTable.tbl.pTotal += 1;
          $("#addRole").modal("hide");
          $scope.new_role = {"procedure_id": $scope.current_process_id};
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to create the role."});
        waitingIcon.close();
      });
    };
    $scope.editRole = function(){
      $scope.edit_role = angular.copy(this.tblTr);
      $scope.update_role = this.tblTr;
    };
    $scope.updateRole = function(){
      waitingIcon.open();
      roleFactory.updateRole(this.edit_role, $rootScope.current_year.id, $rootScope.current_process.id).success(function (data) {
        if(data.success){
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
          angular.extend($scope.update_role, $scope.edit_role);
          $("#editRole").modal("hide");
          $scope.edit_role = {};
          $scope.update_role = {};
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to update the role."});
        waitingIcon.close();
      });
    };

    $scope.edit_role_mgrs = [];
    $scope.editRoleMgrs = function(){
      waitingIcon.open();
      $scope.edit_role_mgrs = [];
      $scope.role_mgrs_add_ids = [];
      $scope.role_mgrs_delete_ids = [];
      $scope.update_role = this.tblTr;
      roleMgrFactory.getSeletList(this.tblTr.id, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function(data){
        if(data.success){
          $scope.edit_role_mgrs = data.role_mgrs;
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the role manager list."});
        waitingIcon.close();
      });
    };
    $scope.updateRoleMgrs = function(){
      waitingIcon.open();
      roleMgrFactory.updateRoleMgrs($scope.update_role.id, $scope.role_mgrs_add_ids, $scope.role_mgrs_delete_ids, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function(data){
        if(data.success){
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
          angular.extend($scope.update_role, data.role);
          $("#editRoleMgrs").modal("hide");
          $scope.edit_role_mgrs = [];
          $scope.update_role = [];
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to update the role managers."});
        waitingIcon.close();
      });
    };

    $scope.role_mgrs_add_ids = [];
    $scope.role_mgrs_delete_ids = [];
    $scope.checkRoleMgrs = function(role_mgr){
      if (role_mgr.is_select){
        var index_of = $scope.role_mgrs_delete_ids.indexOf(role_mgr.user_id);
        if(index_of != -1){
          $scope.role_mgrs_delete_ids.splice(index_of, 1);
        }
        $scope.role_mgrs_add_ids.push(role_mgr.user_id);
      }
      else{
        var index_of = $scope.role_mgrs_add_ids.indexOf(role_mgr.user_id);
        if(index_of != -1){
          $scope.role_mgrs_add_ids.splice(index_of, 1);
        }
        $scope.role_mgrs_delete_ids.push(role_mgr.user_id);
      }
    };
    angular.element(document).ready(function () {
      if($rootScope.isRunNowProcess){
        $scope.RoleTable.tbl.init($scope, $scope.RoleTable.tbl);
      }
    });
  }
);
