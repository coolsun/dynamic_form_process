rsasApp.controller('Positions',
  function($scope, $rootScope, $window, CTableRsas, positionFactory, waitingIcon) {
    $scope.current_process_id = $rootScope.current_process.id;
    $scope.positionTable = {};
    $scope.positionTable.tbl = new CTableRsas('positionTable.tbl', JSON_URL + '/positions');
    $scope.positionTable.tbl.setHeader(['Name', 1], ['Tag', 1], ['Description', 1], ['Vacancy', 1], ['Auto Matching', 1], ['One Year Up', 1]);
    $scope.positionTable.tbl.setDataAndRequest = function(){
      var data = {
        /////////  Need Position Data  //////////
        pageCount: $scope.positionTable.tbl.perPage,
        page: $scope.positionTable.tbl.goPage,
        searchText: $scope.positionTable.tbl.searchText,
        orderBy: $scope.positionTable.tbl.orderBy,
        ascOrDesc: $scope.positionTable.tbl.sortOrder,
        procedureId : $scope.current_process_id,
        "current_year_id": $rootScope.current_year.id,
        "current_process_id": $rootScope.current_process.id
      };
      $scope.positionTable.tbl.linkServerGetData($scope.positionTable.tbl, data);
    };

    $scope.positionTable.tbl.successDo = function(data){
      $scope.permission_to_active = data.permission_to_active;
    };

    $scope.new_position = {"procedure_id": $scope.current_process_id};
    $scope.edit_position = {};
    $scope.update_position = {};
    $scope.combinePositionName = function(position){
      if(position.role && position.location){
        return [position.location.name, position.role.name].join("-");
      }
      else{
        return "";
      }
    };
    $scope.combinePositionNameUseID = function(position){
      if(position.role_id && position.location_id){
        if(findObj($scope.locations, "id", position.location_id) && findObj($scope.roles, "id", position.role_id)){
          return [findObj($scope.locations, "id", position.location_id).name, findObj($scope.roles, "id", position.role_id).name].join("-");
        }
        else{
          return "";
        }
      }
      else{
        return "";
      }
    };
    $scope.deletePosition = function(index) {
      if($window.confirm("Are you sure?")){
        waitingIcon.open();
        positionFactory.deletePosition(this.tblTr.id, $rootScope.current_year.id, $rootScope.current_process.id).success(function (data) {
          if(data.success){
            $rootScope.rsasAlert({type: 'success', msg: data.msg});
            $scope.positionTable.tbl.show.splice(index, 1);
            $scope.positionTable.tbl.pTotal -= 1;
          }
          else{
            $rootScope.rsasAlert({type: 'danger', msg: data.msg});
          }
          waitingIcon.close();
        })
        .error(function(data){
          $rootScope.rsasAlert({type: 'danger', msg: "Failed to delete the position."});
          waitingIcon.close();
        });
      };
    };
    $scope.addPosition = function() {
      waitingIcon.open();
      $scope.new_position.auto_matching = true;
      $scope.new_position.one_year_up = false;
      $scope.new_position.offer_appointment = "Do you really want to confirm/decline this job offer?\nOnce you confirm a job, you will not be able to accept other jobs.";
      positionFactory.getSelectLists($rootScope.current_year.id, $rootScope.current_process.id)
      .success(function (data) {
        if(data.success){
	        $scope.roles = data.roles;
  	      $scope.locations = data.locations;
  	    }
  	    else{
  	    	$rootScope.rsasAlert({type: 'danger', msg: data.msg});
  	    }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the position list."});
        waitingIcon.close();
      });
    };
    $scope.insertPosition = function() {
      waitingIcon.open();
      positionFactory.insertPosition(this.new_position, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function (data) {
        if(data.success){
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
          $("#addPosition").modal("hide");
          $scope.new_position = {"procedure_id": $scope.current_process_id};
          $scope.reloadTable();
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to create the position."});
        waitingIcon.close();
      });
    };
    $scope.editPosition = function(){
      waitingIcon.open();
      positionFactory.getSelectLists($rootScope.current_year.id, $rootScope.current_process.id)
      .success(function (data) {
        if(data.success){
	        $scope.roles = data.roles;
  	      $scope.locations = data.locations;
  	    }
  	    else{
  	    	$rootScope.rsasAlert({type: 'danger', msg: data.msg});
  	    }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the position list."});
        waitingIcon.close();
      });
      $scope.edit_position = angular.copy(this.tblTr);
      $scope.update_position = this.tblTr;
    };
    $scope.updatePosition = function(){
      waitingIcon.open();
      positionFactory.updatePosition(this.edit_position, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function (data) {
        if(data.success){
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
          angular.extend($scope.update_position, data.position);
          $("#editPosition").modal("hide");
          $scope.edit_position = {};
          $scope.update_position = {};
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to update the position."});
        waitingIcon.close();
      });
    };

    $scope.reloadTable = function(){
      $scope.positionTable.tbl.searchClick($scope.positionTable.tbl);
    };

    angular.element(document).ready(function () {
      if($rootScope.isRunNowProcess){
        $scope.positionTable.tbl.init($scope, $scope.positionTable.tbl);
      }
    });
  }
);
