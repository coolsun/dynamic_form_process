rsasApp.controller('Locations',
  function($scope, $rootScope, $window, CTableRsas, locationFactory, locationMgrFactory, waitingIcon) {
    $scope.current_process_id = $rootScope.current_process.id;
    $scope.locationTable = {};
    $scope.locationTable.tbl = new CTableRsas('locationTable.tbl', JSON_URL + '/locations');
    $scope.locationTable.tbl.setHeader(['Name', 1], ['Tag', 1], ['Description', 1], ['Location Manager', 0], ['Row House', 0]);
    $scope.locationTable.tbl.setDataAndRequest = function(){
      var data = {
        /////////  Need Location Data  //////////
        pageCount: $scope.locationTable.tbl.perPage,
        page: $scope.locationTable.tbl.goPage,
        searchText: $scope.locationTable.tbl.searchText,
        orderBy: $scope.locationTable.tbl.orderBy,
        ascOrDesc: $scope.locationTable.tbl.sortOrder,
        procedureId : $scope.current_process_id,
        "current_year_id": $rootScope.current_year.id,
        "current_process_id": $rootScope.current_process.id
      };
      $scope.locationTable.tbl.linkServerGetData($scope.locationTable.tbl, data);
    };

    $scope.locationTable.tbl.successDo = function(data){
      $scope.permission_to_active = data.permission_to_active;
    };

    $scope.new_location = {"procedure_id": $scope.current_process_id};
    $scope.edit_location = {};
    $scope.update_location = {};
    $scope.combineUserName = function(user){
      return combineUserName(user);
    };
    $scope.deleteLocation = function(input_arr) {
      waitingIcon.open();
      index = input_arr[0];
      location_id = input_arr[1];
      locationFactory.deleteLocation(location_id, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function(data){
        if(data.success){
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
          $scope.locationTable.tbl.show.splice(index, 1);
          $scope.locationTable.tbl.pTotal -= 1;
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function(data){
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to delete the location."});
        waitingIcon.close();
      });
    };
    $scope.insertLocation = function() {
      waitingIcon.open();
      locationFactory.insertLocation(this.new_location, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function(data){
        if(data.success){
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
          $scope.locationTable.tbl.show.splice(0 , 0, data.location);
          $scope.locationTable.tbl.pTotal += 1;
          $("#addLocation").modal("hide");
          $scope.new_location = {procedure_id: $scope.current_process_id};
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to create the location."});
        waitingIcon.close();
      });
    };
    $scope.editLocation = function(){
      $scope.edit_location = angular.copy(this.tblTr);
      $scope.update_location = this.tblTr;
    };
    $scope.updateLocation = function(){
      waitingIcon.open();
      locationFactory.updateLocation(this.edit_location, $rootScope.current_year.id, $rootScope.current_process.id).success(function(data){
        if(data.success){
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
          angular.extend($scope.update_location, $scope.edit_location);
          $("#editLocation").modal("hide");
          $scope.edit_location = {};
          $scope.update_location = {};
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to update the location."});
        waitingIcon.close();
      });
    };

    $scope.edit_location_mgrs = [];
    $scope.editLocationMgrs = function(){
      waitingIcon.open();
      $scope.edit_location_mgrs = [];
      $scope.location_mgrs_add_ids = [];
      $scope.location_mgrs_delete_ids = [];
      $scope.update_location = this.tblTr;
      locationMgrFactory.getSeletList(this.tblTr.id, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function(data){
        if(data.success){
	        $scope.edit_location_mgrs = data.location_mgrs;
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the location manager list."});
        waitingIcon.close();
      });
    };
    $scope.updateLocationMgrs = function(){
      waitingIcon.open();
      locationMgrFactory.updateLocationMgrs($scope.update_location.id, $scope.location_mgrs_add_ids, $scope.location_mgrs_delete_ids, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function(data){
        if(data.success){
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
          angular.extend($scope.update_location, data.location);
          $("#editLocationMgrs").modal("hide");
          $scope.edit_location_mgrs = [];
          $scope.update_location = [];
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to update the location managers."});
        waitingIcon.close();
      });
    };

    $scope.location_mgrs_add_ids = [];
    $scope.location_mgrs_delete_ids = [];
    $scope.checkLocationMgrs = function(location_mgr){
      if (location_mgr.is_select){
        var index_of = $scope.location_mgrs_delete_ids.indexOf(location_mgr.user_id);
        if(index_of != -1){
          $scope.location_mgrs_delete_ids.splice(index_of, 1);
        }
        $scope.location_mgrs_add_ids.push(location_mgr.user_id);
      }
      else{
        var index_of = $scope.location_mgrs_add_ids.indexOf(location_mgr.user_id);
        if(index_of != -1){
          $scope.location_mgrs_add_ids.splice(index_of, 1);
        }
        $scope.location_mgrs_delete_ids.push(location_mgr.user_id);
      }
    };
    angular.element(document).ready(function () {
      if($rootScope.isRunNowProcess){
        $scope.locationTable.tbl.init($scope, $scope.locationTable.tbl);
      }
    });
  }
);
