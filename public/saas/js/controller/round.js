/**
 * target: admin procedure function
 */
var roundApp = angular.module('roundApp', ['ui.bootstrap', "waitingIconModule"]);
roundApp
.controller('roundCtrl', function($rootScope, $scope, $http, CTableRsas, waitingIcon){
  //$scope.dt = '';
  $scope.inputNotSetCss = 'hasErrorInput';
  $scope.eCode = '';

  $scope.round = {};
  $scope.round.processId = $rootScope.current_process.id;
  $scope.round.flow = 0;
  $scope.round.procedure = {};
  $scope.round.locationShow = [];
  $scope.round.roleShow = [];

  $scope.round.create = {};
  $scope.round.create.timepicker = {};

  $scope.round.edit = {};
  $scope.round.edit.round = {};
  $scope.round.edit.timepicker = {};
  $scope.round.edit.selectedLocations = [];
  $scope.round.edit.selectedRoles = [];

  $scope.round.remove = {};
  $scope.round.remove.round = {};

  $scope.round.tbl = new CTableRsas('round.tbl', JSON_URL + '/rounds/');
  $scope.round.tbl.setHeader(['title', 0], ['start', 0], ['end', 0], ['locations', 0], ['roles', 0]);
  $scope.round.tbl.dropdownClick ={};

  $scope.round.getProcessLocationsAndRounds = function()
  {
    var postData = {
      "current_year_id": $rootScope.current_year.id,
      "current_process_id": $rootScope.current_process.id
    };

    waitingIcon.open();
    $http({
      url: JSON_URL + "/procedures/get_locations_and_roles",
      method: "POST",
      data: postData
    })
    .success(function (data, status, headers, config) {
      waitingIcon.close();

      $scope.round.procedure.locations = angular.copy(data.locations);
      $scope.round.procedure.roles = angular.copy(data.roles);

      $scope.round.create.selectLocationList = angular.copy($scope.round.procedure.locations);
      $scope.round.create.selectRoleList = angular.copy($scope.round.procedure.roles);
      $scope.round.edit.selectLocationList = angular.copy($scope.round.procedure.locations);
      $scope.round.edit.selectRoleList = angular.copy($scope.round.procedure.roles);
    })
    .error(function (data, status, headers, config) {
      waitingIcon.close();
    });
  };


  $scope.round.tbl.setDataAndRequest = function()
  {
    var data = {
      pageCount: $scope.round.tbl.perPage,
      page: $scope.round.tbl.goPage,
      searchText: $scope.round.tbl.searchText,
      orderBy: $scope.round.tbl.orderBy,
      ascOrDesc: $scope.round.tbl.sortOrder,
      procedureId: $scope.round.processId,
      "current_year_id": $rootScope.current_year.id,
      "current_process_id": $rootScope.current_process.id
    };
    $scope.round.tbl.linkServerGetData($scope.round.tbl, data);
  };

  $scope.round.tbl.successDo = function(data){
    if(data.success){
      $scope.permission_to_active = data.permission_to_active;

      var show = $scope.round.tbl.show;
      var locations = [];
      var roles = [];

      for (var i = 0; i < show.length; i++)
      {
        var tr = show[i];
        locations = [];
        roles = [];
        var tags = show[i].round_tags;
        for (var index_tag = 0; index_tag < tags.length; index_tag++)
        {
          var tag = tags[index_tag];
          if (tag.location)
          {
            locations.push(tag.location);
          }
          else if (tag.role)
          {
            roles.push(tag.role);
          }
        }

        tr.locations = locations;
        tr.roles = roles;
      }


    }

  };

  $scope.round.create.timepicker.init = function()
  {
    var startTimePicker = $('#roundCreateStartTimePicker');
    var endTimePicker = $('#roundCreateEndTimePicker');
    startTimePicker.datetimepicker({
      dateFormat: "mm/dd/yy",
      timeFormat: "hh:mm TT",
      closeText: "Close",
      beforeShow: (function() {
        setTimeout(function(){$('.ui-datepicker').css('z-index', 1000);}, 0);
      }),
      hour: 0,
      minute: 0,
      onSelect: (function(selectedDateTime) {
        //var startDate = startTimePicker.datetimepicker('getDate');
        endTimePicker.datetimepicker('option', 'minDate', selectedDateTime);
      })
    });

    endTimePicker.datetimepicker({
      dateFormat: "mm/dd/yy",
      timeFormat: "hh:mm TT",
      closeText: "Close",
      beforeShow: function() {
        setTimeout(function(){$('.ui-datepicker').css('z-index', 1000);}, 0);
      },
      hour: 23,
      minute: 59,
      onSelect: (function(selectedDateTime) {
        //var endDate = endTimePicker.datetimepicker('getDate');
        startTimePicker.datetimepicker('option', 'maxDate', selectedDateTime);
      })
    });
  };

  $scope.round.create.init = function()
  {
    $scope.round.create.title = '';
    $scope.round.create.timepicker.start = '';
    $scope.round.create.timepicker.end = '';
    $scope.round.tbl.init($scope, $scope.round.tbl);
    $scope.round.create.selectedLocations = [];
    $scope.round.create.selectedRoles = [];


    var startTimePicker = $('#roundCreateStartTimePicker');
    var endTimePicker = $('#roundCreateEndTimePicker');
    startTimePicker.datetimepicker('option', 'maxDate', null);
    endTimePicker.datetimepicker('option', 'minDate', null);
  };

  $scope.round.create.send = function()
  {
    isSent = true;

    var time = {};
    time.start = transDateTimeAtZoneSub8ToUTCRemoveClientZone(new Date($scope.round.create.timepicker.start));
    time.end = transDateTimeAtZoneSub8ToUTCRemoveClientZone(new Date($scope.round.create.timepicker.end));

    var selectLocationIds = [];
    var selectRoleIds = [];

    if (!$scope.round.create.title)
    {
      $scope.round.create.noTitleCss = $scope.inputNotSetCss;
      isSent = false;
    }

    if (!Date.parse(time.start))
    {
      $scope.round.create.noTimeStartCss = $scope.inputNotSetCss;
      isSent = false;
    }

    if (!Date.parse(time.end))
    {
      $scope.round.create.noTimeEndCss = $scope.inputNotSetCss;
      isSent = false;
    }

    if (time.start >= time.end)
    {
      $scope.round.create.noTimeEndCss = $scope.inputNotSetCss;
      isSent = false;
    }

    if ($scope.round.create.selectedLocations && (0 < $scope.round.create.selectedLocations.length))
    {
      selectedLocations = $scope.round.create.selectedLocations;

      for (var i = 0; i < selectedLocations.length; i++)
      {
        selectLocationIds.push(selectedLocations[i].id);
      }
    }

    if ($scope.round.create.selectedRoles && (0 < $scope.round.create.selectedRoles.length))
    {
      selectedRoles = $scope.round.create.selectedRoles;

      for (var i = 0; i < selectedRoles.length; i++)
      {
        selectRoleIds.push(selectedRoles[i].id);
      }
    }

    if (isSent)
    {
      var postData = {
        processId: $scope.round.processId,
        title: $scope.round.create.title,
        time: time,
        selectLocationIds: selectLocationIds,
        selectRoleIds: selectRoleIds,
        "current_year_id": $rootScope.current_year.id,
        "current_process_id": $rootScope.current_process.id
      };

      waitingIcon.open();
      $http({
        url: JSON_URL + "/rounds/",
        method: "POST",
        data: postData
      })
      .success(function (data, status, headers, config) {
        waitingIcon.close();
        $scope.eCode = data.eCode;

        if(data.success){
          $scope.round.create.init();
        }
        else{
          switch ($scope.eCode)
          {
            case 'xSYS00010':
              $scope.round.flow = 350;
              $("#roundCreateRoundForm").modal('toggle');
              break;
            default:
          }
        }

        $rootScope.getProcessStep(false);
      })
      .error(function (data, status, headers, config) {
        waitingIcon.close();
      });
    }
  };

  $scope.round.edit.init = function(round)
  {
    $scope.round.edit.round = angular.copy(round);
    $("#roundEditRoundForm").modal('toggle');

    $scope.round.edit.selectedLocations = [];
    $scope.round.edit.selectedRoles = [];
    angular.forEach($scope.round.edit.selectLocationList, function(value, key) {
      value.ticked = false;
    });

    angular.forEach($scope.round.edit.selectRoleList, function(value, key) {
      value.ticked = false;
    });


    var roundTags = $scope.round.edit.round.round_tags;

    for (var i = 0; i < roundTags.length; i++)
    {
      var tag = roundTags[i];
      if (tag.location)
      {
        var location = tag.location;

        angular.forEach($scope.round.edit.selectLocationList, function(value, key) {
          if (value.id == location.id)
          {
            value.ticked = true;
            $scope.round.edit.selectedLocations.push(location);
          }
        });
      }
      else if (tag.role)
      {
        var role = tag.role;

        angular.forEach($scope.round.edit.selectRoleList, function(value, key) {
          if (value.id == role.id)
          {
            value.ticked = true;
            $scope.round.edit.selectedRoles.push(role);
          }
        });
      }
    }

    $scope.round.edit.timepicker.init($scope.round.edit.round.t_start, $scope.round.edit.round.t_end);
    $scope.round.flow = 200;
  };


  $scope.round.edit.timepicker.init = function(t_start, t_end)
  {
    var startTimePicker = $('#roundEditStartTimePicker');
    var endTimePicker = $('#roundEditEndTimePicker');

    timeStart = transDateTimeAtZoneUTCToSub8ExistClientZone(new Date(t_start));
    timeEnd = transDateTimeAtZoneUTCToSub8ExistClientZone(new Date(t_end));

    startTimePicker.datetimepicker({
      dateFormat: "mm/dd/yy",
      timeFormat: "hh:mm TT",
      closeText: "Close",
      beforeShow: (function() {
        setTimeout(function(){startTimePicker.css('z-index', 1000);}, 0);
      }),
      onSelect: (function(selectedDateTime) {
        endTimePicker.datepicker("option", "minDate", new Date(selectedDateTime))
                     .datetimepicker("option", "minDateTime", new Date(selectedDateTime));
      })
    });

    endTimePicker.datetimepicker({
      dateFormat: "mm/dd/yy",
      timeFormat: "hh:mm TT",
      closeText: "Close",
      beforeShow: function() {
        setTimeout(function(){endTimePicker.css('z-index', 1000);}, 0);
      },
      onSelect: (function(selectedDateTime) {
        startTimePicker.datepicker("option", "maxDate", new Date(selectedDateTime))
                       .datetimepicker("option", "maxDateTime", new Date(selectedDateTime));
      })
    });

    startTimePicker.datepicker("option", "maxDate", timeEnd)
                   .datetimepicker("option", "maxDateTime", timeEnd);
    endTimePicker.datepicker("option", "minDate", timeStart)
                 .datetimepicker("option", "minDateTime", timeStart);

    startTimePicker.datetimepicker('setDate', timeStart);
    endTimePicker.datetimepicker('setDate', timeEnd);

  };

  $scope.round.edit.send = function()
  {
    var roundId = $scope.round.edit.round.id;
    var title = $scope.round.edit.round.title;
    var time = {};
    time.t_start = transDateTimeAtZoneSub8ToUTCRemoveClientZone(new Date($scope.round.edit.timepicker.t_start));
    time.t_end = transDateTimeAtZoneSub8ToUTCRemoveClientZone(new Date($scope.round.edit.timepicker.t_end));

    var selectLocationIds = [];
    var selectRoleIds = [];

    if ($scope.round.edit.selectedLocations && (0 < $scope.round.edit.selectedLocations.length))
    {
      selectedLocations = $scope.round.edit.selectedLocations;

      for (var i = 0; i < selectedLocations.length; i++)
      {
        selectLocationIds.push(selectedLocations[i].id);
      }
    }

    if ($scope.round.edit.selectedRoles && (0 < $scope.round.edit.selectedRoles.length))
    {
      selectedRoles = $scope.round.edit.selectedRoles;

      for (var i = 0; i < selectedRoles.length; i++)
      {
        selectRoleIds.push(selectedRoles[i].id);
      }
    }

    var postData = {
      title: title,
      time: time,
      selectLocationIds: selectLocationIds,
      selectRoleIds: selectRoleIds,
      "current_year_id": $rootScope.current_year.id,
      "current_process_id": $rootScope.current_process.id
    };

    waitingIcon.open();
    $http({
      url: JSON_URL + "/rounds/" + roundId,
      method: "PUT",
      data: postData
    })
    .success(function (data, status, headers, config) {
      $scope.eCode = data.eCode;
      waitingIcon.close();
      if(!data.success && data.msg){
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      else{
        switch ($scope.eCode)
        {
          case 'xSYS00000':
            $scope.round.flow = 280;
            $rootScope.getProcessStep(false);
            break;
          case 'xSYS00008':
            $scope.round.flow = 270;
            break;
          default:
            $scope.round.flow = 290;
        }
        $scope.round.tbl.setDataAndRequest();
      }
    })
    .error(function (data, status, headers, config) {
      $scope.round.flow = 290;
      waitingIcon.close();
    });
  };

  $scope.round.remove.send = function()
  {
    var roundId = $scope.round.remove.round.id;
    waitingIcon.open();
    $http({
      url: JSON_URL + "/rounds/" + roundId,
      method: "DELETE",
      params: {
        "current_year_id": $rootScope.current_year.id,
        "current_process_id": $rootScope.current_process.id
      }
    })
    .success(function (data, status, headers, config) {
      $scope.eCode = data.eCode;
      if(!data.success && data.msg){
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      else{
        switch ($scope.eCode)
        {
          case 'xSYS00000':
            $scope.round.flow = 120;
            $rootScope.getProcessStep(false);
            break;
          default:
            $scope.round.flow = 130;
        }
        $scope.round.tbl.setDataAndRequest();
      }
      waitingIcon.close();
    })
    .error(function (data, status, headers, config) {
      $scope.round.flow = 130;
      waitingIcon.close();
    });
  };

  $scope.round.tbl.dropdownClick.edit = function(round)
  {
    $scope.round.edit.init(round);
  };

  $scope.round.tbl.dropdownClick.remove = function(round)
  {
    $scope.round.remove.round = round;
    $("#roundDeleteRoundForm").modal('toggle');
    $scope.round.flow = 100;
  };

  $scope.round.checkFlow = function(now)
  {
    var eCode = 'xSYS00000';
    switch (now)
    {
      case 0:
        eCode = 'xIAP99999';
        break;
      case 200:
        var start = new Date($scope.round.edit.timepicker.t_start);
        var end = new Date($scope.round.edit.timepicker.t_end);

        if (!$scope.round.edit.round.title)
        {
          $scope.round.edit.noTitleCss = $scope.inputNotSetCss;
          eCode = 'xIAP00009';
        }
        else if (!Date.parse($scope.round.edit.timepicker.t_start))
        {
          $scope.round.edit.noTimeStartCss = $scope.inputNotSetCss;
          eCode = 'xIAP00010';
        }
        else if (!Date.parse($scope.round.edit.timepicker.t_end))
        {
          $scope.round.edit.noTimeEndCss = $scope.inputNotSetCss;
          eCode = 'xIAP00010';
        }
        else if (start >= end)
        {
          $scope.round.edit.noTimeEndCss = $scope.inputNotSetCss;
          eCode = 'xIAP00004';
        }
        break;
      case 100:
        // do nothing
        break;
      default:
        eCode = 'xIAP99999';
    }
    return(eCode);
  };

  $scope.round.nextFlow = function(now, next)
  {
    var eCode = $scope.round.checkFlow(now);

    if ('xSYS00000' == eCode)
    {
      switch (next)
      {
        case 0:
          break;
        case 100:
          $scope.round.flow = 100;
          break;
        case 110:
          //$scope.round.flow = 110;
          $scope.round.remove.send();
          break;
        case 210:
          $scope.round.edit.send();
          break;
        default:
          eCode = 'xIAP99999';
      }
    }
  };

  angular.element(document).ready(function () {
    if($rootScope.isRunNowProcess){
      $scope.round.create.timepicker.init();
      $scope.round.tbl.init($scope, $scope.round.tbl);
      $scope.round.getProcessLocationsAndRounds();
    }
  });

  $scope.round.create.titleOnChange = function()
  {
    $scope.round.create.noTitleCss = ($scope.round.create.title)? '' : $scope.inputNotSetCss;
  };

  $scope.round.create.timeStartOnChange = function()
  {
    var time = new Date($scope.round.create.timepicker.start);
    $scope.round.create.noTimeStartCss = (Date.parse(time))? '' : $scope.inputNotSetCss;
  };

  $scope.round.create.timeEndOnChange = function()
  {
    var time = new Date($scope.round.create.timepicker.end);
    $scope.round.create.noTimeEndCss = (Date.parse(time))? '' : $scope.inputNotSetCss;
  };

  $scope.round.edit.titleOnChange = function()
  {
    $scope.round.edit.noTitleCss = ($scope.round.edit.round.title)? '' : $scope.inputNotSetCss;
  };

  $scope.round.edit.timeStartOnChange = function()
  {
    var time = new Date($scope.round.edit.timepicker.t_start);
    $scope.round.edit.noTimeStartCss = (Date.parse(time))? '' : $scope.inputNotSetCss;
  };

  $scope.round.edit.timeEndOnChange = function()
  {
    var time = new Date($scope.round.edit.timepicker.t_end);
    $scope.round.edit.noTimeEndCss = (Date.parse(time))? '' : $scope.inputNotSetCss;
  };

});
/* EOF */
