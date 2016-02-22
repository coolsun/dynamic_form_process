rsasApp.controller('UserRanking', function($scope, $rootScope, $filter, $sce, rankingFactory, waitingIcon){
  var orderBy = $filter('orderBy');
  $scope.set_rank_by_input = false;

  $scope.getUserRankList = function(){
    waitingIcon.open();
    rankingFactory.getUserRankList($rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      $scope.user_rank_list = data.user_rank_list;
      $scope.permission_to_active = data.permission_to_active;
      $scope.rank_position_applicant_view = $sce.trustAsHtml(data.rank_position_applicant_view);
      $scope.resetNewRank();
      waitingIcon.close();
    })
    .error(function(data){
      $rootScope.rsasAlert({type: 'danger', msg: 'Failed to get the rank list.'});
      waitingIcon.close();
    });
  };

  $scope.updateUserRank = function(){
    waitingIcon.open();
    rankingFactory.updateUserRank($scope.user_rank_list, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success){
        $scope.user_rank_list = data.user_rank_list;
        $scope.resetNewRank();
        $rootScope.rsasAlert({type: 'success', msg: data.msg});
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function(data){
      $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to update the rank.'});
      waitingIcon.close();
    });
  };

  $scope.resetNewRank = function(){
    if($scope.user_rank_list && $scope.user_rank_list.rank_applications){
      for(var i = 0; i < $scope.user_rank_list.rank_applications.length; i++){
        $scope.user_rank_list.rank_applications[i].new_rank = i + 1;
      };
    }
  };

  $scope.setRankbyInput = function(){
    $scope.set_rank_by_input = !$scope.set_rank_by_input;
    $scope.user_rank_list.rank_applications = orderBy($scope.user_rank_list.rank_applications, 'new_rank', false);
    $scope.resetNewRank();
  };

  $scope.removeFromRank = function(application_id){
    for(var i=0; i < $scope.user_rank_list.rank_applications.length; i++){
      if($scope.user_rank_list.rank_applications[i].id == application_id){
        $scope.user_rank_list.disable_rank_applications = $scope.user_rank_list.disable_rank_applications.concat($scope.user_rank_list.rank_applications.splice(i,1));
        $scope.resetNewRank();
        break;
      }
    }
  };

  $scope.addBackRank = function(application_id){
    for(var i=0; i < $scope.user_rank_list.disable_rank_applications.length; i++){
      if($scope.user_rank_list.disable_rank_applications[i].id == application_id){
        $scope.user_rank_list.rank_applications = $scope.user_rank_list.rank_applications.concat($scope.user_rank_list.disable_rank_applications.splice(i,1));
        $scope.resetNewRank();
        break;
      }
    }
  };
  $scope.sortableOptions = {
    handle: '> .Handle',
    stop: function(e, ui) {
      $scope.resetNewRank();
    }
  };

  angular.element(document).ready(function(){
    if($rootScope.isRunNowProcess){
      $scope.getUserRankList();
    }
  });
});

rsasApp.controller('Ranking', function($scope, $rootScope, $filter, $sce, rankingFactory, waitingIcon){
  var orderBy = $filter('orderBy');
  $scope.set_rank_by_input = false;
  $scope.match_conditions = [];
  $scope.match_tags = ["Men", "Women", "Either gender"];
  $scope.mathematical = [
    {key:"=",value: "="},
    {key:">",value: ">"},
    {key:"<",value: "<"},
    {key:">=",value: "≥"},
    {key:"<=",value: "≤"}
  ];

  $scope.getMgrRankList = function(){
    waitingIcon.open();

    rankingFactory.getMgrRankList(($scope.selected_location ? $scope.selected_location.id : null), $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success){
        if(!$scope.location_list){
          $scope.location_list = data.location_list;
        }
        $scope.mgr_rank_list = data.mgr_rank_list;
        $scope.permission_to_active = data.permission_to_active;
        $scope.rank_position_manager_view = $sce.trustAsHtml(data.rank_position_manager_view);
        $scope.match_conditions = data.match_conditions;
        $scope.resetNewRank();
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function(data){
      $rootScope.rsasAlert({type: 'danger', msg: 'Failed to get the rank list.'});
      waitingIcon.close();
    });
  };

  $scope.updateMgrRank = function(){
    waitingIcon.open();
    rankingFactory.updateMgrRank($scope.mgr_rank_list, $scope.match_conditions, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success){
        $scope.mgr_rank_list = data.mgr_rank_list;
        $scope.resetNewRank();
        $rootScope.rsasAlert({type: 'success', msg: data.msg});
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function(data){
      $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to update the rank.'});
      waitingIcon.close();
    });
  };

  $scope.resetNewRank = function(){
    if($scope.mgr_rank_list && $scope.mgr_rank_list.rank_applications){
      for(var i = 0; i < $scope.mgr_rank_list.rank_applications.length; i++){
        $scope.mgr_rank_list.rank_applications[i].new_rank = i + 1;
      };
    }
  };

  $scope.setRankbyInput = function(){
    $scope.set_rank_by_input = !$scope.set_rank_by_input;
    $scope.mgr_rank_list.rank_applications = orderBy($scope.mgr_rank_list.rank_applications, 'new_rank', false);
    $scope.resetNewRank();
  };

  $scope.removeFromRank = function(application_id){
    for(var i=0; i < $scope.mgr_rank_list.rank_applications.length; i++){
      if($scope.mgr_rank_list.rank_applications[i].id == application_id){
        $scope.mgr_rank_list.disable_rank_applications = $scope.mgr_rank_list.disable_rank_applications.concat($scope.mgr_rank_list.rank_applications.splice(i,1));
        $scope.resetNewRank();
        break;
      }
    }
  };

  $scope.addBackRank = function(application_id){
    for(var i=0; i < $scope.mgr_rank_list.disable_rank_applications.length; i++){
      if($scope.mgr_rank_list.disable_rank_applications[i].id == application_id){
        $scope.mgr_rank_list.rank_applications = $scope.mgr_rank_list.rank_applications.concat($scope.mgr_rank_list.disable_rank_applications.splice(i,1));
        $scope.resetNewRank();
        break;
      }
    }
  };

  $scope.sortableOptions = {
    handle: '> .Handle',
    stop: function(e, ui) {
      $scope.resetNewRank();
    }
  };

  angular.element(document).ready(function () {
    if($rootScope.isRunNowProcess){
      $scope.getMgrRankList();
    }
  });
});
