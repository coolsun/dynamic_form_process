rsasApp.controller('Years',
  function($scope, $rootScope, $window, CTableRsas, yearFactory, waitingIcon) {
    $scope.yearTable = {};
    $scope.yearTable.tbl = new CTableRsas('yearTable.tbl', JSON_URL + '/years');
    $scope.yearTable.tbl.setHeader(['Current Year', 0], ['Admin Current Year', 0], ['Name', 1], ['Next Year', 1]);
    $scope.yearTable.tbl.setDataAndRequest = function(){
      var data = {
        /////////  Need Year Data  //////////
        pageCount: $scope.yearTable.tbl.perPage,
        page: $scope.yearTable.tbl.goPage,
        searchText: $scope.yearTable.tbl.searchText,
        orderBy: $scope.yearTable.tbl.orderBy,
        ascOrDesc: $scope.yearTable.tbl.sortOrder,
        procedureId : $rootScope.current_process.id,
        "current_year_id": $rootScope.current_year.id,
        "current_process_id": $rootScope.current_process.id
      };
      $scope.yearTable.tbl.linkServerGetData($scope.yearTable.tbl, data);
    };

    $scope.yearTable.tbl.successDo = function(data){
      $scope.permission_to_active = data.permission_to_active;
    };

    $scope.edit_year = {};
    $scope.update_year = {};

    $scope.deleteYear = function(input) {
      waitingIcon.open();
      index = input[0];
      year_id = input[1];
      yearFactory.deleteYear(year_id, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function(data){
        if(data.success){
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
          $scope.yearTable.tbl.show.splice(index, 1);
          $scope.yearTable.tbl.pTotal -= 1;
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function(data){
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to delete the year."});
        waitingIcon.close();
      });
    };
    $scope.insertYear = function() {
      waitingIcon.open();
      yearFactory.insertYear(this.new_year, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function(data){
        if(data.success){
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
          $scope.yearTable.tbl.show.splice(0 , 0, data.year);
          $scope.yearTable.tbl.pTotal += 1;
          $("#addYear").modal("hide");
          $scope.new_year = {};
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to create the year."});
        waitingIcon.close();
      });
    };
    $scope.editYear = function(){
      $scope.edit_year = angular.copy(this.tblTr);
      $scope.update_year = this.tblTr;
    };
    $scope.updateYear = function(){
      waitingIcon.open();
      yearFactory.updateYear(this.edit_year, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function(data){
        if(data.success){
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
          angular.extend($scope.update_year, $scope.edit_year);
          $("#editYear").modal("hide");
          $scope.edit_year = {};
          $scope.update_year = {};
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to update the year."});
        waitingIcon.close();
      });
    };

    $scope.setCurrentYearConfirm = function(){
      $rootScope.defaultConfirm(
        'Set Current Year',
        'Causion : You are changing the current year of this webpage. This setting will influence all the users in this website.',
        $scope.setCurrentYear,
        this.tblTr.id
      );
    };

    $scope.setCurrentYear = function(year_id) {
      waitingIcon.open();
      yearFactory.setCurrentYear(year_id, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function(data){
        if(data.success){
          $window.location.reload();
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function(data){
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to set the current year."});
        waitingIcon.close();
      });
    };

    $scope.adminSwitchYearConfirm = function(){
      $rootScope.defaultConfirm(
        'Admin Switch Year',
        'Switching to the selected year will not influence other users.',
        $scope.adminSwitchYear,
        this.tblTr.id
      );
    };

    $scope.adminSwitchYear = function(year_id){
      waitingIcon.open();
      yearFactory.adminSwitchYear(year_id, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function(data){
        if(data.success){
          $rootScope.current_year = data.current_year;
          $rootScope.current_process = data.current_process;
          $rootScope.index.processes = data.processes;
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function(data){
        $rootScope.rsasAlert({type: 'danger', msg: "There was a problem from admin to switch the year."});
        waitingIcon.close();
      });
    };

    angular.element(document).ready(function () {
      $scope.yearTable.tbl.init($scope, $scope.yearTable.tbl);
    });
  }
);
