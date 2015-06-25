var processModule = angular.module('processApp', []);

processModule.controller('process_control', function($scope, $window, CTableRsas, processFactory, hiringMgrFactory, rdMgrFactory, applyWhiteListFactory, $rootScope, waitingIcon) {
  $scope.processTable = {};
  $scope.processTable.tbl = new CTableRsas('processTable.tbl', JSON_URL + '/procedures');
  $scope.processTable.tbl.setHeader(['Name', 1], ['Status', 1], ['Display Order', 1], ['Hiring Managers', 0], ['RD Managers', 0]);
  $scope.processTable.tbl.setDataAndRequest = function(){
    var data = {
      /////////  Need Process Data  //////////
      pageCount: $scope.processTable.tbl.perPage,
      page: $scope.processTable.tbl.goPage,
      searchText: $scope.processTable.tbl.searchText,
      orderBy: $scope.processTable.tbl.orderBy,
      ascOrDesc: $scope.processTable.tbl.sortOrder,
      procedureId: 0,
      "current_year_id": $rootScope.current_year.id,
      "current_process_id": $rootScope.current_process.id
    };
    $scope.processTable.tbl.linkServerGetData($scope.processTable.tbl, data);
  };

  $scope.processTable.tbl.successDo = function(data)
  {
    console.log(data);
    if(data.success){
      $scope.permission_to_active = data.permission_to_active;
    }
    else{
      $rootScope.rsasAlert({type: 'danger', msg: data.msg});
    }
  };

  $scope.check_recommendation_form_open = function(process){
    if(process.status) {
      waitingIcon.open();
      $scope.save_button_disabled = true;
      $scope.no_recommendation_form_open = false;
      processFactory.checkRecommendationFormOpen(process.id, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function(data){
        if(data.success) {
          $scope.save_button_disabled = data.save_button_disabled && process.status;
          $scope.no_recommendation_form_open = data.save_button_disabled && process.status;
        }
        else {
          $rootScope.rsasAlert({type: 'danger', msg: "Failed to check the recommendation form number."});
        }
        waitingIcon.close();
      })
      .error(function(){
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to check the recommendation form number."});
        waitingIcon.close();
      });
    }
    else {
      $scope.save_button_disabled = false;
      $scope.no_recommendation_form_open = false;
    }
  };

  $scope.GoToProcessSetting = function(process){
    console.log(process);
    $rootScope.current_process = process;
    if($scope.current_user.is_admin){
      location.href = "#/" + $rootScope.current_year.name + "/" + $rootScope.current_process.acronym + "/process_step";
    }
    else{
      location.href = "#/" + $rootScope.current_year.name + "/" + $rootScope.current_process.acronym + "/process_step/interview";
    }
  };

  $scope.GoToUserPage = function(process){
    console.log(process);
    $rootScope.current_process = process;

    location.href = "#/" + $rootScope.current_year.name + "/" + $rootScope.current_process.acronym + "/users";
  };

  $scope.remove = function(index){
    if($window.confirm("Are you sure to delete this process? The process can NOT be recovered once you deleted it.")){
      waitingIcon.open();
      processFactory.deleteProcess(this.tblTr.id, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function (data) {
        if(data.success){
          $scope.processTable.tbl.show.splice(index, 1);
          $scope.processTable.tbl.pTotal -= 1;
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to delete the process."});
        waitingIcon.close();
      });
    };
  };

  $scope.editProcess = function(){
    $scope.editing_process = angular.copy(this.tblTr);
    $scope.update_process = this.tblTr;
  };

  $scope.updateProcess = function(){
    waitingIcon.open();
    var old_display_order = 0;
    var new_display_order = parseInt($scope.editing_process.rank);
    origin_sort = angular.copy($scope.processTable.tbl.show);

    for(var i = 0; i < $scope.processTable.tbl.show.length; i++){
      if($scope.processTable.tbl.show[i].id == $scope.editing_process.id){
        old_display_order = $scope.processTable.tbl.show[i].rank;
        $scope.processTable.tbl.show.splice(i, 1);
        break;
      }
    }
    if(old_display_order > new_display_order){
      $scope.editing_process.rank = new_display_order - 0.5;
    }
    else{
      $scope.editing_process.rank = new_display_order + 0.5;
    }

    $scope.processTable.tbl.show.push($scope.editing_process);
    $scope.processTable.tbl.show.sort(function(a, b) { return parseInt(a.rank) > parseInt(b.rank); } );
    for(var i = 0; i < $scope.processTable.tbl.show.length; i++){
      if ($scope.processTable.tbl.show[i].rank != (i + 1)){
        $scope.processTable.tbl.show[i].rank = i + 1;
        processFactory.updateProcess($scope.processTable.tbl.show[i], $rootScope.current_year.id, $rootScope.current_process.id)
        .success(function (data) {
          if(data.success){
            $rootScope.rsasAlert({type: 'success', msg: data.msg});
            angular.extend($scope.update_process, $scope.editing_process);
            $scope.editing_process = {};
            $scope.update_process = {};
          }
          else{
            $rootScope.rsasAlert({type: 'danger', msg: data.msg});
          }
          $("#editProcess").modal("hide");
          waitingIcon.close();
        })
        .error(function (data) {
          $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to update the process."});
          $("#editProcess").modal("hide");
          waitingIcon.close();
        });
      }
    };
  };

  $scope.initNewProcess = function(){
    $scope.new_process = {
      name: "",
      acronym: "",
      year_id: $rootScope.current_year.id
    };

    $scope.new_apply_white_list = {};
  };

  $scope.addProcess = function(){
    waitingIcon.open();
    processFactory.insertProcess(this.new_process, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function (data) {
      if(data.success){
        $rootScope.rsasAlert({type: 'success', msg: data.msg});
        $scope.processTable.tbl.show.splice(0 , 0, data.procedure);
        $scope.processTable.tbl.pTotal += 1;
        $scope.initNewProcess();
        $("#addProcess").modal("hide");
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        $scope.new_process.error_msg = data.msg;
      }

      waitingIcon.close();
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: "Failed to create the process."});
      $scope.new_process.error_msg = "Failed to create the process.";
      waitingIcon.close();
    });
  };

  $scope.setCloneProcess = function(clone_process_id){
    $scope.initNewProcess();
    $scope.clone_process_id = clone_process_id;
  };

  $scope.cloneProcess = function(){
    waitingIcon.open();
    processFactory.cloneProcess(this.new_process, $scope.clone_process_id, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function (data) {
      if(data.success){
        $rootScope.rsasAlert({type: 'success', msg: data.msg});
        $scope.initNewProcess();
        $("#cloneProcess").modal("hide");
        $scope.reloadTable();
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        $scope.new_process.error_msg = data.msg;
      }
      waitingIcon.close();
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: "Failed to clone the process."});
      $scope.new_process.error_msg = "Failed to clone the process.";
      waitingIcon.close();
    });
  };

  $scope.edit_hiring_mgrs = [];
  $scope.editHiringMgrs = function(process){
    waitingIcon.open();
    $rootScope.current_process = process;
    $scope.edit_hiring_mgrs = [];
    $scope.hiring_mgrs_add_ids = [];
    $scope.hiring_mgrs_delete_ids = [];
    $scope.update_procedure = this.tblTr;
    hiringMgrFactory.getSeletList(this.tblTr.id, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success){
        $scope.edit_hiring_mgrs = data.procedure_mgrs;
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the hiring manager list."});
      waitingIcon.close();
    });
  };
  $scope.updateHiringMgrs = function(){
    waitingIcon.open();
    hiringMgrFactory.updateHiringMgrs($scope.update_procedure.id, $scope.hiring_mgrs_add_ids, $scope.hiring_mgrs_delete_ids, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success){
        $rootScope.rsasAlert({type: 'success', msg: data.msg});
        angular.extend($scope.update_procedure, data.procedure);
        $scope.edit_hiring_mgrs = [];
        $scope.update_procedure = [];
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      $("#editHiringMgrs").modal("hide");
      waitingIcon.close();
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to update the hiring managers."});
      waitingIcon.close();
    });
  };

  $scope.hiring_mgrs_add_ids = [];
  $scope.hiring_mgrs_delete_ids = [];
  $scope.checkHiringMgrs = function(hiring_mgr){
    if (hiring_mgr.is_select){
      var index_of = $scope.hiring_mgrs_delete_ids.indexOf(hiring_mgr.user_id);
      if(index_of != -1){
        $scope.hiring_mgrs_delete_ids.splice(index_of, 1);
      }
      $scope.hiring_mgrs_add_ids.push(hiring_mgr.user_id);
    }
    else{
      var index_of = $scope.hiring_mgrs_add_ids.indexOf(hiring_mgr.user_id);
      if(index_of != -1){
        $scope.hiring_mgrs_add_ids.splice(index_of, 1);
      }
      $scope.hiring_mgrs_delete_ids.push(hiring_mgr.user_id);
    }
  };

  $scope.edit_rd_mgrs = [];
  $scope.editRdMgrs = function(process) {
    waitingIcon.open();
    $rootScope.current_process = process;
    $scope.edit_rd_mgrs = [];
    $scope.rd_mgrs_add_ids = [];
    $scope.rd_mgrs_delete_ids = [];
    $scope.update_procedure = this.tblTr;
    rdMgrFactory.getSeletList(this.tblTr.id, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success){
        $scope.edit_rd_mgrs = data.rd_mgrs;
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the RD manager list."});
      waitingIcon.close();
    });
  };
  $scope.updateRdMgrs = function(){
    waitingIcon.open();
    rdMgrFactory.updateRdMgrs($scope.update_procedure.id, $scope.rd_mgrs_add_ids, $scope.rd_mgrs_delete_ids, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success){
        $rootScope.rsasAlert({type: 'success', msg: data.msg});
        angular.extend($scope.update_procedure, data.procedure);
        $scope.edit_rd_mgrs = [];
        $scope.update_procedure = [];
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      $("#editRdMgrs").modal("hide");
      waitingIcon.close();
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to update the RD managers."});
      waitingIcon.close();
    });
  };

  $scope.rd_mgrs_add_ids = [];
  $scope.rd_mgrs_delete_ids = [];
  $scope.checkRdMgrs = function(rd_mgr){
    if (rd_mgr.is_select){
      var index_of = $scope.rd_mgrs_delete_ids.indexOf(rd_mgr.user_id);
      if(index_of != -1){
        $scope.rd_mgrs_delete_ids.splice(index_of, 1);
      }
      $scope.rd_mgrs_add_ids.push(rd_mgr.user_id);
    }
    else{
      var index_of = $scope.rd_mgrs_add_ids.indexOf(rd_mgr.user_id);
      if(index_of != -1){
        $scope.rd_mgrs_add_ids.splice(index_of, 1);
      }
      $scope.rd_mgrs_delete_ids.push(rd_mgr.user_id);
    }
  };

  $scope.editApplyWhiteLists = function(process) {
    waitingIcon.open();
    $rootScope.current_process = process;
    $scope.apply_white_lists = [];
    applyWhiteListFactory.getWhiteList($rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success){
        $scope.apply_white_lists = data.apply_white_lists;
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the apply white list."});
      waitingIcon.close();
    });
  };

  $scope.createApplyWhiteList = function(){
    waitingIcon.open();
    applyWhiteListFactory.createApplyWhiteList($scope.new_apply_white_list ,$rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success){
        $scope.apply_white_lists = data.apply_white_lists;
        $rootScope.rsasAlert({type: 'success', msg: data.msg});
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to create the apply white list."});
      waitingIcon.close();
    });
  };

  $scope.deleteApplyWhiteList = function(user_id){
    waitingIcon.open();
    applyWhiteListFactory.deleteApplyWhiteList(user_id ,$rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success){
        $scope.apply_white_lists = data.apply_white_lists;
        $rootScope.rsasAlert({type: 'success', msg: data.msg});
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to delete the apply white list."});
      waitingIcon.close();
    });
  };

  $scope.reloadTable = function(){
    $scope.processTable.tbl.searchClick($scope.processTable.tbl);
  };

  angular.element(document).ready(function () {
    $scope.initNewProcess();
    $scope.processTable.tbl.init($scope, $scope.processTable.tbl);
  });
});
