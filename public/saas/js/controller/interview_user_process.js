/**
 * target: user function
 */
var interviewUserProcessApp = angular.module('interviewUserProcessApp', ['ui.calendar', 'ui.bootstrap', "waitingIconModule"]);
interviewUserProcessApp
.controller('interviewUserProcessCtrl', function($rootScope, $scope, CTableRsas, interviewFactory, intervieweeFactory, timeSlotFactory, waitingIcon){
  $scope.eCode = '';

  $scope.interviewUserProcess = {};
  $scope.interviewUserProcess.processId = $rootScope.current_process.id;
  $scope.interviewUserProcess.roundId = 0;
  $scope.interviewUserProcess.round = {};
  $scope.interviewUserProcess.getRoundSuccess = false;

  $scope.interviewUserProcess.flow = 0;

  $scope.interviewUserProcess.dropdownClick = {};
  $scope.interviewUserProcess.tab = {};

  $scope.interviewUserProcess.interview = {};
  $scope.interviewUserProcess.interview.tbl = new CTableRsas('interviewUserProcess.interview.tbl', JSON_URL + '/interviews/user_get_interviews');
  $scope.interviewUserProcess.interview.tbl.setHeader(['Interview', 1], ['Position', 0], ['Sign up Interview Time', 0]);

  $scope.interviewUserProcess.interview.timeSlot = {};
  $scope.interviewUserProcess.interview.timeSlot.reserve = {};
  $scope.interviewUserProcess.interview.timeSlot.cancel = {};
  $scope.interviewUserProcess.interview.timeSlot.info = {};
  $scope.interviewUserProcess.interview.timeSlot.changeApply = {};

  $scope.interviewUserProcess.interview.emailInterviewers = {};

  $scope.interviewUserProcess.calendar = {};
  $scope.interviewUserProcess.calendar.events = [];
  $scope.interviewUserProcess.calendar.eventSources = [$scope.interviewUserProcess.calendar.events];
  $scope.interviewUserProcess.calendar.calendarView = {};
  $scope.interviewUserProcess.calendar.clickEvent = {};

  $scope.interviewUserProcess.setRoundId = function()
  {
    if ($rootScope.applicant_sub_step)
    {
      if ($rootScope.applicant_sub_step.identify_name.match(/^interview\d+$/))
      {
        $scope.interviewUserProcess.roundId = parseInt($rootScope.applicant_sub_step.identify_name.replace("interview", ""));
        $scope.interviewUserProcess.getRoundSuccess = true;
      }
    }
  };

  $scope.interviewUserProcess.getOneRound = function(roundId)
  {
    waitingIcon.open();
    interviewFactory.getOneRound(roundId, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function (data, status, headers, config) {
      if (data.id == roundId)
      {
        $scope.interviewUserProcess.round = data;
      }
      waitingIcon.close();
    })
    .error(function (data, status, headers, config) {
      waitingIcon.close();
    });
  };


  $scope.interviewUserProcess.tabInterviewSelect = function()
  {
    if (!$scope.firstInterviewRun)
    {
      $scope.firstInterviewRun = true;
    }
    else
    {
      $scope.interviewUserProcess.interview.refresh();
    }
  };

  $scope.interviewUserProcess.tabCalendarSelect = function()
  {
    if ($scope.interviewUserProcess.calendar.calendarView.visStart && $scope.interviewUserProcess.calendar.calendarView.visEnd)
    {
      $scope.interviewUserProcess.calendar.calendarRefresh();
    }
  };

  $scope.interviewUserProcess.refreshAll = function()
  {
    $scope.interviewUserProcess.interview.refresh();
    $scope.interviewUserProcess.calendar.calendarRefresh();
  };

  $scope.interviewUserProcess.interview.tbl.setDataAndRequest = function()
  {
    var data = {
      /////////  Need User Data  //////////
      pageCount: $scope.interviewUserProcess.interview.tbl.perPage,
      page: $scope.interviewUserProcess.interview.tbl.goPage,
      searchText: $scope.interviewUserProcess.interview.tbl.searchText,
      orderBy: $scope.interviewUserProcess.interview.tbl.orderBy,
      ascOrDesc: $scope.interviewUserProcess.interview.tbl.sortOrder,
      procedureId: $scope.interviewUserProcess.processId,
      roundId: $scope.interviewUserProcess.roundId,
      "current_year_id": $rootScope.current_year.id,
      "current_process_id": $rootScope.current_process.id
    };
    $scope.interviewUserProcess.interview.tbl.linkServerGetData($scope.interviewUserProcess.interview.tbl, data);
  };

  $scope.interviewUserProcess.interview.tbl.successDo = function(data)
  {
    $scope.permission_to_active = data.permission_to_active;
  };


  $scope.interviewUserProcess.calendar.calendarRefresh = function()
  {
    if ($scope.interviewUserProcess.calendar.calendarView.start)
    {
      $scope.interviewUserProcess.calendar.events.splice(0, $scope.interviewUserProcess.calendar.events.length);
      var params = {
        start: transDateTimeAtZoneSub8ToUTC($scope.interviewUserProcess.calendar.calendarView.start),
        end: transDateTimeAtZoneSub8ToUTC($scope.interviewUserProcess.calendar.calendarView.end),
        roundId: $scope.interviewUserProcess.roundId,
        "current_year_id": $rootScope.current_year.id,
        "current_process_id": $rootScope.current_process.id
      };

      waitingIcon.open();
      interviewFactory.userCalendarView(params)
      .success(function (data, status, headers, config) {
        $scope.interviewUserProcess.calendar.interviewsTransToCalender(data);
        waitingIcon.close();
      })
      .error(function (data, status, headers, config) {
        waitingIcon.close();
      });
    }
  };

  $scope.interviewUserProcess.calendar.interviewsTransToCalender = function(interviews)
  {
    var calendarInterviews = [];

    for (var i = 0; i < interviews.length; i++)
    {
      var interview = interviews[i];

      var interviewName = interview.name;

      for (var i_timeSlot = 0; i_timeSlot < interview.time_slots.length; i_timeSlot++)
      {

        var timeSlot = interview.time_slots[i_timeSlot];
        var place = timeSlot.place;
        var t_start = transDateTimeAtZoneUTCToSub8ExistClientZone(new Date(timeSlot.t_start));
        var t_end = transDateTimeAtZoneUTCToSub8ExistClientZone(new Date(timeSlot.t_end));
        var disabledColor = "#B7B7B7";
        var color = (timeSlot.id == interview.applied.timeSlotId)? "#38610B" : "";
        var title = [];
        title.push(interviewName);
        title.push("\n<place: ");
        title.push(place);
        title.push(">");

        calendarInterviews.push({
          interviewName: interview.name,
          interviewApplied: interview.applied,
          timeSlot: timeSlot,
          title: title.join(""),
          start: t_start,
          end: t_end,
          allDay: false,
          color: ($scope.interviewUserProcess.round.permission.active)? color : disabledColor
        });
      }
    }

    $scope.interviewUserProcess.calendar.events.splice(0, $scope.interviewUserProcess.calendar.events.length);
    $scope.interviewUserProcess.calendar.events.push.apply($scope.interviewUserProcess.calendar.events, calendarInterviews);
  };


  /* alert on eventClick */
  $scope.interviewUserProcess.calendar.alertOnEventClick = function(event, allDay, jsEvent, view){
    if ($scope.interviewUserProcess.round.permission.active)
    {
      $scope.interviewUserProcess.interview.timeSlot.click(event.timeSlot, event.interviewName, event.interviewApplied);
    }
    else
    {
      $scope.interviewUserProcess.interview.timeSlot.warnActiveTime();
    }
  };

  $scope.interviewUserProcess.calendar.renderView = function(view){
    $scope.interviewUserProcess.calendar.calendarView = view;
    $scope.interviewUserProcess.calendar.calendarRefresh();
  };

  /* Change View */
  $scope.interviewUserProcess.calendar.changeView = function(view,calendar) {
    calendar.fullCalendar('changeView',view);
  };

  /* Change View */
  $scope.interviewUserProcess.calendar.renderCalender = function(calendar) {
    if(calendar){
      calendar.fullCalendar('render');
    }
  };

  /* config object */
  $scope.interviewUserProcess.calendar.uiConfig = {
    calendar:{
      height: 450,
      editable: true,
      eventDurationEditable: false,
      disableResizing: true,
      disableDragging: true,
      timeFormat: 'HH:mm{-HH:mm}',
      header:{
        left: 'title',
        center: '',
        right: 'today prev,next'
      },
      eventClick: $scope.interviewUserProcess.calendar.alertOnEventClick,
      viewRender: $scope.interviewUserProcess.calendar.renderView
    }
  };

  $scope.interviewUserProcess.interview.refresh = function()
  {
    $scope.interviewUserProcess.interview.tbl.setDataAndRequest();
  };

  $scope.interviewUserProcess.interview.timeSlot.click = function(timeSlot, interviewName, applied)
  {
    if (applied.isApplied)
    {
      if (timeSlot.id == applied.timeSlotId)
      {
        $scope.interviewUserProcess.interview.timeSlot.info.init(timeSlot, interviewName);
      }
      else
      {
        //$scope.interviewUserProcess.flow = 400;
        //$scope.interviewUserProcess.flow = 410;
        // change apply
        $scope.interviewUserProcess.interview.timeSlot.changeApply.init(timeSlot, interviewName);
      }
    }
    else
    {
      $scope.interviewUserProcess.interview.timeSlot.reserve.init(timeSlot, interviewName);
    };

    $("#interviewUserProcessApplyCancelForm").modal('toggle');
  };

  $scope.interviewUserProcess.interview.timeSlot.checkActive = function(active)
  {
    if (!active)
    {
      $scope.interviewUserProcess.interview.timeSlot.warnActiveTime();
    }
  };

  $scope.interviewUserProcess.interview.timeSlot.warnActiveTime = function()
  {
    $("#interviewUserProcessApplyCancelForm").modal('toggle');
    $scope.interviewUserProcess.flow = 570;
  };

  $scope.interviewUserProcess.interview.timeSlot.reserve.init = function(timeSlot, interviewName)
  {
    $scope.interviewUserProcess.flow = 500;
    $scope.interviewUserProcess.interview.timeSlot.reserve.timeSlot = angular.copy(timeSlot);
    $scope.interviewUserProcess.interview.timeSlot.reserve.timeSlot.interviewName = interviewName;
    //$("#interviewUserProcessApplyCancelForm").modal('toggle');
  };

  $scope.interviewUserProcess.interview.timeSlot.reserve.send = function()
  {
    var timeSlotId = $scope.interviewUserProcess.interview.timeSlot.reserve.timeSlot.id;
    var postData = {
      timeSlotId: timeSlotId,
      "current_year_id": $rootScope.current_year.id,
      "current_process_id": $rootScope.current_process.id
    };

    waitingIcon.open();
    intervieweeFactory.reserve(postData)
    .success(function (data, status, headers, config) {
      $scope.eCode = data.eCode;
      switch ($scope.eCode)
      {
        case 'xSYS00000':
          $scope.interviewUserProcess.flow = 580;
          break;
        case 'xIUP00001':
          $scope.interviewUserProcess.flow = 590;
          break;
        case 'xIUP00002':
          $scope.interviewUserProcess.flow = 400;
          break;
        case 'xDBI00003':
          $scope.interviewUserProcess.flow = 590;
          break;
        case 'xSYS00011':
          $scope.interviewUserProcess.flow = 560;
          break;
        default:
          $scope.interviewUserProcess.flow = 599;
      }
      $scope.interviewUserProcess.refreshAll();
      waitingIcon.close();
    })
    .error(function (data, status, headers, config) {
      $scope.interviewUserProcess.flow = 599;
      waitingIcon.close();
    });
  };

  $scope.interviewUserProcess.interview.timeSlot.changeApply.init = function(timeSlot, interviewName)
  {
    $scope.interviewUserProcess.flow = 410;
    $scope.interviewUserProcess.interview.timeSlot.changeApply.timeSlot = angular.copy(timeSlot);
    $scope.interviewUserProcess.interview.timeSlot.changeApply.timeSlot.interviewName = interviewName;
  };

  $scope.interviewUserProcess.interview.timeSlot.changeApply.send = function()
  {
    var timeSlotId = $scope.interviewUserProcess.interview.timeSlot.changeApply.timeSlot.id;
    var postData = {
      timeSlotId: timeSlotId,
      "current_year_id": $rootScope.current_year.id,
      "current_process_id": $rootScope.current_process.id
    };

    waitingIcon.open();
    intervieweeFactory.reserve(postData)
    .success(function (data, status, headers, config) {
      $scope.eCode = data.eCode;

      switch ($scope.eCode)
      {
        case 'xSYS00000':
          $scope.interviewUserProcess.flow = 580;
          break;
        case 'xIUP00001':
          $scope.interviewUserProcess.flow = 590;
          break;
        case 'xIUP00002':
          $scope.interviewUserProcess.flow = 400;
          break;
        case 'xDBI00003':
          $scope.interviewUserProcess.flow = 590;
          break;
        case 'xSYS00011':
          $scope.interviewUserProcess.flow = 560;
          break;
        default:
          $scope.interviewUserProcess.flow = 599;
      }
      $scope.interviewUserProcess.refreshAll();
      waitingIcon.close();
    })
    .error(function (data, status, headers, config) {
      $scope.interviewUserProcess.flow = 599;
      waitingIcon.close();
    });
  };

  $scope.interviewUserProcess.interview.timeSlot.cancel.init = function(timeSlot, interviewName)
  {
    $scope.interviewUserProcess.flow = 600;
    $scope.interviewUserProcess.interview.timeSlot.cancel.timeSlot = angular.copy(timeSlot);
    $scope.interviewUserProcess.interview.timeSlot.cancel.timeSlot.interviewName = interviewName;
    //$("#interviewUserProcessApplyCancelForm").modal('toggle');
  };

  $scope.interviewUserProcess.interview.timeSlot.cancel.send = function()
  {
    var timeSlotId = $scope.interviewUserProcess.interview.timeSlot.cancel.timeSlot.id;
    waitingIcon.open();
    intervieweeFactory.cancel(timeSlotId, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function (data, status, headers, config) {
      $scope.eCode = data.eCode;

      switch ($scope.eCode)
      {
        case 'xSYS00000':
          $scope.interviewUserProcess.flow = 680;
          break;
        case 'xDBD00002':
          $scope.interviewUserProcess.flow = 690;
          break;
        default:
          $scope.interviewUserProcess.flow = 599;
      }

      $scope.interviewUserProcess.refreshAll();
      waitingIcon.close();
    })
    .error(function (data, status, headers, config) {
      $scope.interviewUserProcess.flow = 599;
      waitingIcon.close();
    });
  };


  $scope.interviewUserProcess.interview.timeSlot.info.init = function(timeSlot, interviewName)
  {
    $scope.interviewUserProcess.flow = 700;
    $scope.interviewUserProcess.interview.timeSlot.info.timeSlot = angular.copy(timeSlot);
    $scope.interviewUserProcess.interview.timeSlot.info.timeSlot.interviewName = interviewName;
    //$("#interviewUserProcessApplyCancelForm").modal('toggle');
  };

  $scope.interviewUserProcess.interview.timeSlot.info.clickCancel = function()
  {
    var timeSlot = $scope.interviewUserProcess.interview.timeSlot.info.timeSlot;
    var interviewName = $scope.interviewUserProcess.interview.timeSlot.info.timeSlot.interviewName;
    $scope.interviewUserProcess.interview.timeSlot.cancel.init(timeSlot, interviewName);
  };

  $scope.interviewUserProcess.interview.timeSlot.isOvertime = function(dt)
  {
    if($rootScope.apply_white_list){
      return false;
    }
    else{
      var now = new Date();
      var timeSlotEnd = transDateTimeAtZoneUTCToSub8ExistClientZone(new Date(dt));

      return (now > timeSlotEnd);
    }
  };

  $scope.interviewUserProcess.interview.emailInterviewers.init = function(interview)
  {
    $scope.interviewUserProcess.interview.emailInterviewers.interview = angular.copy(interview);

    $scope.interviewUserProcess.interview.emailInterviewers.mail = {
      recipients : [],
      subject: "",
      content: ""
    };

    $("#interviewUserProcessEmailInterviewerForm").modal('toggle');
  };

  $scope.interviewUserProcess.interview.emailInterviewers.send = function()
  {
    var mail = $scope.interviewUserProcess.interview.emailInterviewers.mail;
    mail.interview_id = $scope.interviewUserProcess.interview.emailInterviewers.interview.id;
    waitingIcon.open();
    interviewFactory.sendEmailToInterviewers(mail, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function (data) {
      if(data.success){
        $rootScope.rsasAlert({type: 'success', msg: data.msg});
        $("#interviewUserProcessEmailInterviewerForm").modal('toggle');
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: "Email delivery failure"});
      waitingIcon.close();
    });
  };

  $scope.interviewUserProcess.dropdownClick.emailInterviewer = function(interview)
  {
    $scope.interviewUserProcess.interview.emailInterviewers.init(interview);
  };

  $scope.interviewUserProcess.checkFlow = function(now)
  {
    var eCode = 'xSYS00000';
    switch (now)
    {
      case 0:
        eCode = 'xIUP99999';
        break;
      case 410:
      case 500:
      case 600:
      case 700:
        // do nothing
        eCode = 'xSYS00000';
        break;
      default:
        eCode = 'xIUP99999';
    }
    return(eCode);
  };

  $scope.interviewUserProcess.nextFlow = function(now, next)
  {
    var eCode = $scope.interviewUserProcess.checkFlow(now);
    if ('xSYS00000' == eCode)
    {
      switch (next)
      {
        case 0:
          break;
        case 420:
          $scope.interviewUserProcess.interview.timeSlot.changeApply.send();
          break;
        case 510:
          $scope.interviewUserProcess.interview.timeSlot.reserve.send();
          break;
        case 610:
          $scope.interviewUserProcess.interview.timeSlot.cancel.send();
          break;
        case 710:
          $scope.interviewUserProcess.interview.timeSlot.info.clickCancel();
          break;
        default:
          eCode = 'xIUP99999';
      }
    }
  };

  angular.element(document).ready(function () {
    if($rootScope.isRunNowProcess){
      $scope.interviewUserProcess.setRoundId();
      if ($scope.interviewUserProcess.getRoundSuccess)
      {
        $scope.interviewUserProcess.getOneRound($scope.interviewUserProcess.roundId);
        $scope.interviewUserProcess.interview.tbl.init($scope, $scope.interviewUserProcess.interview.tbl);
      }
    }
  });
});
/* EOF */

