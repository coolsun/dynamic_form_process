rsasApp.controller('TermsAppointment',
  function($scope, $rootScope, $window, CTableRsas, roleFactory, roleMgrFactory, waitingIcon) {
    $scope.current_process_id = $rootScope.current_process.id;
    $scope.RoleTable = {};
    $scope.RoleTable.tbl = new CTableRsas('RoleTable.tbl', JSON_URL + '/roles');
    $scope.RoleTable.tbl.setHeader(['Name', 1], ['Terms of Appointment', 0]);
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

    $scope.new_role = {"procedure_id": $scope.current_process_id, "offer_appointment": "Do you really want to confirm/decline this job offer?\nOnce you confirm a job, you will not be able to accept other jobs."};
    $scope.edit_role = {};
    $scope.update_role = {};
    $scope.combineUserName = function(user){
      return combineUserName(user);
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

    angular.element(document).ready(function () {
      if($rootScope.isRunNowProcess){
        $scope.RoleTable.tbl.init($scope, $scope.RoleTable.tbl);
      }
    });
  }
);
