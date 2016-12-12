/**
 * target: admin procedure function
 */
var interviewAdminProcessApp = angular.module('interviewAdminProcessApp', ['ui.calendar', 'ui.bootstrap', "waitingIconModule"]);
interviewAdminProcessApp
.controller('interviewAdminProcessCtrl', function($rootScope, $scope, $sce, $window, CTableRsas, interviewFactory, timeSlotFactory, timeSlotInterviewerFactory, interviewEvaluateFactory, userFormFactory, recommendationFormFactory, applicantTagFactory, userFactory, fileFactory, transcriptFactory, FileUploader, waitingIcon){
  $scope.inputNotSetCss = 'hasErrorInput';
  $scope.eCode = '';

  $scope.default_email_templates = {};
  $scope.default_email_templates.interview_mgr_select_applicant = {};
  $scope.default_email_templates.interview_mgr_cancel_select_applicant = {};
  $scope.default_email_templates.interview_mgr_schedule_applicant = {};
  $scope.default_email_templates.interview_mgr_cancel_schedule_applicant = {};

  $scope.email = {};
  $scope.email.sendType = '';

  $scope.select_invited_email = {};
  $scope.select_invited_email.subject = '';
  $scope.select_invited_email.content = '';
  $scope.select_invited_email.recipients = [];

  $scope.schedule_invited_email = {};
  $scope.schedule_invited_email.subject = '';
  $scope.schedule_invited_email.content = '';

  $scope.schedule_canceled_email = {};
  $scope.schedule_canceled_email.subject = '';
  $scope.schedule_canceled_email.content = '';

  $scope.interviewAdminProcess = {};
  $scope.interviewAdminProcess.processId = $rootScope.current_process.id;
  $scope.interviewAdminProcess.roundId = 0;
  $scope.interviewAdminProcess.round = {};
  $scope.interviewAdminProcess.getRoundSuccess = false;
  $scope.interviewAdminProcess.locations = [];
  $scope.interviewAdminProcess.roles = [];
  $scope.interviewAdminProcess.locationTitle = '';
  $scope.interviewAdminProcess.roleTitle = '';
  $scope.interviewAdminProcess.flow = 0;

  $scope.interviewAdminProcess.tab = {};

  $scope.interviewAdminProcess.interview = {};
  $scope.interviewAdminProcess.interview.positionShow = [];

  $scope.interviewAdminProcess.interview.tblHasInit = false;
  $scope.interviewAdminProcess.interview.tbl = new CTableRsas('interviewAdminProcess.interview.tbl', JSON_URL + '/interviews/admin_get_interviews');
  $scope.interviewAdminProcess.interview.tbl.setHeader(['Interview', 0], ['Position', 0], ['Vacancy', 0], ['Time Slots', 0]/*, ['Interviewers', 0]*/);

  $scope.interviewAdminProcess.interview.dropdownClick = {};
  $scope.interviewAdminProcess.interview.scheduleDropdownClick = {};
  $scope.interviewAdminProcess.applicantListDropdownClick = {};

  $scope.interviewAdminProcess.interview.tableFieldTimeSlot = {};

  $scope.interviewAdminProcess.interview.create = {};
  $scope.interviewAdminProcess.interview.create.positionList = [];

  $scope.interviewAdminProcess.interview.edit = {};

  $scope.interviewAdminProcess.interview.remove = {};

  $scope.interviewAdminProcess.interview.position = {};

  $scope.interviewAdminProcess.interview.interviewer = {};
  $scope.interviewAdminProcess.interview.interviewer.add = [];
  $scope.interviewAdminProcess.interview.interviewer.remove = [];
  $scope.interviewAdminProcess.interview.interviewer.sunetAdd = [];
  $scope.interviewAdminProcess.interview.interviewer.sunetRemove = [];
  $scope.interviewAdminProcess.interview.interviewer.newInterviewer = {};

  $scope.interviewAdminProcess.interview.selectApplicant = {};
  $scope.interviewAdminProcess.interview.selectApplicant.add = [];
  $scope.interviewAdminProcess.interview.selectApplicant.remove = [];
  $scope.interviewAdminProcess.interview.selectApplicant.radioApplicantType = 1;

  $scope.interviewAdminProcess.interview.sendInviteEmailToApplicant = {};

  $scope.interviewAdminProcess.interview.timeSlot = {};
  $scope.interviewAdminProcess.interview.timeSlot.remove = [];
  $scope.interviewAdminProcess.interview.timeSlot.timeList = [];
  $scope.interviewAdminProcess.interview.timeSlot.timepicker = {};
  $scope.interviewAdminProcess.interview.timeSlot.isTimeAdding = false;

  $scope.interviewAdminProcess.interview.schedule = {};
  $scope.interviewAdminProcess.interview.schedule.setting = {};
  $scope.interviewAdminProcess.interview.schedule.interviewer = {};
  $scope.interviewAdminProcess.interview.schedule.interviewer.add = [];
  $scope.interviewAdminProcess.interview.schedule.interviewer.remove = [];

  $scope.interviewAdminProcess.interview.schedule.scheduleApplicant = {};
  $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.add = [];
  $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.remove = [];

  $scope.interviewAdminProcess.applicantList = {};
  $scope.interviewAdminProcess.applicantList.tblHasInit = false;
  $scope.interviewAdminProcess.applicantList.tbl = new CTableRsas('interviewAdminProcess.applicantList.tbl', JSON_URL + '/interviews/get_interview_applicant_list');
  $scope.interviewAdminProcess.applicantList.tbl.setHeader(['Name', 0], ['Application', 0], ['Selected', 0], ['Scheduled', 0]);
  $scope.interviewAdminProcess.applicantList.email = {};
  $scope.interviewAdminProcess.applicantList.comment = {};
  $scope.interviewAdminProcess.applicantList.review = {};
  $scope.interviewAdminProcess.applicantList.tags = {};
  $scope.interviewAdminProcess.applicantList.evaluate = {};
  $scope.interviewAdminProcess.applicantList.applicants = [];
  $scope.interviewAdminProcess.applicantList.application = {};
  $scope.interviewAdminProcess.applicantList.application.form = {};
  $scope.interviewAdminProcess.applicantList.emailScheduled = {};
  $scope.interviewAdminProcess.applicantList.emailAllApplicant = {};


  $scope.interviewAdminProcess.myInterview = {};
  $scope.interviewAdminProcess.myInterview.tblHasInit = false;
  $scope.interviewAdminProcess.myInterview.tbl = new CTableRsas('interviewAdminProcess.myInterview.tbl', JSON_URL + '/interviews/admin_get_my_interviews');
  $scope.interviewAdminProcess.myInterview.tbl.setHeader(['Interview', 0], ['Position', 0], ['Time Slots', 0]);
  $scope.interviewAdminProcess.myInterview.positionShow = [];
  $scope.interviewAdminProcess.myInterview.timeSlot = {};
  $scope.interviewAdminProcess.myInterview.email = {};
  $scope.interviewAdminProcess.myInterview.dropdownClick = {};

  $scope.interviewAdminProcess.calendar = {};
  $scope.interviewAdminProcess.calendar.events = [];
  $scope.interviewAdminProcess.calendar.eventSources = [$scope.interviewAdminProcess.calendar.events];
  $scope.interviewAdminProcess.calendar.calendarView = {};

///////////////////////////////////////////////////////////////////////////////////////////////////////////
  $scope.getNumberArray = function(input_array, key){
    n = findMax(input_array, key);
    var array = [];
    for(var i = 0; i <= n; i++){
      array.push(i);
    }
    return array;
  };

  $scope.getRows = function(){
    n = findMax(this.form.schema, "row");
    return $scope.getNumberArray(this.form.schema, "row");
  };

  $scope.getColumns = function(row){
    schema = findObjs(this.form.schema, "row", row);
    return $scope.getNumberArray(schema, "column");
  };

  $scope.to_html = function(str) {
    return $sce.trustAsHtml(str);
  };

  $scope.email.init = function(){
    $scope.rsas_email = {
      recipients : [],
      cc : [],
      bcc : [],
      subject: "",
      content: ""
    };
  };

  $scope.email.send = function(){
    switch($scope.email.sendType)
    {
      case 'toApplicant':
        $scope.interviewAdminProcess.applicantList.email.send();
        break;
      case 'myInterview':
        $scope.interviewAdminProcess.myInterview.email.send();
        break;
      case 'interviewSceduledApplicant':
        $scope.interviewAdminProcess.applicantList.emailScheduled.send();
        break;
      case 'interviewAllApplicant':
        $scope.interviewAdminProcess.applicantList.emailAllApplicant.send();
        break;
      default:
        //none
    }
  };

  $scope.email.sendEmailToApplicants = function()
  {
    var mail = $scope.rsas_email;

    waitingIcon.open();
    interviewFactory.sendEmailToApplicants(mail, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function (data) {
      if(data.success){
        $rootScope.rsasAlert({type: 'success', msg: "Email delivery success."});
        $("#interviewAdminProcessEmail").modal('toggle');
      }
      else{
        error_message = data.error_message;
        for (var i = 0; i < error_message.length; i++)
        {
          $rootScope.rsasAlert({type: 'danger', msg: error_message[i]});
        }
      }
      waitingIcon.close();
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: "Email delivery failure"});
      waitingIcon.close();
    });
  };

  $scope.interviewAdminProcess.getInterviewSelectApplicants = function(interviewId, recipients)
  {
    waitingIcon.open();
    interviewFactory.getInterviewSelectApplicants(interviewId, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function (data, status, headers, config) {
      applicants = data.applicants;

      for (var i = 0; i < applicants.length; i++)
      {
        var user = applicants[i];
        recipients.push({name: user.name, email: user.email});
      }

      waitingIcon.close();
    })
    .error(function (data, status, headers, config) {
      waitingIcon.close();
    });
  };

  $scope.interviewAdminProcess.getInterviewScheduledApplicants = function(interviewId, recipients)
  {
    waitingIcon.open();
    interviewFactory.getInterviewScheduledApplicants(interviewId, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function (data, status, headers, config) {
      applicants = data.applicants;

      for (var i = 0; i < applicants.length; i++)
      {
        var user = applicants[i];
        recipients.push({name: user.name, email: user.email});
      }

      waitingIcon.close();
    })
    .error(function (data, status, headers, config) {
      waitingIcon.close();
    });

  };

  $scope.interviewAdminProcess.checkManager = function()
  {
    waitingIcon.open();
    userFactory.checkManager($rootScope.current_year.id, $rootScope.current_process.id)
    .success(function (data) {
      waitingIcon.close();
      $scope.interviewAdminProcess.isManager = data.isManager;
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: "Connect server error."});
      waitingIcon.close();
    });
  };


  $scope.interviewAdminProcess.setRoundId = function()
  {
    if ($rootScope.current_sub_step)
    {
      if ($rootScope.current_sub_step.identify_name.match(/^interview\d+$/))
      {
        $scope.interviewAdminProcess.roundId = parseInt($rootScope.current_sub_step.identify_name.replace("interview", ""));
        $scope.interviewAdminProcess.getRoundSuccess = true;
      }
    }
  };

  $scope.interviewAdminProcess.startAndEndTimeChangeRsasTimeFormat = function(time)
  {
    var timeDisplayStart = [];
    var timeDisplayEnd = [];

    timeDisplayStart.push(time.t_start.getMonth() + 1);
    timeDisplayStart.push("/");
    timeDisplayStart.push(time.t_start.getDate());
    timeDisplayStart.push("/");
    timeDisplayStart.push(time.t_start.getFullYear());
    timeDisplayStart.push(" ");
    timeDisplayStart.push(time.t_start.getHours());
    timeDisplayStart.push(":");
    timeDisplayStart.push(time.t_start.getMinutes());

    timeDisplayEnd.push(time.t_end.getMonth() + 1);
    timeDisplayEnd.push("/");
    timeDisplayEnd.push(time.t_end.getDate());
    timeDisplayEnd.push("/");
    timeDisplayEnd.push(time.t_end.getFullYear());
    timeDisplayEnd.push(" ");
    timeDisplayEnd.push(time.t_end.getHours());
    timeDisplayEnd.push(":");
    timeDisplayEnd.push(time.t_end.getMinutes());

    rsasTime = {
      t_start: timeDisplayStart.join("").replace (/(\b|\:|-|\s)(\d)(?=\D|$)/g, '$10$2'),
      t_end: timeDisplayEnd.join("").replace (/(\b|\:|-|\s)(\d)(?=\D|$)/g, '$10$2')
    };

    return (rsasTime);
  };

  $scope.interviewAdminProcess.timeChangeRsasTimeFormat = function(o_time)
  {
    var timeDisplay = [];
    time = new Date(o_time);

    timeDisplay.push(time.getMonth() + 1);
    timeDisplay.push("/");
    timeDisplay.push(time.getDate());
    timeDisplay.push("/");
    timeDisplay.push(time.getFullYear());
    timeDisplay.push(" ");
    timeDisplay.push(time.getHours());
    timeDisplay.push(":");
    timeDisplay.push(time.getMinutes());

    return (timeDisplay.join("").replace (/(\b|\:|-|\s)(\d)(?=\D|$)/g, '$10$2'));
  };

  $scope.interviewAdminProcess.getRoundInterviews = function(roundId)
  {
    waitingIcon.open();
    interviewFactory.getRoundInterviews(roundId, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function (data, status, headers, config) {
      var round = data[0];
      if (round.id == roundId)
      {
        $scope.interviewAdminProcess.round = round;
        $scope.interviewAdminProcess.interview.timeSlot.setInterviewTimeRange();

        var roundTags = round.round_tags;
        if (roundTags)
        {
          for (var i = 0; i < roundTags.length; i++)
          {
            var tag = roundTags[i];

            if (tag.location)
            {
              var location = tag.location;
              $scope.interviewAdminProcess.locations.push(location);
            }
            else if (tag.role)
            {
              var role = tag.role;
              $scope.interviewAdminProcess.roles.push(role);
            }
          }
        }
      }
      waitingIcon.close();
    })
    .error(function (data, status, headers, config) {
      waitingIcon.close();
    });
  };


  $scope.interviewAdminProcess.getEmailTemplates = function()
  {
    waitingIcon.open();
    interviewFactory.getEmailTemplates($rootScope.current_year.id, $rootScope.current_process.id)
    .success(function (data, status, headers, config) {
      var templates = data.email_templates;

      for(var i = 0; i < templates.length; i++)
      {
        eType = templates[i].email_type;

        switch(eType)
        {
          case 'interview_mgr_select_applicant':
            $scope.default_email_templates.interview_mgr_select_applicant = templates[i];
            break;
          case 'interview_mgr_cancel_select_applicant':
            $scope.default_email_templates.interview_mgr_cancel_select_applicant = templates[i];
            break;
          case 'interview_mgr_schedule_applicant':
            $scope.default_email_templates.interview_mgr_schedule_applicant = templates[i];
            break;
          case 'interview_mgr_cancel_schedule_applicant':
            $scope.default_email_templates.interview_mgr_cancel_schedule_applicant = templates[i];
            break;
        }
      }
      waitingIcon.close();
    })
    .error(function (data, status, headers, config) {
      waitingIcon.close();
    });
  };

  $scope.interviewAdminProcess.refreshAll = function()
  {
    $scope.interviewAdminProcess.interview.refresh();
  };

  $scope.interviewAdminProcess.interview.tbl.setDataAndRequest = function()
  {
    var data = {
      pageCount: $scope.interviewAdminProcess.interview.tbl.perPage,
      page: $scope.interviewAdminProcess.interview.tbl.goPage,
      searchText: $scope.interviewAdminProcess.interview.tbl.searchText,
      orderBy: $scope.interviewAdminProcess.interview.tbl.orderBy,
      ascOrDesc: $scope.interviewAdminProcess.interview.tbl.sortOrder,
      procedureId: $scope.interviewAdminProcess.processId,
      roundId: $scope.interviewAdminProcess.roundId,
      "current_year_id": $rootScope.current_year.id,
      "current_process_id": $rootScope.current_process.id
    };
    $scope.interviewAdminProcess.interview.tbl.linkServerGetData($scope.interviewAdminProcess.interview.tbl, data);
  };

  $scope.interviewAdminProcess.interview.tbl.successDo = function(data)
  {
    $scope.interviewAdminProcess.myInterview.tbl.create_permission = data.create_permission;
    $scope.interviewAdminProcess.interview.tblHasInit = true;
  };

  $scope.interviewAdminProcess.applicantList.tbl.setDataAndRequest = function()
  {
    if ($scope.interviewAdminProcess.applicantList.interview && $scope.interviewAdminProcess.applicantList.interview.id)
    {
      var data = {
        pageCount: $scope.interviewAdminProcess.applicantList.tbl.perPage,
        page: $scope.interviewAdminProcess.applicantList.tbl.goPage,
        searchText: $scope.interviewAdminProcess.applicantList.tbl.searchText,
        orderBy: $scope.interviewAdminProcess.applicantList.tbl.orderBy,
        ascOrDesc: $scope.interviewAdminProcess.applicantList.tbl.sortOrder,
        interviewId: $scope.interviewAdminProcess.applicantList.interview.id,
        applicantType: $scope.interviewAdminProcess.applicantList.radioApplicantType,
        "current_year_id": $rootScope.current_year.id,
        "current_process_id": $rootScope.current_process.id,
        "current_user_status": $rootScope.current_user.status
      };

      $scope.interviewAdminProcess.applicantList.tbl.linkServerGetData($scope.interviewAdminProcess.applicantList.tbl, data);
    }
  };

  $scope.interviewAdminProcess.applicantList.tbl.successDo = function(data)
  {
    $scope.interviewAdminProcess.applicantList.tbl.b_download_rm_report = data.b_download_rm_report;
  };


  $scope.interviewAdminProcess.myInterview.tbl.setDataAndRequest = function()
  {
    var data = {
      pageCount: $scope.interviewAdminProcess.myInterview.tbl.perPage,
      page: $scope.interviewAdminProcess.myInterview.tbl.goPage,
      searchText: $scope.interviewAdminProcess.myInterview.tbl.searchText,
      orderBy: $scope.interviewAdminProcess.myInterview.tbl.orderBy,
      ascOrDesc: $scope.interviewAdminProcess.myInterview.tbl.sortOrder,
      procedureId: $scope.interviewAdminProcess.processId,
      roundId: $scope.interviewAdminProcess.roundId,
      "current_year_id": $rootScope.current_year.id,
      "current_process_id": $rootScope.current_process.id
    };

    $scope.interviewAdminProcess.myInterview.tbl.linkServerGetData($scope.interviewAdminProcess.myInterview.tbl, data);
  };

  $scope.interviewAdminProcess.myInterview.tbl.successDo = function(data)
  {
    $scope.interviewAdminProcess.myInterview.tblHasInit = true;
  };

  $scope.interviewAdminProcess.tab.interviewSelect = function()
  {
    if ($scope.interviewAdminProcess.getRoundSuccess && $rootScope.isRunNowProcess)
    {
      if (!$scope.interviewAdminProcess.interview.tblHasInit)
      {
        $scope.interviewAdminProcess.interview.tbl.init($scope, $scope.interviewAdminProcess.interview.tbl);
      }
      else
      {
        $scope.interviewAdminProcess.interview.refresh();
      }
    };
  };

  $scope.interviewAdminProcess.tab.applicantListSelect = function()
  {
    if ($scope.interviewAdminProcess.getRoundSuccess && $rootScope.isRunNowProcess)
    {
      $scope.interviewAdminProcess.applicantList.refleshInterviewSelect($scope.interviewAdminProcess.roundId);
    }
  };

  $scope.interviewAdminProcess.tab.myInterviewSelect = function()
  {
    if ($scope.interviewAdminProcess.getRoundSuccess && $rootScope.isRunNowProcess)
    {
      if (!$scope.interviewAdminProcess.myInterview.tblHasInit)
      {
        $scope.interviewAdminProcess.myInterview.tbl.init($scope, $scope.interviewAdminProcess.myInterview.tbl);
      }
      else
      {
        $scope.interviewAdminProcess.myInterview.timeSlot.refresh();
      }
    }
  };

  $scope.interviewAdminProcess.setDatetimepicker = function()
  {
    var setDatetimepickers = $('.setDatetimepicker');

    var start = transDateTimeAtZoneUTCToSub8ExistClientZone(new Date($scope.interviewAdminProcess.round.t_start));
    var end = transDateTimeAtZoneUTCToSub8ExistClientZone(new Date($scope.interviewAdminProcess.round.t_end));

    setDatetimepickers.datetimepicker({
      dateFormat: "mm/dd/yy",
      timeFormat: "hh:mm TT",
      closeText: "Close",
      minDate: start,
      minDateTime: start,
      maxDate: end,
      maxDateTime: end,
      beforeShow: (function(){
        setTimeout(function(){$('.setDatetimepicker').css('z-index', 1000);}, 0);
      })
    });
  };

  $scope.interviewAdminProcess.calendar.calendarRefresh = function()
  {
    //$scope.interviewAdminProcess.calendar.events.splice(0, $scope.interviewAdminProcess.calendar.events.length);
    if ($scope.interviewAdminProcess.calendar.calendarView.visStart && $scope.interviewAdminProcess.calendar.calendarView.visEnd)
    {
      var params = {
        start: transDateTimeAtZoneSub8ToUTC((new Date($scope.interviewAdminProcess.calendar.calendarView.visStart))),
        end: transDateTimeAtZoneSub8ToUTC((new Date($scope.interviewAdminProcess.calendar.calendarView.visEnd))),
        roundId: $scope.interviewAdminProcess.roundId,
        "current_year_id": $rootScope.current_year.id,
        "current_process_id": $rootScope.current_process.id
      };

      waitingIcon.open();
      interviewFactory.adminCalendarView(params)
      .success(function (data, status, headers, config) {
        $scope.interviewAdminProcess.calendar.interviewsTransToCalender(data);
        waitingIcon.close();
      })
      .error(function (data, status, headers, config) {
        waitingIcon.close();
      });
    }
  };

  $scope.interviewAdminProcess.calendar.interviewsTransToCalender = function(interviews)
  {
    var calendarInterviews = [];

    for (var i = 0; i < interviews.length; i++)
    {
      var interview = interviews[i];
      var interviewer = interview.interviewers[0];
      var interviewName = interview.name;

      for (var i_timeSlot = 0; i_timeSlot < interview.time_slots.length; i_timeSlot++)
      {
        var timeSlot = interview.time_slots[i_timeSlot];
        var place = timeSlot.place;
        var scheduledInterviewers = timeSlot.interviewer_users;
        var interviewees = timeSlot.interviewees;
        var t_start = transDateTimeAtZoneUTCToSub8ExistClientZone(new Date(timeSlot.t_start));
        var t_end = transDateTimeAtZoneUTCToSub8ExistClientZone(new Date(timeSlot.t_end));
        var color = (timeSlot.check)? "#38610B" : "";
        var title = [];
        title.push(interviewName);
        title.push("\n<place: ");
        title.push(place);
        title.push(">");

        if (interviewees && 0 < interviewees.length)
        {
          title.push("\n<Applicants>");
          for (var i_interviewee = 0; i_interviewee < interviewees.length; i_interviewee++)
          {
            var user = interviewees[i_interviewee].user;
            title.push("\n");
            title.push(user.name);
          };
        }

        if (scheduledInterviewers && 0 < scheduledInterviewers.length)
        {
          title.push("\n<Interviewers>");
          for (var i_scheduledInterviewer = 0; i_scheduledInterviewer < scheduledInterviewers.length; i_scheduledInterviewer++)
          {
            var user = scheduledInterviewers[i_scheduledInterviewer];
            title.push("\n");
            title.push(user.name);
          };
        }

        calendarInterviews.push({
          interviewer: interviewer,
          timeSlot: timeSlot,
          title: title.join(""),
          start: t_start,
          end: t_end,
          allDay: false,
          color: color
        });
      }
    }

    $scope.interviewAdminProcess.calendar.events.splice(0, $scope.interviewAdminProcess.calendar.events.length);
    $scope.interviewAdminProcess.calendar.events.push.apply($scope.interviewAdminProcess.calendar.events, calendarInterviews);
  };

  $scope.interviewAdminProcess.calendar.alertOnEventClick = function(event, allDay, jsEvent, view)
  {
    $scope.interviewAdminProcess.myInterview.timeSlot.click(event.timeSlot, event.interviewer);
  };

  $scope.interviewAdminProcess.calendar.renderView = function(view){
    $scope.interviewAdminProcess.calendar.calendarView = view;
    $scope.interviewAdminProcess.calendar.calendarRefresh();
  };

  /* Change View */
  $scope.interviewAdminProcess.calendar.changeView = function(view,calendar) {
    calendar.fullCalendar('changeView',view);
  };

  /* Change View */
  $scope.interviewAdminProcess.calendar.renderCalender = function(calendar) {
    if(calendar){
      calendar.fullCalendar('render');
    }
  };

  /* config object */
  $scope.interviewAdminProcess.calendar.uiConfig = {
    calendar:{
      height: 450,
      //editable: true,
      eventDurationEditable: false,
      disableResizing: true,
      timeFormat: 'hh:mm TT {-hh:mm TT}',
      header:{
        left: 'title',
        center: '',
        right: 'today prev,next'
      },
      eventClick: $scope.interviewAdminProcess.calendar.alertOnEventClick,
      viewRender: $scope.interviewAdminProcess.calendar.renderView
    }
  };

  $scope.interviewAdminProcess.interview.refresh = function()
  {
    $scope.interviewAdminProcess.interview.tbl.setDataAndRequest();
  };

  $scope.interviewAdminProcess.interview.clear = function()
  {
    $scope.interviewAdminProcess.interview.schedule.interview = '';
    $scope.interviewAdminProcess.applicantList.timeSlot = '';
  };

  $scope.interviewAdminProcess.interview.tableFieldTimeSlot.scheduleInterviewer = function(interview, timeSlot)
  {
    $scope.interviewAdminProcess.interview.schedule.interview = interview;
    $scope.interviewAdminProcess.interview.schedule.interviewer.init(timeSlot);
  };

  $scope.interviewAdminProcess.interview.tableFieldTimeSlot.scheduleApplicant = function(interview, timeSlot)
  {
    $scope.schedule_invited_email.subject = $scope.default_email_templates.interview_mgr_schedule_applicant.title;
    $scope.schedule_invited_email.content = $scope.default_email_templates.interview_mgr_schedule_applicant.content;
    $scope.schedule_canceled_email.subject = $scope.default_email_templates.interview_mgr_cancel_schedule_applicant.title;
    $scope.schedule_canceled_email.content = $scope.default_email_templates.interview_mgr_cancel_schedule_applicant.content;

    $scope.interviewAdminProcess.interview.schedule.interview = interview;
    $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.init(timeSlot);
  };

  $scope.interviewAdminProcess.interview.create.init = function()
  {
    $scope.interviewAdminProcess.flow = 300;
    $scope.interviewAdminProcess.interview.create.roundSelect = '';
    $scope.interviewAdminProcess.interview.create.positionSelect = '';
    $scope.interviewAdminProcess.interview.create.place = '';
    $scope.interviewAdminProcess.interview.create.vacancy = 1;
    $scope.interviewAdminProcess.interview.create.positionList = [];
    $scope.interviewAdminProcess.interview.create.name = '';
    $scope.interviewAdminProcess.interview.create.interviewerCanEdit = true;
    $scope.interviewAdminProcess.interview.create.interviewerCanSchedule = false;
    $scope.interviewAdminProcess.interview.create.interviewerVacancyPerTimeSlot = 1;
    $scope.interviewAdminProcess.interview.create.maxNumTimeSlotPerInterviewer = 1;
    $scope.interviewAdminProcess.interview.create.oneTimeSlotPerApplicant = true;

    $scope.interviewAdminProcess.interview.create.noMaxNumTimeSlotPerInterviewerCss = '';
  };

  $scope.interviewAdminProcess.interview.create.removePositionFormListClick = function(index)
  {
    $scope.interviewAdminProcess.interview.create.positionList.splice(index, 1);
  };

  $scope.interviewAdminProcess.interview.create.addPositionToListClick = function()
  {
    if ($scope.interviewAdminProcess.interview.create.positionSelect)
    {
      var positionList = $scope.interviewAdminProcess.interview.create.positionList;
      var isPush = true;
      for (var i = 0; i < positionList.length; i++)
      {
        if (positionList[i].id == $scope.interviewAdminProcess.interview.create.positionSelect.id)
        {
          isPush = false;
          break;
        }
      }

      if (isPush)
      {
        $scope.interviewAdminProcess.interview.create.positionList.push($scope.interviewAdminProcess.interview.create.positionSelect);
        $scope.interviewAdminProcess.interview.create.noPositionListCss = '';
        $scope.interviewAdminProcess.interview.create.positionSelect = '';
      }
    }
    else
    {
      $scope.interviewAdminProcess.interview.create.noSelectPositionCss = $scope.inputNotSetCss;
    };
  };

  $scope.interviewAdminProcess.interview.create.send = function()
  {
    var isSend = true;

    if (!$scope.interviewAdminProcess.interview.create.name)
    {
      $scope.interviewAdminProcess.interview.create.noNameCss = $scope.inputNotSetCss;
      isSend = false;
    }

    if (!$scope.interviewAdminProcess.interview.create.scheduleDueTime)
    {
      $scope.interviewAdminProcess.interview.create.noScheduleDueTimeCss = $scope.inputNotSetCss;
      isSend = false;
    }

    if (!checkPositiveInteger($scope.interviewAdminProcess.interview.create.vacancy))
    {
      $scope.interviewAdminProcess.interview.create.noVacancyCss = $scope.inputNotSetCss;
      isSend = false;
    }

    if ($scope.interviewAdminProcess.interview.create.interviewerCanSchedule)
    {
      if (!checkPositiveInteger($scope.interviewAdminProcess.interview.create.interviewerVacancyPerTimeSlot))
      {
        $scope.interviewAdminProcess.interview.create.noInterviewerVacancyPerTimeSlotCss = $scope.inputNotSetCss;
        isSend = false;
      }
      if (!checkPositiveInteger($scope.interviewAdminProcess.interview.create.maxNumTimeSlotPerInterviewer))
      {
        $scope.interviewAdminProcess.interview.create.noMaxNumTimeSlotPerInterviewerCss = $scope.inputNotSetCss;
        isSend = false;
      }
    }

    if (isSend)
    {
      var roundId = $scope.interviewAdminProcess.round.id;
      var positionList = $scope.interviewAdminProcess.interview.create.positionList;
      var name = $scope.interviewAdminProcess.interview.create.name;
      var scheduleDueTime = $scope.interviewAdminProcess.interview.create.scheduleDueTime;
      var place = $scope.interviewAdminProcess.interview.create.place;
      var vacancy = $scope.interviewAdminProcess.interview.create.vacancy;
      var interviewerCanEdit = $scope.interviewAdminProcess.interview.create.interviewerCanEdit;
      var interviewerCanSchedule = $scope.interviewAdminProcess.interview.create.interviewerCanSchedule;
      var interviewerVacancy = $scope.interviewAdminProcess.interview.create.interviewerVacancyPerTimeSlot;
      var maxTimeSlotPerInterviewer = $scope.interviewAdminProcess.interview.create.maxNumTimeSlotPerInterviewer;
      var oneTimeSlotPerApplicant = $scope.interviewAdminProcess.interview.create.oneTimeSlotPerApplicant;
      var positionIds = [];

      for (var i = 0; i < $scope.interviewAdminProcess.interview.create.positionList.length; i++)
      {
        positionIds.push(positionList[i].id);
      }

      var postData = {
        roundId: roundId,
        name: name,
        scheduleDueTime: scheduleDueTime,
        place: place,
        vacancy: vacancy,
        interviewerCanEdit: interviewerCanEdit,
        interviewerCanSchedule: interviewerCanSchedule,
        interviewerVacancy: interviewerVacancy,
        maxTimeSlotPerInterviewer: maxTimeSlotPerInterviewer,
        oneTimeSlotPerApplicant: oneTimeSlotPerApplicant,
        positionIds: positionIds,
        "current_year_id": $rootScope.current_year.id,
        "current_process_id": $rootScope.current_process.id
      };

      waitingIcon.open();
      interviewFactory.newInterview(postData)
      .success(function (data, status, headers, config) {
        if (data.msg)
        {
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        else
        {
          if (data.success)
          {
            $scope.interviewAdminProcess.flow = 380;
          }
          else
          {
            $scope.interviewAdminProcess.flow = 390;

          }
        }

        $scope.interviewAdminProcess.refreshAll();
        waitingIcon.close();
      })
      .error(function (data, status, headers, config) {
        $scope.interviewAdminProcess.flow = 390;
        waitingIcon.close();
      });
    }
  };

  $scope.interviewAdminProcess.interview.edit.init = function(interview)
  {
    $scope.interviewAdminProcess.flow = 500;
    $scope.interviewAdminProcess.interview.edit.interview = angular.copy(interview);
    $("#interviewAdminProcessInterviewEditForm").modal('toggle');
  };

  $scope.interviewAdminProcess.interview.edit.send = function()
  {
    var interviewId = $scope.interviewAdminProcess.interview.edit.interview.id;
    var name = $scope.interviewAdminProcess.interview.edit.interview.name;
    var scheduleDueTime = $scope.interviewAdminProcess.interview.edit.interview.s_schedule_due_time;
    var vacancy = $scope.interviewAdminProcess.interview.edit.interview.vacancy;
    var interviewerCanEdit = $scope.interviewAdminProcess.interview.edit.interview.interviewer_can_edit;
    var interviewerCanSchedule = $scope.interviewAdminProcess.interview.edit.interview.interviewer_can_schedule;
    var interviewerVacancy = $scope.interviewAdminProcess.interview.edit.interview.interviewer_vacancy;
    var maxTimeSlotPerInterviewer = $scope.interviewAdminProcess.interview.edit.interview.max_time_slot_per_interviewer;
    var oneTimeSlotPerApplicant = $scope.interviewAdminProcess.interview.edit.interview.one_time_slot_per_applicant;


    var postData = {
      name: name,
      scheduleDueTime: scheduleDueTime,
      vacancy: vacancy,
      interviewerCanEdit: interviewerCanEdit,
      interviewerCanSchedule: interviewerCanSchedule,
      interviewerVacancy: interviewerVacancy,
      maxTimeSlotPerInterviewer: maxTimeSlotPerInterviewer,
      oneTimeSlotPerApplicant: oneTimeSlotPerApplicant,
      "current_year_id": $rootScope.current_year.id,
      "current_process_id": $rootScope.current_process.id
    };

    waitingIcon.open();
    interviewFactory.editInterview(postData, interviewId)
    .success(function (data, status, headers, config) {
      $scope.eCode = data.eCode;

      if (data.msg)
      {
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      else
      {
        switch ($scope.eCode)
        {
          case 'xSYS00000':
            $scope.interviewAdminProcess.flow = 580;
            break;
          default:
            $scope.interviewAdminProcess.flow = 590;
        }
      }

      $scope.interviewAdminProcess.refreshAll();
      waitingIcon.close();
    })
    .error(function (data, status, headers, config) {
      $scope.interviewAdminProcess.flow = 590;
      waitingIcon.close();
    });

  };

  $scope.interviewAdminProcess.interview.remove.init = function(interview)
  {
    $scope.interviewAdminProcess.flow = 600;
    $scope.interviewAdminProcess.interview.remove.interview = angular.copy(interview);
    $("#interviewAdminProcessInterviewDeleteForm").modal('toggle');
  };

  $scope.interviewAdminProcess.interview.remove.send = function()
  {
    var interviewId = $scope.interviewAdminProcess.interview.remove.interview.id;
    waitingIcon.open();
    interviewFactory.deleteInterview(interviewId, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function (data, status, headers, config) {
      $scope.eCode = data.eCode;

      if (data.msg)
      {
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      else
      {
        switch ($scope.eCode)
        {
          case 'xSYS00000':
            $scope.interviewAdminProcess.flow = 680;
            break;
          default:
            $scope.interviewAdminProcess.flow = 690;
        }
      }

      $scope.interviewAdminProcess.refreshAll();
      waitingIcon.close();
    })
    .error(function (data, status, headers, config) {
      $scope.interviewAdminProcess.flow = 690;
      waitingIcon.close();
    });
  };

  $scope.interviewAdminProcess.interview.position.init = function(interview)
  {
    $scope.interviewAdminProcess.flow = 1000;
    $scope.interviewAdminProcess.interview.position.positions = [];
    $scope.interviewAdminProcess.interview.position.clear();
    $scope.interviewAdminProcess.interview.position.interview = angular.copy(interview);

    var interviewId  = $scope.interviewAdminProcess.interview.position.interview.id;
    $scope.interviewAdminProcess.interview.position.getPositions(interviewId);
    $("#interviewAdminProcessSetPositionForm").modal('toggle');
  };

  $scope.interviewAdminProcess.interview.position.checkSelectAll = function()
  {
    var positions = $scope.interviewAdminProcess.interview.position.positions;

    $scope.interviewAdminProcess.interview.position.selectAll = true;
    for (var i = 0; i < positions.length; i++)
    {
      if (!positions[i].check)
      {
        $scope.interviewAdminProcess.interview.position.selectAll = false;
        break;
      }
    }
  };

  $scope.interviewAdminProcess.interview.position.clear = function()
  {
    $scope.interviewAdminProcess.interview.clear();
    $scope.interviewAdminProcess.interview.position.add = [];
    $scope.interviewAdminProcess.interview.position.remove = [];
  };

  $scope.interviewAdminProcess.interview.position.getPositions = function(interviewId)
  {
    waitingIcon.open();

    interviewFactory.getPositions(interviewId, $rootScope.current_year.id, $rootScope.current_process.id, $scope.interviewAdminProcess.roundId)
    .success(function (data, status, headers, config) {
      $scope.interviewAdminProcess.interview.position.positions = data.positions;
      $scope.interviewAdminProcess.interview.position.checkSelectAll();
      waitingIcon.close();
    })
    .error(function (data, status, headers, config) {
      waitingIcon.close();
    });
  };

  $scope.interviewAdminProcess.interview.position.checkboxChange = function(position)
  {
    if (position.check)
    {
      $scope.interviewAdminProcess.interview.position.add['key' + position.id] = position;
      delete ($scope.interviewAdminProcess.interview.position.remove['key' + position.id]);
    }
    else
    {
      delete ($scope.interviewAdminProcess.interview.position.add['key' + position.id]);
      $scope.interviewAdminProcess.interview.position.remove['key'+ position.id] = position;
    }
    $scope.interviewAdminProcess.interview.position.checkSelectAll();
  };

  $scope.interviewAdminProcess.interview.position.selectAllChange = function()
  {
    var positions = $scope.interviewAdminProcess.interview.position.positions;
    if ($scope.interviewAdminProcess.interview.position.selectAll)
    {
      for (var i = 0; i < positions.length; i++)
      {
        positions[i].check = true;
        $scope.interviewAdminProcess.interview.position.add['key' + positions[i].id] = positions[i];
        delete ($scope.interviewAdminProcess.interview.position.remove['key' + positions[i].id]);
      }
    }
    else
    {
      for (var i = 0; i < positions.length; i++)
      {
        positions[i].check = false;
        delete ($scope.interviewAdminProcess.interview.position.add['key' + positions[i].id]);
        $scope.interviewAdminProcess.interview.position.remove['key'+ positions[i].id] = positions[i];
      }
    }
  };

  $scope.interviewAdminProcess.interview.position.send = function()
  {
    var positionIdAdd = [];
    for (var position in $scope.interviewAdminProcess.interview.position.add)
    {
      positionIdAdd.push($scope.interviewAdminProcess.interview.position.add[position].id);
    }
    var positionIdRemove = [];

    for (var position in $scope.interviewAdminProcess.interview.position.remove)
    {
      positionIdRemove.push($scope.interviewAdminProcess.interview.position.remove[position].id);
    }

    var postData = {
      interviewId: $scope.interviewAdminProcess.interview.position.interview.id,
      positionAdd: (positionIdAdd.length == 0 ? null : positionIdAdd),
      positionRemove: (positionIdRemove.length == 0 ? null : positionIdRemove),
      "current_year_id": $rootScope.current_year.id,
      "current_process_id": $rootScope.current_process.id
    };

    waitingIcon.open();
    interviewFactory.setPositions(postData)
    .success(function (data, status, headers, config) {
      if (data.msg)
      {
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      else
      {
        if (data.success)
        {
          $scope.interviewAdminProcess.flow = 1080;
        }
        else
        {
          $scope.interviewAdminProcess.flow = 1090;
        }
      }

      $scope.interviewAdminProcess.refreshAll();
      $scope.interviewAdminProcess.interview.position.clear();
      waitingIcon.close();
    })
    .error(function (data, status, headers, config) {
      $scope.interviewAdminProcess.flow = 1090;
      $scope.interviewAdminProcess.interview.position.clear();
      waitingIcon.close();
    });
  };

  $scope.interviewAdminProcess.interview.interviewer.init = function(interview)
  {
    $scope.interviewAdminProcess.flow = 700;
    $scope.interviewAdminProcess.interview.interviewer.interviewers = [];
    $scope.interviewAdminProcess.interview.interviewer.sunetInterviewers = [];
    $scope.interviewAdminProcess.interview.interviewer.filterInterviewer = '';
    $scope.interviewAdminProcess.interview.interviewer.sunetInterviewInit();

    $scope.interviewAdminProcess.interview.schedule.interviewer.notSetInterviewerUsers = [];
    $scope.interviewAdminProcess.interview.interviewer.clear();
    $scope.interviewAdminProcess.interview.interviewer.interview = angular.copy(interview);
    $scope.interviewAdminProcess.interview.interviewer.getInterviewers($scope.interviewAdminProcess.interview.interviewer.interview.id);
    $("#interviewAdminProcessSetInterviewerForm").modal('toggle');
  };

  $scope.interviewAdminProcess.interview.interviewer.checkSelectAll = function()
  {
    var interviewers = $scope.interviewAdminProcess.interview.interviewer.interviewers;

    $scope.interviewAdminProcess.interview.interviewer.selectAll = true;
    for (var i = 0; i < interviewers.length; i++)
    {
      if (!interviewers[i].check)
      {
        $scope.interviewAdminProcess.interview.interviewer.selectAll = false;
        break;
      }
    }
  };

  $scope.interviewAdminProcess.interview.interviewer.clear = function()
  {
    $scope.interviewAdminProcess.interview.clear();
    $scope.interviewAdminProcess.interview.interviewer.add = [];
    $scope.interviewAdminProcess.interview.interviewer.remove = [];
    $scope.interviewAdminProcess.interview.interviewer.sunetAdd = [];
    $scope.interviewAdminProcess.interview.interviewer.sunetRemove = [];
  };

  $scope.interviewAdminProcess.interview.interviewer.getInterviewers = function(interviewId)
  {
    waitingIcon.open();
    interviewFactory.getInterviewers(interviewId, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function (data, status, headers, config) {
      $scope.interviewAdminProcess.interview.interviewer.interviewers = data.interviewers;
      $scope.interviewAdminProcess.interview.interviewer.sunetInterviewers = data.sunet_interviewers;
      $scope.interviewAdminProcess.interview.interviewer.checkSelectAll();
      waitingIcon.close();
    })
    .error(function (data, status, headers, config) {
      waitingIcon.close();
    });
  };

  $scope.interviewAdminProcess.interview.interviewer.checkboxChange = function(interviewer)
  {
    if (interviewer.check)
    {
      $scope.interviewAdminProcess.interview.interviewer.add['key' + interviewer.id] = interviewer;
      delete ($scope.interviewAdminProcess.interview.interviewer.remove['key' + interviewer.id]);
    }
    else
    {
      delete ($scope.interviewAdminProcess.interview.interviewer.add['key' + interviewer.id]);
      $scope.interviewAdminProcess.interview.interviewer.remove['key'+ interviewer.id] = interviewer;
    }
    $scope.interviewAdminProcess.interview.interviewer.checkSelectAll();
  };

  $scope.interviewAdminProcess.interview.interviewer.selectAllChange = function()
  {
    var interviewers = $scope.interviewAdminProcess.interview.interviewer.interviewers;
    if ($scope.interviewAdminProcess.interview.interviewer.selectAll)
    {
      for (var i = 0; i < interviewers.length; i++)
      {
        interviewers[i].check = true;
        $scope.interviewAdminProcess.interview.interviewer.add['key' + interviewers[i].id] = interviewers[i];
        delete ($scope.interviewAdminProcess.interview.interviewer.remove['key' + interviewers[i].id]);
      }
    }
    else
    {
      for (var i = 0; i < interviewers.length; i++)
      {
        interviewers[i].check = false;
        delete ($scope.interviewAdminProcess.interview.interviewer.add['key' + interviewers[i].id]);
        $scope.interviewAdminProcess.interview.interviewer.remove['key'+ interviewers[i].id] = interviewers[i];
      }
    }
  };

  $scope.interviewAdminProcess.interview.interviewer.sunetInterviewInit = function()
  {
    $scope.interviewAdminProcess.interview.interviewer.newInterviewer.sunetId = '';
    $scope.interviewAdminProcess.interview.interviewer.newInterviewer.status = 'Student';
    $scope.interviewAdminProcess.interview.interviewer.newInterviewer.email = '';
    $scope.interviewAdminProcess.interview.interviewer.newInterviewer.firstName = '';
    $scope.interviewAdminProcess.interview.interviewer.newInterviewer.middleName = '';
    $scope.interviewAdminProcess.interview.interviewer.newInterviewer.lastName = '';
    $scope.interviewAdminProcess.interview.interviewer.newInterviewer.noSunetIdCss = '';
    $scope.interviewAdminProcess.interview.interviewer.newInterviewer.noEmailCss = '';
    $scope.interviewAdminProcess.interview.interviewer.newInterviewer.noFirstNameCss = '';
  };

  $scope.interviewAdminProcess.interview.interviewer.addSunetInterviewer = function()
  {
    var isAdd = true;
    var sunetId = $scope.interviewAdminProcess.interview.interviewer.newInterviewer.sunetId;
    var status = $scope.interviewAdminProcess.interview.interviewer.newInterviewer.status;
    var email = $scope.interviewAdminProcess.interview.interviewer.newInterviewer.email;
    var firstName = $scope.interviewAdminProcess.interview.interviewer.newInterviewer.firstName;
    var middleName = $scope.interviewAdminProcess.interview.interviewer.newInterviewer.middleName;
    var lastName = $scope.interviewAdminProcess.interview.interviewer.newInterviewer.lastName;

    if (!sunetId)
    {
      $scope.interviewAdminProcess.interview.interviewer.newInterviewer.noSunetIdCss = $scope.inputNotSetCss;
      isAdd = false;
    }

    if (!email)
    {
      $scope.interviewAdminProcess.interview.interviewer.newInterviewer.noEmailCss = $scope.inputNotSetCss;
      isAdd = false;
    }

    if (!firstName)
    {
      $scope.interviewAdminProcess.interview.interviewer.newInterviewer.noFirstNameCss = $scope.inputNotSetCss;
      isAdd = false;
    }

    if (isAdd)
    {
      if (!$scope.interviewAdminProcess.interview.interviewer.sunetAdd[sunetId])
      {
        var interviewer = {
          sunet_id: sunetId,
          email: email,
          first_name: firstName,
          middle_name: middleName,
          last_name: lastName,
          status: status
        };

        $scope.interviewAdminProcess.interview.interviewer.sunetInterviewers.push(interviewer);
        $scope.interviewAdminProcess.interview.interviewer.sunetAdd[sunetId] = interviewer;
        delete $scope.interviewAdminProcess.interview.interviewer.sunetRemove[sunetId];
      }
    }
  };

  $scope.interviewAdminProcess.interview.interviewer.removeSunetInterviewer = function(interviewer)
  {

    for (var i = 0; i < $scope.interviewAdminProcess.interview.interviewer.sunetInterviewers.length; i++)
    {
      inListInterviewer = $scope.interviewAdminProcess.interview.interviewer.sunetInterviewers[i];
      if (inListInterviewer.sunet_id == interviewer.sunet_id)
      {
        $scope.interviewAdminProcess.interview.interviewer.sunetInterviewers.splice(i, 1);
      }
    }

    if (interviewer.id)
    {
      $scope.interviewAdminProcess.interview.interviewer.sunetRemove[interviewer.sunet_id] = interviewer;
    }
    delete $scope.interviewAdminProcess.interview.interviewer.sunetAdd[interviewer.sunet_id];
  };

  $scope.interviewAdminProcess.interview.interviewer.send = function()
  {
    var interviewerIdAdd = [];
    var interviewerIdRemove = [];
    var sunetInterviewerAdd = [];
    var sunetInterviewerRemoveIds = [];

    for (var key in $scope.interviewAdminProcess.interview.interviewer.add)
    {
      interviewerIdAdd.push($scope.interviewAdminProcess.interview.interviewer.add[key].id);
    }

    for (var key in $scope.interviewAdminProcess.interview.interviewer.remove)
    {
      interviewerIdRemove.push($scope.interviewAdminProcess.interview.interviewer.remove[key].id);
    }

    for (var key in $scope.interviewAdminProcess.interview.interviewer.sunetAdd)
    {
      sunetInterviewerAdd.push($scope.interviewAdminProcess.interview.interviewer.sunetAdd[key]);
    }

    for (var key in $scope.interviewAdminProcess.interview.interviewer.sunetRemove)
    {
      sunetInterviewerRemoveIds.push($scope.interviewAdminProcess.interview.interviewer.sunetRemove[key].id);
    }

    var postData = {
      interviewId: $scope.interviewAdminProcess.interview.interviewer.interview.id,
      interviewerAdd: (interviewerIdAdd.length == 0 ? null : interviewerIdAdd),
      interviewerRemove: (interviewerIdRemove.length == 0 ? null : interviewerIdRemove),
      sunetInterviewerAdd: (sunetInterviewerAdd.length == 0 ? null : sunetInterviewerAdd),
      sunetInterviewerRemoveIds: (sunetInterviewerRemoveIds.length == 0 ? null : sunetInterviewerRemoveIds),
      "current_year_id": $rootScope.current_year.id,
      "current_process_id": $rootScope.current_process.id
    };

    waitingIcon.open();
    interviewFactory.setInterviewers(postData)
    .success(function (data, status, headers, config) {
      if (data.msg)
      {
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      else
      {
        if (data.success)
        {
          $scope.interviewAdminProcess.flow = 780;
        }
        else
        {
          $scope.interviewAdminProcess.interview.interviewer.not_set_interviewer_user_sunet_ids = data.not_set_interviewer_user_sunet_ids;
          $scope.interviewAdminProcess.flow = 790;
        }
      }

      $scope.interviewAdminProcess.refreshAll();
      $scope.interviewAdminProcess.interview.interviewer.clear();
      waitingIcon.close();
    })
    .error(function (data, status, headers, config) {
      $scope.interviewAdminProcess.flow = 790;
      $scope.interviewAdminProcess.interview.interviewer.clear();
      waitingIcon.close();
    });
  };

  $scope.interviewAdminProcess.interview.timeSlot.init = function(interview)
  {
    $scope.interviewAdminProcess.flow = 900;
    $scope.interviewAdminProcess.interview.timeSlot.clear();
    $scope.interviewAdminProcess.interview.timeSlot.timepicker.interval = 30;
    $scope.interviewAdminProcess.interview.timeSlot.timepicker.quantity = 1;
    $scope.interviewAdminProcess.interview.timeSlot.timeList = [];
    $scope.interviewAdminProcess.interview.timeSlot.timepicker.start = '';
    $scope.interviewAdminProcess.interview.timeSlot.timepicker.end = '';
    $scope.interviewAdminProcess.interview.timeSlot.isNewTimeSlot = false;
    $scope.interviewAdminProcess.interview.timeSlot.isTimeAdding = false;
    $scope.interviewAdminProcess.interview.timeSlot.place = '';

    $scope.interviewAdminProcess.interview.timeSlot.interview = angular.copy(interview);
    $scope.interviewAdminProcess.interview.timeSlot.addTimeSlotToTimeList($scope.interviewAdminProcess.interview.timeSlot.interview.time_slots);
    $("#interviewAdminProcessInterviewTimeSlotEditForm").modal('toggle');
  };

  $scope.interviewAdminProcess.interview.timeSlot.clear = function()
  {
    $scope.interviewAdminProcess.interview.clear();
    $scope.interviewAdminProcess.interview.timeSlot.remove = [];
  };

  $scope.interviewAdminProcess.interview.timeSlot.setInterviewTimeRange = function()
  {
    var roundStart = transDateTimeAtZoneUTCToSub8ExistClientZone(new Date($scope.interviewAdminProcess.round.t_start));
    var roundEnd = transDateTimeAtZoneUTCToSub8ExistClientZone(new Date($scope.interviewAdminProcess.round.t_end));

    var startTimePicker = $('#interviewAdminProcessInterviewTimeSlotStartTimePicker');
    var endTimePicker = $('#interviewAdminProcessInterviewTimeSlotEndTimePicker');
    startTimePicker.datetimepicker({
      dateFormat: "mm/dd/yy",
      timeFormat: "hh:mm TT",
      closeText: "Close",
      beforeShow: (function() {
        $scope.interviewAdminProcess.interview.timeSlot.noStartTimeCss = '';
        setTimeout(function(){startTimePicker.css('z-index', 1000);}, 0);
      }),
      hour: 9,
      minute: 0,
      stepMinute: 5,
      onSelect: (function(selectedDateTime) {
        endTimePicker.datetimepicker('option', 'minDate', new Date(selectedDateTime));
        endTimePicker.datetimepicker('option', 'maxDate', new Date(selectedDateTime));
        if (!$scope.interviewAdminProcess.interview.timeSlot.timepicker.end)
        {
          endTime = new Date(startTimePicker.datetimepicker('getDate'));
          endTime.setMinutes(endTime.getMinutes() + parseInt($scope.interviewAdminProcess.interview.timeSlot.timepicker.interval));
          endTimePicker.datetimepicker('setDate', endTime);
        }
      })
    });

    endTimePicker.datetimepicker({
      dateFormat: "mm/dd/yy",
      timeFormat: "hh:mm TT",
      closeText: "Close",
      beforeShow: function() {
        setTimeout(function(){endTimePicker.css('z-index', 1000);}, 0);
        $scope.interviewAdminProcess.interview.timeSlot.noEndTimeCss = '';
      },
      hour: 9,
      minute: 30,
      stepMinute: 5
    });

    startTimePicker.datepicker("option", "minDate", roundStart)
                   .datetimepicker("option", "minDateTime", roundStart);
    startTimePicker.datepicker("option", "maxDate", roundEnd)
                   .datetimepicker("option", "maxDateTime", roundEnd);

    endTimePicker.datepicker("option", "minDate", roundStart)
                 .datetimepicker("option", "minDateTime", roundStart);
    endTimePicker.datepicker("option", "maxDate", roundEnd)
                 .datetimepicker("option", "maxDateTime", roundEnd);
  };

  $scope.interviewAdminProcess.interview.timeSlot.timeListOnChange = function(start, end, index)
  {
    $scope.interviewAdminProcess.interview.timeSlot.timeList[index].t_start = new Date(start);
    $scope.interviewAdminProcess.interview.timeSlot.timeList[index].t_end = new Date(end);
  };

  $scope.interviewAdminProcess.interview.timeSlot.removeTimeFormListClick = function(index)
  {
    if ($scope.interviewAdminProcess.interview.timeSlot.timeList[index].timeSlotId)
    {
      $scope.interviewAdminProcess.interview.timeSlot.remove.push($scope.interviewAdminProcess.interview.timeSlot.timeList[index]);
    }

    $scope.interviewAdminProcess.interview.timeSlot.timeList.splice(index, 1);
  };

  $scope.interviewAdminProcess.interview.timeSlot.addTimeToListClick = function()
  {
    var quantity = $scope.interviewAdminProcess.interview.timeSlot.timepicker.quantity;
    var interval = parseInt($scope.interviewAdminProcess.interview.timeSlot.timepicker.interval) * 60000;
    var time_between =  parseInt($scope.interviewAdminProcess.interview.timeSlot.timepicker.time_between) * 60000;
    var checkStartTime = Date.parse($scope.interviewAdminProcess.interview.timeSlot.timepicker.start);
    var timeList = $scope.interviewAdminProcess.interview.timeSlot.timeList;
    var place = $scope.interviewAdminProcess.interview.timeSlot.place;
    var isRun = true;

    if(!time_between)
    {
      time_between = 0;
    }

    if (!checkStartTime)
    {
      $scope.interviewAdminProcess.interview.timeSlot.noStartTimeCss = $scope.inputNotSetCss;
      isRun = false;
    }

    if (!checkPositiveInteger(interval))
    {
      $scope.interviewAdminProcess.interview.timeSlot.noQuantityCss = $scope.inputNotSetCss;
      isRun = false;
    };

    if (!checkPositiveInteger(quantity))
    {
      $scope.interviewAdminProcess.interview.timeSlot.noQuantityCss = $scope.inputNotSetCss;
      isRun = false;
    };

    if (!place)
    {
      $scope.interviewAdminProcess.interview.timeSlot.noPlaceCss = $scope.inputNotSetCss;
      isRun = false;
    }

    //if (checkStartTime < checkEndTime)
    if (isRun)
    {
      var start = Date.parse($scope.interviewAdminProcess.interview.timeSlot.timepicker.start);
      //var end = Date.parse($scope.interviewAdminProcess.interview.timeSlot.timepicker.end);
      var timeSlotStart = new Date(start);
      var timeSlotEnd = new Date(timeSlotStart.getTime() + interval);

      var counter = 0;
      var isPush = true;
      do
      {
        var newTime = {
          place: place,
          t_start: timeSlotStart,
          t_end: timeSlotEnd
        };
        for (var i = 0; i < timeList.length; i++)
        {
          if ((timeList[i].t_start.getTime() == newTime.t_start.getTime()) && (timeList[i].t_end.getTime() == newTime.t_end.getTime()))
          {
            isPush = false;
            break;
          }
        }

        if (isPush)
        {
          //rsasTime = $scope.interviewAdminProcess.startAndEndTimeChangeRsasTimeFormat(newTime);

          timeList.push(newTime);

          $scope.interviewAdminProcess.interview.timeSlot.noTimeListCss = '';
          $scope.interviewAdminProcess.interview.timeSlot.isNewTimeSlot = true;
        }

        isPush = true;
        timeSlotStart = new Date(timeSlotStart.getTime() + interval + time_between);
        timeSlotEnd = new Date(timeSlotStart.getTime() + interval);
        counter++;
      }
      while (counter < quantity);

      $scope.interviewAdminProcess.interview.timeSlot.timepicker.start = '';
      $scope.interviewAdminProcess.interview.timeSlot.timepicker.end = '';

      $scope.interviewAdminProcess.interview.timeSlot.isTimeAdding = false;
    }
    else
    {
      $scope.interviewAdminProcess.interview.timeSlot.noEndTimeCss = $scope.inputNotSetCss;
    }
  };

  $scope.interviewAdminProcess.interview.timeSlot.addTimeSlotToTimeList = function(timeSlots)
  {
    var timeList = $scope.interviewAdminProcess.interview.timeSlot.timeList;

    for (var i = 0; i < timeSlots.length; i++)
    {
      var newTime = {
        timeSlotId: timeSlots[i].id,
        place: timeSlots[i].place,
        t_start: transDateTimeAtZoneUTCToSub8ExistClientZone(new Date(Date.parse(timeSlots[i].t_start))),
        t_end: transDateTimeAtZoneUTCToSub8ExistClientZone(new Date(Date.parse(timeSlots[i].t_end)))
      };
      timeList.push(newTime);
    }
  };

  $scope.interviewAdminProcess.interview.timeSlot.send = function()
  {
    // this function has some bug need fix.
    var isSend = true;
    var interviewId = $scope.interviewAdminProcess.interview.timeSlot.interview.id;
    var timeList = $scope.interviewAdminProcess.interview.timeSlot.timeList;
    var place = $scope.interviewAdminProcess.interview.timeSlot.place;
    var timeSlotRemoveIds = [];

    if (isSend)
    {
      for (var i = 0; i < $scope.interviewAdminProcess.interview.timeSlot.remove.length; i++)
      {
        timeSlotRemoveIds.push($scope.interviewAdminProcess.interview.timeSlot.remove[i].timeSlotId);
      }

      for (var i = 0; i < timeList.length; i++)
      {
        timeList[i].t_start = transDateTimeAtZoneSub8ToUTCRemoveClientZone(timeList[i].t_start);
        timeList[i].t_end = transDateTimeAtZoneSub8ToUTCRemoveClientZone(timeList[i].t_end);
      }

      var postData = {
        interviewId: interviewId,
        timeSlotRemoveIds: timeSlotRemoveIds,
        timeList: timeList,
        place: place,
        "current_year_id": $rootScope.current_year.id,
        "current_process_id": $rootScope.current_process.id
      };

      waitingIcon.open();
      interviewFactory.setTimeSlots(postData)
      .success(function (data, status, headers, config) {
        if (data.msg)
        {
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        else
        {
          if (data.success)
          {
            $scope.interviewAdminProcess.flow = 980;
          }
          else
          {
            $scope.interviewAdminProcess.flow = 990;
          }
        }

        $scope.interviewAdminProcess.refreshAll();
        $scope.interviewAdminProcess.interview.timeSlot.clear();
        waitingIcon.close();
      })
      .error(function (data, status, headers, config) {
        $scope.interviewAdminProcess.flow = 990;
        $scope.interviewAdminProcess.interview.timeSlot.clear();
        waitingIcon.close();
      });
    }
  };

  $scope.interviewAdminProcess.interview.selectApplicant.init = function(interview)
  {
    $scope.interviewAdminProcess.flow = 800;
    $scope.interviewAdminProcess.interview.selectApplicant.applicants = [];
    $scope.interviewAdminProcess.interview.selectApplicant.selectAll = false;
    $scope.interviewAdminProcess.interview.selectApplicant.radioApplicantType = 1;
    $scope.interviewAdminProcess.interview.selectApplicant.clear();
    $scope.interviewAdminProcess.interview.selectApplicant.interview = angular.copy(interview);
    $scope.interviewAdminProcess.interview.selectApplicant.getApplicantList(interview.id);
    $("#interviewAdminProcessSetInterviewApplicantForm").modal('toggle');
  };

  $scope.interviewAdminProcess.interview.selectApplicant.clear = function()
  {
    $scope.interviewAdminProcess.interview.clear();
    $scope.interviewAdminProcess.interview.selectApplicant.add = [];
    $scope.interviewAdminProcess.interview.selectApplicant.remove = [];
  };

  $scope.interviewAdminProcess.interview.selectApplicant.checkSelectAll = function()
  {
    var applicants = $scope.interviewAdminProcess.interview.selectApplicant.applicants;

    $scope.interviewAdminProcess.interview.selectApplicant.selectAll = true;
    for (var i = 0; i < applicants.length; i++)
    {
      if (applicants[i].list_type == $scope.interviewAdminProcess.interview.selectApplicant.radioApplicantType || 0 == applicants[i].list_type)
      {
        if (!applicants[i].check)
        {
          $scope.interviewAdminProcess.interview.selectApplicant.selectAll = false;
          break;
        }
      }
    }
  };

  $scope.interviewAdminProcess.interview.selectApplicant.selectAllChange = function()
  {
    var applicants = $scope.interviewAdminProcess.interview.selectApplicant.applicants;
    if ($scope.interviewAdminProcess.interview.selectApplicant.selectAll)
    {
      for (var i = 0; i < applicants.length; i++)
      {
        if (applicants[i].list_type == $scope.interviewAdminProcess.interview.selectApplicant.radioApplicantType || 0 == applicants[i].list_type)
        {
          applicants[i].check = true;
          $scope.interviewAdminProcess.interview.selectApplicant.add['key' + applicants[i].id] = applicants[i];
          delete ($scope.interviewAdminProcess.interview.selectApplicant.remove['key' + applicants[i].id]);
        }
      }
    }
    else
    {
      for (var i = 0; i < applicants.length; i++)
      {
        if (applicants[i].list_type == $scope.interviewAdminProcess.interview.selectApplicant.radioApplicantType || 0 == applicants[i].list_type)
        {
          applicants[i].check = false;
          delete ($scope.interviewAdminProcess.interview.selectApplicant.add['key' + applicants[i].id]);
          $scope.interviewAdminProcess.interview.selectApplicant.remove['key'+ applicants[i].id] = applicants[i];
        }
      }
    }
  };

  $scope.interviewAdminProcess.interview.selectApplicant.checkboxChange = function(applicant)
  {
    if (applicant.check)
    {
      $scope.interviewAdminProcess.interview.selectApplicant.add['key' + applicant.id] = applicant;
      delete ($scope.interviewAdminProcess.interview.selectApplicant.remove['key' + applicant.id]);
    }
    else
    {
      delete ($scope.interviewAdminProcess.interview.selectApplicant.add['key' + applicant.id]);
      $scope.interviewAdminProcess.interview.selectApplicant.remove['key'+ applicant.id] = applicant;
    }
    $scope.interviewAdminProcess.interview.selectApplicant.checkSelectAll();
  };


  $scope.interviewAdminProcess.interview.selectApplicant.getApplicantList = function(interviewId)
  {
    waitingIcon.open();
    interviewFactory.getApplicantList(interviewId, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function (data, status, headers, config) {
      $scope.interviewAdminProcess.interview.selectApplicant.applicants = data.applicant_list;
      $scope.interviewAdminProcess.interview.selectApplicant.checkSelectAll();
      waitingIcon.close();
    })
    .error(function (data, status, headers, config) {
      waitingIcon.close();
    });
  };

  $scope.interviewAdminProcess.interview.selectApplicant.send = function()
  {
    var applicantIdAdd = [];
    for (var user in $scope.interviewAdminProcess.interview.selectApplicant.add)
    {
      applicantIdAdd.push($scope.interviewAdminProcess.interview.selectApplicant.add[user].id);
    }
    var applicantIdRemove = [];

    for (var user in $scope.interviewAdminProcess.interview.selectApplicant.remove)
    {
      applicantIdRemove.push($scope.interviewAdminProcess.interview.selectApplicant.remove[user].id);
    }

    var postData = {
      interviewId: $scope.interviewAdminProcess.interview.selectApplicant.interview.id,
      applicantIdAdd: (applicantIdAdd.length == 0 ? null : applicantIdAdd),
      applicantIdRemove: (applicantIdRemove.length == 0 ? null : applicantIdRemove),
      "current_year_id": $rootScope.current_year.id,
      "current_process_id": $rootScope.current_process.id
    };

    waitingIcon.open();
    interviewFactory.setInvitees(postData)
    .success(function (data, status, headers, config) {
      if (data.msg)
      {
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      else
      {
        if (data.success)
        {
          $scope.interviewAdminProcess.flow = 880;
        }
        else
        {
          $scope.interviewAdminProcess.flow = 890;
        }
      }

      $scope.interviewAdminProcess.interview.selectApplicant.clear();
      waitingIcon.close();
    })
    .error(function (data, status, headers, config) {
      $scope.interviewAdminProcess.flow = 890;
      $scope.interviewAdminProcess.interview.selectApplicant.clear();
      waitingIcon.close();
    });
  };

  $scope.interviewAdminProcess.interview.sendInviteEmailToApplicant.init = function(interview)
  {
    $scope.interviewAdminProcess.flow = 950;
    $scope.interviewAdminProcess.interview.sendInviteEmailToApplicant.interview = angular.copy(interview);

    $scope.select_invited_email.subject = $scope.default_email_templates.interview_mgr_select_applicant.title;
    $scope.select_invited_email.content = $scope.default_email_templates.interview_mgr_select_applicant.content;

    $scope.interviewAdminProcess.getInterviewSelectApplicants(interview.id, $scope.select_invited_email.recipients);

    $("#interviewAdminProcessSendInviteEmailToApplicantForm").modal('toggle');
  };

  $scope.interviewAdminProcess.interview.sendInviteEmailToApplicant.send = function()
  {
    var postData = {
      "current_year_id": $rootScope.current_year.id,
      "current_process_id": $rootScope.current_process.id,
      interviewId: $scope.interviewAdminProcess.interview.sendInviteEmailToApplicant.interview.id,
      invited_email_subject: $scope.select_invited_email.subject,
      invited_email_content: $scope.select_invited_email.content
    };

    waitingIcon.open();
    interviewFactory.sendInviteEmailToApplicants(postData)
    .success(function (data, status, headers, config) {
      $scope.interviewAdminProcess.flow = 958;
      waitingIcon.close();
    })
    .error(function (data, status, headers, config) {
      $scope.interviewAdminProcess.flow = 959;
      waitingIcon.close();
    });
  };



  $scope.interviewAdminProcess.interview.schedule.refresh = function()
  {
    if ($scope.interviewAdminProcess.interview.schedule.interview)
    {
      var oldInterview = $scope.interviewAdminProcess.interview.schedule.interview;

      for (var i = 0; $scope.interviewAdminProcess.interview.tbl.show.length; i++)
      {
        var interview = $scope.interviewAdminProcess.interview.tbl.show[i];
        if (interview.id == oldInterview.id)
        {
          $scope.interviewAdminProcess.interview.schedule.interview = angular.copy(interview);
          break;
        }
      }
    }
  };

  $scope.interviewAdminProcess.interview.schedule.init = function(interview)
  {
    $scope.interviewAdminProcess.interview.schedule.interview = angular.copy(interview);
  };

  $scope.interviewAdminProcess.interview.schedule.setting.init = function(timeSlot)
  {
    $scope.interviewAdminProcess.interview.schedule.setting.timeSlot = angular.copy(timeSlot);
    $scope.interviewAdminProcess.flow = 2000;

    $scope.interviewAdminProcess.interview.schedule.setting.noEndTimeCss = '';

    var newTime = {
      t_start: transDateTimeAtZoneUTCToSub8ExistClientZone(new Date(Date.parse($scope.interviewAdminProcess.interview.schedule.setting.timeSlot.t_start))),
      t_end: transDateTimeAtZoneUTCToSub8ExistClientZone(new Date(Date.parse($scope.interviewAdminProcess.interview.schedule.setting.timeSlot.t_end)))
    };

    //rsasTime = $scope.interviewAdminProcess.startAndEndTimeChangeRsasTimeFormat(newTime);

    $scope.interviewAdminProcess.interview.schedule.setInterviewTimeRange();
    $("#interviewAdminProcessInterviewScheduleEditForm").modal('toggle');

  };

  $scope.interviewAdminProcess.interview.schedule.setInterviewTimeRange = function()
  {
    var startTimePicker = $('#interviewAdminProcessInterviewScheduleSettingStartTimePicker');
    var endTimePicker = $('#interviewAdminProcessInterviewScheduleSettingEndTimePicker');

    var start = transDateTimeAtZoneUTCToSub8ExistClientZone(new Date($scope.interviewAdminProcess.round.t_start));
    var end = transDateTimeAtZoneUTCToSub8ExistClientZone(new Date($scope.interviewAdminProcess.round.t_end));

    startTimePicker.datepicker("option", "minDate", start)
                   .datetimepicker("option", "minDateTime", start);
    startTimePicker.datepicker("option", "maxDate", end)
                   .datetimepicker("option", "maxDateTime", end);

    endTimePicker.datepicker("option", "minDate", start)
                 .datetimepicker("option", "minDateTime", start);
    endTimePicker.datepicker("option", "maxDate", end)
                 .datetimepicker("option", "maxDateTime", end);
  };

  $scope.interviewAdminProcess.interview.schedule.setting.timeOnChange = function(start, end)
  {
    $scope.interviewAdminProcess.interview.schedule.setting.timeSlot.t_start = new Date(start);
    $scope.interviewAdminProcess.interview.schedule.setting.timeSlot.t_end = new Date(end);
    var start = $scope.interviewAdminProcess.interview.schedule.setting.timeSlot.t_start;
    var end = $scope.interviewAdminProcess.interview.schedule.setting.timeSlot.t_end;

    $scope.interviewAdminProcess.interview.schedule.setting.noEndTimeCss = (start < end)? '' : $scope.inputNotSetCss;
  };


  $scope.interviewAdminProcess.interview.schedule.setting.send = function()
  {
    var timeSlotId = $scope.interviewAdminProcess.interview.schedule.setting.timeSlot.id;
    var place = $scope.interviewAdminProcess.interview.schedule.setting.timeSlot.place;
    var t_start = $scope.interviewAdminProcess.interview.schedule.setting.timeSlot.t_start;
    var t_end = $scope.interviewAdminProcess.interview.schedule.setting.timeSlot.t_end;
    var isSend = true;

    if (!(t_start < t_end))
    {
      $scope.interviewAdminProcess.interview.schedule.setting.noEndTimeCss = $scope.inputNotSetCss;
      isSend = false;
    }

    if (isSend)
    {
      var postData = {
        place: place,
        t_start: t_start,
        t_end: t_end,
        "current_year_id": $rootScope.current_year.id,
        "current_process_id": $rootScope.current_process.id
      };

      waitingIcon.open();
      timeSlotFactory.timeSlotUpdate(postData, timeSlotId)
      .success(function (data, status, headers, config) {
        $scope.eCode = data.eCode;

        if (data.msg)
        {
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        else
        {
          switch ($scope.eCode)
          {
            case 'xSYS00000':
              $scope.interviewAdminProcess.flow = 2080;
              break;
            default:
              $scope.interviewAdminProcess.flow = 2090;
          }
        }

        $scope.interviewAdminProcess.refreshAll();
        waitingIcon.close();
      })
      .error(function (data, status, headers, config) {
        $scope.interviewAdminProcess.flow = 2090;
        waitingIcon.close();
      });
    }
  };

  $scope.interviewAdminProcess.interview.schedule.interviewer.init = function(timeSlot)
  {
    $scope.interviewAdminProcess.flow = 2100;
    $scope.interviewAdminProcess.interview.schedule.interviewer.interviewers = [];
    //$scope.interviewAdminProcess.interview.schedule.interviewer.selectAll = false;
    $scope.interviewAdminProcess.interview.schedule.interviewer.clear();
    $scope.interviewAdminProcess.interview.schedule.interviewer.timeSlot = angular.copy(timeSlot);
    $scope.interviewAdminProcess.interview.schedule.interviewer.getInterviewers($scope.interviewAdminProcess.interview.schedule.interviewer.timeSlot.id);
    $scope.interviewAdminProcess.interview.schedule.interviewer.isVacancyFull = false;
    $("#interviewAdminProcessInterviewScheduleInterviewerForm").modal('toggle');
  };

  $scope.interviewAdminProcess.interview.schedule.interviewer.checkSelectAll = function()
  {
    var interviewers = $scope.interviewAdminProcess.interview.schedule.interviewer.interviewers;

    $scope.interviewAdminProcess.interview.schedule.interviewer.selectAll = true;
    for (var i = 0; i < interviewers.length; i++)
    {
      if (!interviewers[i].check)
      {
        $scope.interviewAdminProcess.interview.schedule.interviewer.selectAll = false;
        break;
      }
    }
  };

  $scope.interviewAdminProcess.interview.schedule.interviewer.clear = function()
  {
    $scope.interviewAdminProcess.interview.schedule.interviewer.add = [];
    $scope.interviewAdminProcess.interview.schedule.interviewer.remove = [];
  };

  $scope.interviewAdminProcess.interview.schedule.interviewer.getInterviewers = function(timeSlotId)
  {
    waitingIcon.open();
    timeSlotFactory.getInterviewers(timeSlotId, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function (data, status, headers, config) {
      $scope.interviewAdminProcess.interview.schedule.interviewer.interviewers = data;
      $scope.interviewAdminProcess.interview.schedule.interviewer.checkSelectAll();
      $scope.interviewAdminProcess.interview.schedule.interviewer.checkInterviewerVacancy();
      waitingIcon.close();
    })
    .error(function (data, status, headers, config) {
      waitingIcon.close();
    });
  };

  $scope.interviewAdminProcess.interview.schedule.interviewer.checkboxChange = function(interviewer)
  {
    if (interviewer.check)
    {
      $scope.interviewAdminProcess.interview.schedule.interviewer.add['key' + interviewer.id] = interviewer;
      delete ($scope.interviewAdminProcess.interview.schedule.interviewer.remove['key' + interviewer.id]);
    }
    else
    {
      delete ($scope.interviewAdminProcess.interview.schedule.interviewer.add['key' + interviewer.id]);
      $scope.interviewAdminProcess.interview.schedule.interviewer.remove['key'+ interviewer.id] = interviewer;
    }

    $scope.interviewAdminProcess.interview.schedule.interviewer.checkSelectAll();
    $scope.interviewAdminProcess.interview.schedule.interviewer.checkInterviewerVacancy();
  };

  $scope.interviewAdminProcess.interview.schedule.interviewer.checkInterviewerVacancy = function()
  {
    var interviewers = $scope.interviewAdminProcess.interview.schedule.interviewer.interviewers;
    var interview_vacancy = $scope.interviewAdminProcess.interview.schedule.interview.interviewer_vacancy;
    var countHasCheck = 0;

    for (var i = 0; i < interviewers.length; i++)
    {
      if (interviewers[i].check)
      {
        countHasCheck++;
      }
    }

    $scope.interviewAdminProcess.interview.schedule.interviewer.isVacancyFull = (countHasCheck < interview_vacancy)? false : true;
  };

  $scope.interviewAdminProcess.interview.schedule.interviewer.selectAllChange = function()
  {
    var interviewers = $scope.interviewAdminProcess.interview.schedule.interviewer.interviewers;
    if ($scope.interviewAdminProcess.interview.schedule.interviewer.selectAll)
    {
      for (var i = 0; i < interviewers.length; i++)
      {
        interviewers[i].check = true;
        $scope.interviewAdminProcess.interview.schedule.interviewer.add['key' + interviewers[i].id] = interviewers[i];
        delete ($scope.interviewAdminProcess.interview.schedule.interviewer.remove['key' + interviewers[i].id]);
      }
    }
    else
    {
      for (var i = 0; i < interviewers.length; i++)
      {
        interviewers[i].check = false;
        delete ($scope.interviewAdminProcess.interview.schedule.interviewer.add['key' + interviewers[i].id]);
        $scope.interviewAdminProcess.interview.schedule.interviewer.remove['key'+ interviewers[i].id] = interviewers[i];
      }
    }
  };

  $scope.interviewAdminProcess.interview.schedule.interviewer.send = function()
  {
    var interviewerIdAdd = [];
    for (var interviewer in $scope.interviewAdminProcess.interview.schedule.interviewer.add)
    {
      interviewerIdAdd.push($scope.interviewAdminProcess.interview.schedule.interviewer.add[interviewer].interviewers[0].id);
    }
    var interviewerIdRemove = [];

    for (var interviewer in $scope.interviewAdminProcess.interview.schedule.interviewer.remove)
    {
      interviewerIdRemove.push($scope.interviewAdminProcess.interview.schedule.interviewer.remove[interviewer].interviewers[0].id);
    }

    var postData = {
      timeSlotId: $scope.interviewAdminProcess.interview.schedule.interviewer.timeSlot.id,
      interviewerAdd: (interviewerIdAdd.length == 0 ? null : interviewerIdAdd),
      interviewerRemove: (interviewerIdRemove.length == 0 ? null : interviewerIdRemove),
      "current_year_id": $rootScope.current_year.id,
      "current_process_id": $rootScope.current_process.id
    };

    waitingIcon.open();
    timeSlotFactory.setInterviewers(postData)
    .success(function (data, status, headers, config) {
      if (data.msg)
      {
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      else
      {
        if (data.success)
        {
          $scope.interviewAdminProcess.flow = 2180;
        }
        else
        {
          $scope.interviewAdminProcess.interview.schedule.interviewer.notSetInterviewerUsers = data.not_set_interviewer_users;
          $scope.interviewAdminProcess.flow = 2190;
        }
      }

      $scope.interviewAdminProcess.refreshAll();
      $scope.interviewAdminProcess.interview.schedule.interviewer.clear();
      waitingIcon.close();
    })
    .error(function (data, status, headers, config) {
      $scope.interviewAdminProcess.flow = 2190;
      $scope.interviewAdminProcess.interview.schedule.interviewer.clear();
      waitingIcon.close();
    });
  };

  $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.init = function(timeSlot)
  {
    $scope.interviewAdminProcess.flow = 2200;
    $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.noAllMessage = '';
    $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.applicants = [];
    $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.selectAll = false;
    $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.clear();
    $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.notSetIntervieweeUsers = [];

    $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.timeSlot = angular.copy(timeSlot);
    $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.getApplicantList($scope.interviewAdminProcess.interview.schedule.scheduleApplicant.timeSlot.id);
    $("#interviewAdminProcessInterviewScheduleApplicantForm").modal('toggle');
  };

  $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.clear = function()
  {
    $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.add = [];
    $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.remove = [];
  };

  $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.checkSelectAll = function()
  {
    var applicants = $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.applicants;

    $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.selectAll = true;
    for (var i = 0; i < applicants.length; i++)
    {
      if (!applicants[i].check)
      {
        $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.selectAll = false;
        break;
      }
    }
  };

  $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.checkApplicantVacancy = function()
  {
    var applicants = $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.applicants;
    var vacancy = $scope.interviewAdminProcess.interview.schedule.interview.vacancy;
    var countHasCheck = 0;

    for (var i = 0; i < applicants.length; i++)
    {
      if (applicants[i].check)
      {
        countHasCheck++;
      }
    }

    $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.isVacancyFull = (countHasCheck < vacancy)? false : true;
  };


  $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.selectAllChange = function(b_interviewer_can_schedule)
  {
    var interviewVacancy = $scope.interviewAdminProcess.interview.schedule.interview.vacancy;
    var countInterviewApplicants = $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.applicants.length;

    if (interviewVacancy < countInterviewApplicants && b_interviewer_can_schedule)
    {
      //$rootScope.rsasAlert({msg: 'The number of vacancy is only ' + interviewVacancy + ' .'});

      $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.noAllMessage = "Warning: Number of scheduled applicants can not be more than vacancy's limitation.";
      $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.selectAll = false;
    }
    else
    {
      var applicants = $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.applicants;
      if ($scope.interviewAdminProcess.interview.schedule.scheduleApplicant.selectAll)
      {
        for (var i = 0; i < applicants.length; i++)
        {
          applicants[i].check = true;
          $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.add['key' + applicants[i].id] = applicants[i];
          delete ($scope.interviewAdminProcess.interview.schedule.scheduleApplicant.remove['key' + applicants[i].id]);
        }
      }
      else
      {
        for (var i = 0; i < applicants.length; i++)
        {
          applicants[i].check = false;
          delete ($scope.interviewAdminProcess.interview.schedule.scheduleApplicant.add['key' + applicants[i].id]);
          $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.remove['key' + applicants[i].id] = applicants[i];
        }
      }
    }
  };

  $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.checkboxChange = function(applicant)
  {
    if (applicant.check)
    {
      $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.add['key' + applicant.id] = applicant;
      delete ($scope.interviewAdminProcess.interview.schedule.scheduleApplicant.remove['key' + applicant.id]);
    }
    else
    {
      delete ($scope.interviewAdminProcess.interview.schedule.scheduleApplicant.add['key' + applicant.id]);
      $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.remove['key'+ applicant.id] = applicant;
    }
    $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.checkSelectAll();
    $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.checkApplicantVacancy();
  };

  $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.getApplicantList = function(timeSlotId)
  {
    waitingIcon.open();
    timeSlotFactory.getApplicantList(timeSlotId, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function (data, status, headers, config) {
      $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.applicants = data.applicant_list;
      $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.checkSelectAll();
      $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.checkApplicantVacancy();
      waitingIcon.close();
    })
    .error(function (data, status, headers, config) {
      waitingIcon.close();
    });
  };

  $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.send = function()
  {
    var applicantIdAdd = [];
    for (var user in $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.add)
    {
      applicantIdAdd.push($scope.interviewAdminProcess.interview.schedule.scheduleApplicant.add[user].id);
    }
    var applicantIdRemove = [];

    for (var user in $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.remove)
    {
      applicantIdRemove.push($scope.interviewAdminProcess.interview.schedule.scheduleApplicant.remove[user].id);
    }

    var postData = {
      timeSlotId: $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.timeSlot.id,
      applicantIdAdd: (applicantIdAdd.length == 0 ? null : applicantIdAdd),
      applicantIdRemove: (applicantIdRemove.length == 0 ? null : applicantIdRemove),
      "current_year_id": $rootScope.current_year.id,
      "current_process_id": $rootScope.current_process.id,
      invited_email_subject: $scope.schedule_invited_email.subject,
      invited_email_content: $scope.schedule_invited_email.content,
      canceled_email_subject: $scope.schedule_canceled_email.subject,
      canceled_email_content: $scope.schedule_canceled_email.content
    };

    waitingIcon.open();
    timeSlotFactory.setInterviewees(postData)
    .success(function (data, status, headers, config) {
      if (data.msg)
      {
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      else
      {
        if (data.success)
        {
          $scope.interviewAdminProcess.flow = 2280;
        }
        else
        {
          $scope.interviewAdminProcess.flow = 2290;
          $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.notSetIntervieweeUsers = data.not_set_interviewee_users;
        }
      }

      $scope.interviewAdminProcess.refreshAll();
      $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.clear();
      waitingIcon.close();
    })
    .error(function (data, status, headers, config) {
      $scope.interviewAdminProcess.flow = 2290;
      $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.clear();
      waitingIcon.close();
    });
  };

  $scope.interviewAdminProcess.applicantList.refleshInterviewSelect = function(roundId)
  {
    $scope.interviewAdminProcess.applicantList.applicants = [];
    var selectedInterviewId = ($scope.interviewAdminProcess.applicantList.interviewSelect)? $scope.interviewAdminProcess.applicantList.interviewSelect.id : 0;

    waitingIcon.open();
    interviewFactory.getRoundAdminSelectedInterviews(roundId, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function (data, status, headers, config) {
      waitingIcon.close();

      var round = data[0];
      if (round && round.id == roundId)
      {
        $scope.interviewAdminProcess.applicantList.round = round;

        if(0 < $scope.interviewAdminProcess.applicantList.round.interviews.length)
        {
          if (0 < selectedInterviewId)
          {
            for (var i = 0; i < $scope.interviewAdminProcess.applicantList.round.interviews.length; i++)
            {
              var interview = $scope.interviewAdminProcess.applicantList.round.interviews[i];
              if (interview.id == selectedInterviewId)
              {
                $scope.interviewAdminProcess.applicantList.interviewSelect = interview;
                break;
              }
            }
          }
          else
          {
            $scope.interviewAdminProcess.applicantList.interviewSelect = $scope.interviewAdminProcess.applicantList.round.interviews[0];
          }
          $scope.interviewAdminProcess.applicantList.init();
        }
      }

      if (!$scope.interviewAdminProcess.applicantList.tblHasInit)
      {
        $scope.interviewAdminProcess.applicantList.tbl.init($scope, $scope.interviewAdminProcess.applicantList.tbl, false);
        $scope.interviewAdminProcess.applicantList.tblHasInit = true;
      }
    })
    .error(function (data, status, headers, config) {
      waitingIcon.close();
    });
  };

  $scope.interviewAdminProcess.applicantList.getInterviewApplicantList = function(interviewId)
  {
    waitingIcon.open();
    interviewFactory.getInterviewApplicantList(interviewId, $rootScope.current_year.id, $rootScope.current_process.id, $rootScope.current_user.status)
    .success(function (data, status, headers, config) {
      $scope.interviewAdminProcess.applicantList.applicants = data.applicant_list;
      waitingIcon.close();
    })
    .error(function (data, status, headers, config) {
      waitingIcon.close();
    });
  };

  $scope.interviewAdminProcess.applicantList.init = function()
  {
    $scope.interviewAdminProcess.applicantList.radioApplicantType = 1;
    $scope.interviewAdminProcess.applicantList.applicants = [];
    $scope.interviewAdminProcess.applicantList.interview = angular.copy($scope.interviewAdminProcess.applicantList.interviewSelect);
    var interviewId = $scope.interviewAdminProcess.applicantList.interview.id;

    $scope.interviewAdminProcess.applicantList.refresh();
  };

  $scope.interviewAdminProcess.applicantList.radioApplicantTypeClick = function(type)
  {
    $scope.interviewAdminProcess.applicantList.radioApplicantType = type;
    $scope.interviewAdminProcess.applicantList.tbl.goPage = 1;
    $scope.interviewAdminProcess.applicantList.refresh();
  };

  $scope.interviewAdminProcess.applicantList.refresh = function()
  {
    $scope.interviewAdminProcess.applicantList.tbl.setDataAndRequest();
  };

  $scope.interviewAdminProcess.applicantList.email.init = function(applicant)
  {
    $scope.interviewAdminProcess.applicantList.email.applicant = angular.copy(applicant);
    var user = $scope.interviewAdminProcess.applicantList.email.applicant;

    $("#interviewAdminProcessEmail").modal('toggle');
    $scope.email.init();
    $scope.rsas_email.recipients.push({name: user.name, email: user.email});
  };

  $scope.interviewAdminProcess.applicantList.email.send = function()
  {
    $scope.email.sendEmailToApplicants();
  };

  $scope.interviewAdminProcess.applicantList.emailScheduled.click = function()
  {
    $scope.email.sendType = 'interviewSceduledApplicant';
    $scope.interviewAdminProcess.applicantList.emailScheduled.init();
  };

  $scope.interviewAdminProcess.applicantList.emailScheduled.init = function()
  {
    interview = $scope.interviewAdminProcess.applicantList.interviewSelect;
    var interviewId = interview.id;

    $("#interviewAdminProcessEmail").modal('toggle');
    $scope.email.init();
    $scope.interviewAdminProcess.getInterviewScheduledApplicants(interviewId, $scope.rsas_email.recipients);
  };

  $scope.interviewAdminProcess.applicantList.emailScheduled.send = function()
  {
    $scope.email.sendEmailToApplicants();
  };

  $scope.interviewAdminProcess.applicantList.emailAllApplicant.click = function()
  {
    $scope.email.sendType = 'interviewAllApplicant';
    $scope.interviewAdminProcess.applicantList.emailAllApplicant.init();
  };

  $scope.interviewAdminProcess.applicantList.emailAllApplicant.init = function()
  {
    interview = $scope.interviewAdminProcess.applicantList.interviewSelect;
    var interviewId = interview.id;

    $("#interviewAdminProcessEmail").modal('toggle');
    $scope.email.init();
    $scope.interviewAdminProcess.getInterviewSelectApplicants(interviewId, $scope.rsas_email.recipients);
  };

  $scope.interviewAdminProcess.applicantList.emailAllApplicant.send = function()
  {
    $scope.email.sendEmailToApplicants();
  };


  $scope.interviewAdminProcess.applicantList.evaluate.init = function(applicant)
  {
    $scope.interviewAdminProcess.applicantList.evaluate.forms = [];
    $scope.interviewAdminProcess.applicantList.evaluate.applicant = angular.copy(applicant);
    var applicant = $scope.interviewAdminProcess.applicantList.evaluate.applicant;
    $("#interviewAdminProcessInterviewApplicantEvaluate").modal('toggle');
    $scope.interviewAdminProcess.applicantList.evaluate.getEvaluateForms(applicant);
  };

  $scope.set_uploader = function(form_id) {

    var uploader = $scope.uploader =
      new FileUploader({
        url: '/files/upload',
        autoUpload: true,
        removeAfterUpload: true,
      });

    $scope.uploader.formData.push({
      "interview_form_id": form_id
    });

    // FILTERS

    uploader.filters.push({
        name: 'fileExtensionFilter',
        fn: function(item /*{File|FileLikeObject}*/, options) {
            var type = '|' + item.type.slice(item.type.lastIndexOf('/') + 1) + '|';
            return '|pdf|doc|xls|jpg|jpeg|bmp|tif|png|gif|bmp|vnd.openxmlformats-officedocument.wordprocessingml.document|vnd.openxmlformats-officedocument.spreadsheetml.sheet|'.indexOf(type) !== -1;
        }
    });

    // CALLBACKS

    uploader.onWhenAddingFileFailed = function(item /*{File|FileLikeObject}*/, filter, options) {
      console.info('onWhenAddingFileFailed', item, filter, options);
    };
    uploader.onAfterAddingFile = function(fileItem) {
      console.info('onAfterAddingFile', fileItem);
    };
    uploader.onAfterAddingAll = function(addedFileItems) {
      console.info('onAfterAddingAll', addedFileItems);
    };
    uploader.onBeforeUploadItem = function(item) {
      console.info('onBeforeUploadItem', item);
    };
    uploader.onProgressItem = function(fileItem, progress) {
      console.info('onProgressItem', fileItem, progress);
    };
    uploader.onProgressAll = function(progress) {
      console.info('onProgressAll', progress);
    };
    uploader.onSuccessItem = function(fileItem, response, status, headers) {
      console.info('onSuccessItem', fileItem, response, status, headers);
    };
    uploader.onErrorItem = function(fileItem, response, status, headers) {
      console.info('onErrorItem', fileItem, response, status, headers);
    };
    uploader.onCancelItem = function(fileItem, response, status, headers) {
      console.info('onCancelItem', fileItem, response, status, headers);
    };
    uploader.onCompleteItem = function(fileItem, response, status, headers) {
      console.info('onCompleteItem', fileItem, response, status, headers);
    };
    uploader.onCompleteAll = function() {
      console.info('onCompleteAll');
      $scope.interviewAdminProcess.applicantList.evaluate.get_form_file(form_id);
    };

    console.info('uploader', uploader);

    return uploader;
  };

  $scope.delete_file = function(form, file_id, index){
    if($window.confirm("Are you sure?")){
      fileFactory.deleteFile(file_id, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function (data) {
        if(data.success){
          form.upload_files.splice(index, 1);
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: "Failed to delete the file."});
        }
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to delete the file."});
      });
    };
  };

  $scope.interviewAdminProcess.applicantList.evaluate.get_form_file = function(form_id) {
    fileFactory.getFileList(form_id, "Interview", $rootScope.current_year.id, $rootScope.current_process.id).success(function (data) {
      if(data.success){
        angular.forEach($scope.interviewAdminProcess.applicantList.evaluate.forms, function(form){
          if(form.id == form_id){
            form.upload_files = data.files;
          }
        });
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the file list."});
      }
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the file list."});
    });
  };

  $scope.interviewAdminProcess.applicantList.evaluate.getEvaluateForms = function(applicant)
  {
    var applicantUserId = applicant.id;
    //var timeSlotId = $scope.interviewAdminProcess.applicantList.timeSlot.id;
    var interviewId = $scope.interviewAdminProcess.applicantList.interview.id;

    waitingIcon.open();
    interviewEvaluateFactory.getEvaluateForms($rootScope.current_year.id, $rootScope.current_process.id, applicantUserId, interviewId)
    .success(function (data){
      var forms = data.forms;
      $scope.permission_to_active = data.permission_to_active;

      angular.forEach(forms, function(form){
        form.schema = eval(form.schema);
        $scope.interviewAdminProcess.applicantList.evaluate.get_form_file(form.id);
      });
      $scope.interviewAdminProcess.applicantList.evaluate.forms = forms;

      waitingIcon.close();
    })
    .error(function (data){
      console.log("get interview evaluate form Error");
      waitingIcon.close();
    });
  };

  $scope.interviewAdminProcess.applicantList.evaluate.updateEvaluateForm = function()
  {
    var evaluateForms = $scope.interviewAdminProcess.applicantList.evaluate.forms;

    for (var i = 0; i < evaluateForms.length; i++)
    {
      var evaluateForm = evaluateForms[i];
      interview_evaluate_form = {"id": evaluateForm.id, "schema": JSON.stringify(evaluateForm.schema)};

      waitingIcon.open();
      interviewEvaluateFactory.saveEvaluateForm(interview_evaluate_form, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function (data){
        if(data.success){
          //console.log("save interview evaluate form success");
        }
        else{
          //console.log("save interview evaluate form fail");
        };

        $("#interviewAdminProcessInterviewApplicantEvaluate").modal('toggle');
        waitingIcon.close();
      })
      .error(function (data){
        console.log("save interview evaluate form Error");
        $("#interviewAdminProcessInterviewApplicantEvaluate").modal('toggle');
        waitingIcon.close();
      });
    }
  };

  $scope.interviewAdminProcess.applicantList.review.init = function(applicant)
  {
    $scope.interviewAdminProcess.applicantList.review.forms = [];
    $scope.interviewAdminProcess.applicantList.review.applicant = angular.copy(applicant);
    var applicant = $scope.interviewAdminProcess.applicantList.review.applicant;
    $("#interviewAdminProcessInterviewApplicantReview").modal('toggle');
    $scope.interviewAdminProcess.applicantList.review.getReviewForms(applicant);
  };

  $scope.interviewAdminProcess.applicantList.review.getReviewForms = function(applicant)
  {
    var applicantUserId = applicant.id;
    //var timeSlotId = $scope.interviewAdminProcess.applicantList.timeSlot.id;
    var interviewId = $scope.interviewAdminProcess.applicantList.interview.id;

    waitingIcon.open();
    interviewEvaluateFactory.getReviewForms($rootScope.current_year.id, $rootScope.current_process.id, applicantUserId, interviewId)
    .success(function (data){
      var forms = data.forms;

      angular.forEach(forms, function(form){
        form.schema = eval(form.schema);
      });
      $scope.interviewAdminProcess.applicantList.review.forms = forms;

      waitingIcon.close();
    })
    .error(function (data){
      console.log("get interview review form Error");
      waitingIcon.close();
    });
  };

  $scope.interviewAdminProcess.applicantList.comment.init = function(applicant)
  {
    $scope.interviewAdminProcess.applicantList.comment.applicant = angular.copy(applicant);
  };

  $scope.interviewAdminProcess.applicantList.application.form.init = function()
  {
    $scope.interviewAdminProcess.applicantList.application.form.forms = [];
  };

  $scope.interviewAdminProcess.applicantList.application.form.userFormShow = function(form)
  {
    $scope.interviewAdminProcess.applicantList.application.form.init();

    waitingIcon.open();
    userFormFactory.showUserFilledForm(form.id)
    .success(function (data){
      if (data.success)
      {
        data.form.schema = eval(data.form.schema);
        $scope.interviewAdminProcess.applicantList.application.form.forms[0] = data.form;
      }
      waitingIcon.close();
    })
    .error(function (data){
      waitingIcon.close();
    });
  };

  $scope.interviewAdminProcess.applicantList.application.form.recommendationFormShow = function(form)
  {
    $scope.interviewAdminProcess.applicantList.application.form.init();

    waitingIcon.open();
    recommendationFormFactory.showRecommendationForm(form.id)
    .success(function (data){
      if (data.success)
      {
        data.form.schema = eval(data.form.schema);
        $scope.interviewAdminProcess.applicantList.application.form.forms[0] = data.form;
      }
      waitingIcon.close();
    })
    .error(function (data){
      waitingIcon.close();
    });
  };

  $scope.interviewAdminProcess.applicantList.application.form.transcriptFormShow = function(user_id)
  {
    waitingIcon.open();
    transcriptFactory.showApplicantTranscripts(user_id, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function (data){
      if(data.success){
        waitingIcon.close();
        $scope.grades = data.grades;
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the user transcripts."});
      };
    })
    .error(function (data){
      $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the user transcripts."});
      waitingIcon.close();
    });
  };

  $scope.interviewAdminProcess.applicantList.tags.init = function(applicant){
    waitingIcon.open();
    $scope.interviewAdminProcess.applicantList.tags.edit_applicant = applicant;
    $scope.interviewAdminProcess.applicantList.tags.tag_list = [];
    $("#interviewAdminProcessInterviewApplicantTag").modal('show');
    applicantTagFactory.getApplicantTags(applicant.id, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success){
        $scope.interviewAdminProcess.applicantList.tags.tag_list = data.tags;
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: "Get applicant tag list error."});
      waitingIcon.close();
    });
  };

  $scope.interviewAdminProcess.applicantList.tags.updateTags = function(){
    waitingIcon.open();
    var user_id = $scope.interviewAdminProcess.applicantList.tags.edit_applicant.id;
    var tags = $scope.interviewAdminProcess.applicantList.tags.tag_list;
    applicantTagFactory.updateApplicantTags(user_id, tags, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success){
        $rootScope.rsasAlert({type: 'success', msg: data.msg});
        $("#interviewAdminProcessInterviewApplicantTag").modal('hide');
        $scope.interviewAdminProcess.applicantList.init();
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: "Update applicant tags error."});
      waitingIcon.close();
    });
  };

  $scope.interviewAdminProcess.interview.dropdownClick.setting = function(interview)
  {
    $scope.interviewAdminProcess.interview.edit.init(interview);
  };

  $scope.interviewAdminProcess.interview.dropdownClick.remove = function(interview)
  {
    $scope.interviewAdminProcess.interview.remove.init(interview);
  };

  $scope.interviewAdminProcess.interview.dropdownClick.interviewer = function(interview)
  {
    $scope.interviewAdminProcess.interview.interviewer.init(interview);
  };

  $scope.interviewAdminProcess.interview.dropdownClick.selectApplicant = function(interview)
  {
    $scope.interviewAdminProcess.interview.selectApplicant.init(interview);
  };

  $scope.interviewAdminProcess.interview.dropdownClick.sendInviteEmailApplicant = function(interview)
  {
    $scope.interviewAdminProcess.interview.sendInviteEmailToApplicant.init(interview);
  };

  $scope.interviewAdminProcess.interview.dropdownClick.timeSlot = function(interview)
  {
    $scope.interviewAdminProcess.interview.timeSlot.init(interview);
  };


  $scope.interviewAdminProcess.interview.dropdownClick.position = function(interview)
  {
    $scope.interviewAdminProcess.interview.position.init(interview);
  };

  $scope.interviewAdminProcess.interview.dropdownClick.schedule = function(interview)
  {
    $scope.interviewAdminProcess.interview.schedule.init(interview);
    $scope.interviewAdminProcess.applicantList.timeSlot = '';

    $scope.interviewAdminProcess.scrollTo('#interviewAdminProcessInterviewScheduleList');
  };

  $scope.interviewAdminProcess.interview.scheduleDropdownClick.setting = function(timeSlot)
  {
    $scope.interviewAdminProcess.interview.schedule.setting.init(timeSlot);
  };

  $scope.interviewAdminProcess.interview.scheduleDropdownClick.scheduleInterviewer = function(timeSlot)
  {
    $scope.interviewAdminProcess.interview.schedule.interviewer.init(timeSlot);
  };

  $scope.interviewAdminProcess.interview.scheduleDropdownClick.scheduleApplicant = function(timeSlot)
  {
    $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.init(timeSlot);
  };

  $scope.interviewAdminProcess.applicantListDropdownClick.email = function(applicant)
  {
    $scope.email.sendType = 'toApplicant';
    $scope.interviewAdminProcess.applicantList.email.init(applicant);
  };

  $scope.interviewAdminProcess.applicantListDropdownClick.evaluate = function(applicant)
  {
    $scope.interviewAdminProcess.applicantList.evaluate.init(applicant);
  };

  $scope.interviewAdminProcess.applicantListDropdownClick.review = function(applicant)
  {
    $scope.interviewAdminProcess.applicantList.review.init(applicant);
  };

  $scope.interviewAdminProcess.applicantListDropdownClick.tags = function(applicant)
  {
    $scope.interviewAdminProcess.applicantList.tags.init(applicant);
  };

  $scope.interviewAdminProcess.myInterview.timeSlot.refresh = function()
  {
    $scope.interviewAdminProcess.myInterview.tbl.setDataAndRequest();
  };

  $scope.interviewAdminProcess.myInterview.timeSlot.change = function(time_slot, interviewers)
  {
    if (1 == interviewers.length)
    {
      var timeSlotId = time_slot.id;
      var interviewerId = interviewers[0].id;

      if (time_slot.check)
      {
        // sign up
        $scope.interviewAdminProcess.myInterview.timeSlot.signup(timeSlotId, interviewerId);
      }
      else
      {
        // cancel
        $scope.interviewAdminProcess.myInterview.timeSlot.cancel(time_slot, interviewerId);
      }
    }
  };

  $scope.interviewAdminProcess.myInterview.timeSlot.click = function(timeSlot, interviewer)
  {
    $scope.interviewAdminProcess.myInterview.timeSlot.timeSlot = timeSlot;
    $scope.interviewAdminProcess.myInterview.timeSlot.interviewer = interviewer;
    if (timeSlot.check)
    {
      // do cancel
      $("#interviewAdminProcessMyInterviewCancelForm").modal('toggle');
    }
    else
    {
      // do sign up
      $("#interviewAdminProcessMyInterviewSignUpForm").modal('toggle');
    }
  };

  $scope.interviewAdminProcess.myInterview.timeSlot.signup = function(timeSlotId, interviewerId)
  {
    var postData = {
      timeSlotId: timeSlotId,
      interviewerId: interviewerId,
      "current_year_id": $rootScope.current_year.id,
      "current_process_id": $rootScope.current_process.id
    };

    waitingIcon.open();
    timeSlotInterviewerFactory.signup(postData)
    .success(function (data, status, headers, config) {
      $scope.interviewAdminProcess.myInterview.timeSlot.refresh();
      $scope.interviewAdminProcess.calendar.calendarRefresh();

      if (data.message)
      {
        $rootScope.rsasAlert({type: 'danger', msg: data.message});
      }

      $("#interviewAdminProcessMyInterviewSignUpForm").modal('hide');
      waitingIcon.close();
    })
    .error(function (data, status, headers, config) {
      waitingIcon.close();
    });
  };

  $scope.interviewAdminProcess.myInterview.timeSlot.cancel = function(time_slot, interviewerId)
  {
    var interviewerId = interviewerId;
    var timeSlotInterviewerId = 0;
    for (var i = 0; i < time_slot.time_slot_interviewers.length; i++)
    {
      var timeSlotInterviewer = time_slot.time_slot_interviewers[i];
      if (timeSlotInterviewer.interviewer_id == interviewerId)
      {
        timeSlotInterviewerId = timeSlotInterviewer.id;
      }
    }

    waitingIcon.open();
    timeSlotInterviewerFactory.cancel(timeSlotInterviewerId, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function (data, status, headers, config) {
      $scope.interviewAdminProcess.myInterview.timeSlot.refresh();
      $scope.interviewAdminProcess.calendar.calendarRefresh();
      $("#interviewAdminProcessMyInterviewCancelForm").modal('hide');
      waitingIcon.close();
    })
    .error(function (data, status, headers, config) {
      waitingIcon.close();
    });
  };

  $scope.interviewAdminProcess.myInterview.timeSlot.isOvertime = function(dt)
  {
    var now = new Date();
    var timeSlotEnd = transDateTimeAtZoneUTCToSub8ExistClientZone(new Date(dt));
    return (now > timeSlotEnd);
  };


  $scope.interviewAdminProcess.myInterview.email.init = function(interview)
  {
    $scope.interviewAdminProcess.myInterview.email.interview = angular.copy(interview);
    var interviewId = interview.id;

    $("#interviewAdminProcessEmail").modal('toggle');
    $scope.email.init();
    $scope.interviewAdminProcess.getInterviewScheduledApplicants(interviewId, $scope.rsas_email.recipients);
  };

  $scope.interviewAdminProcess.myInterview.email.send = function()
  {
    $scope.email.sendEmailToApplicants();
  };


  $scope.interviewAdminProcess.myInterview.dropdownClick.email = function(interview)
  {
    $scope.email.sendType = 'myInterview';
    $scope.interviewAdminProcess.myInterview.email.init(interview);
  };


  $scope.interviewAdminProcess.checkFlow = function(now)
  {
    var eCode = 'xSYS00000';
    switch (now)
    {
      case 0:
        eCode = 'xIAP99999';
        break;
      case 500:
        if (!$scope.interviewAdminProcess.interview.edit.interview.name)
        {
          $scope.interviewAdminProcess.interview.edit.noNameCss = $scope.inputNotSetCss;
          eCode = 'xIAP00006';
        }
        else if (!$scope.interviewAdminProcess.interview.edit.interview.s_schedule_due_time)
        {
          $scope.interviewAdminProcess.interview.edit.noScheduleDueTimeCss = $scope.inputNotSetCss;
          eCode = 'xIAP00009';
        }
        else if (!checkPositiveInteger($scope.interviewAdminProcess.interview.edit.interview.vacancy))
        {
          $scope.interviewAdminProcess.interview.edit.noVacancyCss = $scope.inputNotSetCss;
          eCode = 'xIAP00003';
        }
        else if ($scope.interviewAdminProcess.interview.edit.interview.interviewer_can_schedule)
        {
          if (!checkPositiveInteger($scope.interviewAdminProcess.interview.edit.interview.interviewer_vacancy))
          {
            $scope.interviewAdminProcess.interview.edit.noInterviewerVacancyPerTimeSlotCss = $scope.inputNotSetCss;
            eCode = 'xIAP00007';
          }
          if (!checkPositiveInteger($scope.interviewAdminProcess.interview.edit.interview.max_time_slot_per_interviewer))
          {
            $scope.interviewAdminProcess.interview.edit.noMaxNumTimeSlotPerInterviewerCss = $scope.inputNotSetCss;
            eCode = 'xIAP00008';
          }
        }
        break;
      ///////////////////////////
      case 110:
      case 210:
      case 300:
      case 600:
      case 700:
      case 800:
      case 900:
      case 950:
      case 1000:
      case 2000:
      case 2100:
      case 2200:
        // do nothing
        break;
      default:
        eCode = 'xIAP99999';
    }
    return(eCode);
  };

  $scope.interviewAdminProcess.nextFlow = function(now, next)
  {
    var eCode = $scope.interviewAdminProcess.checkFlow(now);
    if ('xSYS00000' == eCode)
    {
      switch (next)
      {
        case 0:
          break;
        case 310:
          $scope.interviewAdminProcess.interview.create.send();
          break;
        case 510:
          $scope.interviewAdminProcess.interview.edit.send();
          break;
        case 610:
          $scope.interviewAdminProcess.interview.remove.send();
          break;
        case 710:
          $scope.interviewAdminProcess.interview.interviewer.send();
          break;
        case 810:
          $scope.interviewAdminProcess.interview.selectApplicant.send();
          break;
        case 910:
          if ($scope.interviewAdminProcess.interview.timeSlot.isTimeAdding)
          {
            if (confirm("You has not yet added the new time slot.\nPlease hit ''Add a new time to list'' button before saving, or your setting will be not recorded.\nDo you still want to save it without adding any new time slot?"))
            {
              $scope.interviewAdminProcess.interview.timeSlot.send();
            }
          }
          else
          {
            $scope.interviewAdminProcess.interview.timeSlot.send();
          }

          break;
        case 955:
          $scope.interviewAdminProcess.interview.sendInviteEmailToApplicant.send();


          break;
        case 1010:
          $scope.interviewAdminProcess.interview.position.send();
          break;
        case 2010:
          $scope.interviewAdminProcess.interview.schedule.setting.send();
          break;
        case 2110:
          $scope.interviewAdminProcess.interview.schedule.interviewer.send();
          break;
        case 2210:
          $scope.interviewAdminProcess.interview.schedule.scheduleApplicant.send();
          break;

        default:
          eCode = 'xIAP99999';
      }
    }
  };

  angular.element(document).ready(function () {
    if ($rootScope.isRunNowProcess)
    {
      $scope.interviewAdminProcess.setRoundId();
      //$scope.interviewAdminProcess.getProcessPositions($scope.interviewAdminProcess.processId);

      if ($scope.interviewAdminProcess.getRoundSuccess)
      {
        $scope.interviewAdminProcess.getRoundInterviews($scope.interviewAdminProcess.roundId);
        $scope.interviewAdminProcess.getEmailTemplates();
        //$scope.interviewAdminProcess.interview.create.hideDiv();
        $scope.interviewAdminProcess.checkManager();
      }
    }

  });

  $scope.interviewAdminProcess.interview.create.roundSelectOnchange = function()
  {
    $scope.interviewAdminProcess.interview.create.noRoundCss = ($scope.interviewAdminProcess.interview.create.roundSelect)? '' : $scope.inputNotSetCss;
  };

  $scope.interviewAdminProcess.interview.create.nameOnChange = function()
  {
    $scope.interviewAdminProcess.interview.create.noNameCss = ($scope.interviewAdminProcess.interview.create.name)? '' : $scope.inputNotSetCss;
  };

  $scope.interviewAdminProcess.interview.create.scheduleDueTimeOnChange = function()
  {
    $scope.interviewAdminProcess.interview.create.noScheduleDueTimeCss = ($scope.interviewAdminProcess.interview.create.scheduleDueTime)? '' : $scope.inputNotSetCss;
  };

  $scope.interviewAdminProcess.interview.create.vacancyOnChange = function()
  {
     $scope.interviewAdminProcess.interview.create.noVacancyCss = checkPositiveInteger($scope.interviewAdminProcess.interview.create.vacancy)? '' : $scope.inputNotSetCss;
  };

  $scope.interviewAdminProcess.interview.create.placeOnChange = function()
  {
    $scope.interviewAdminProcess.interview.create.noPlaceCss = ($scope.interviewAdminProcess.interview.create.place)? '' : $scope.inputNotSetCss;
  };

  $scope.interviewAdminProcess.interview.create.interviewerVacancyPerTimeSlotOnChange = function()
  {
     $scope.interviewAdminProcess.interview.create.noInterviewerVacancyPerTimeSlotCss = checkPositiveInteger($scope.interviewAdminProcess.interview.create.interviewerVacancyPerTimeSlot)? '' : $scope.inputNotSetCss;
  };

  $scope.interviewAdminProcess.interview.create.maxNumTimeSlotPerInterviewerOnChange = function()
  {
     $scope.interviewAdminProcess.interview.create.noMaxNumTimeSlotPerInterviewerCss = checkPositiveInteger($scope.interviewAdminProcess.interview.create.maxNumTimeSlotPerInterviewer)? '' : $scope.inputNotSetCss;
  };

  $scope.interviewAdminProcess.interview.create.positionSelectOnchange = function()
  {
    $scope.interviewAdminProcess.interview.create.noSelectPositionCss = '';
  };


  $scope.interviewAdminProcess.interview.edit.nameOnChange = function()
  {
    $scope.interviewAdminProcess.interview.edit.noNameCss = ($scope.interviewAdminProcess.interview.edit.interview.name)? '' : $scope.inputNotSetCss;
  };

  $scope.interviewAdminProcess.interview.edit.scheduleDueTimeOnChange = function()
  {
    $scope.interviewAdminProcess.interview.edit.noScheduleDueTimeCss = ($scope.interviewAdminProcess.interview.edit.interview.s_schedule_due_time)? '' : $scope.inputNotSetCss;
  };

  $scope.interviewAdminProcess.interview.edit.vacancyOnChange = function()
  {
     $scope.interviewAdminProcess.interview.edit.noVacancyCss = checkPositiveInteger($scope.interviewAdminProcess.interview.edit.interview.vacancy)? '' : $scope.inputNotSetCss;
  };

  $scope.interviewAdminProcess.interview.edit.interviewerVacancyPerTimeSlotOnChange = function()
  {
     $scope.interviewAdminProcess.interview.edit.noInterviewerVacancyPerTimeSlotCss = checkPositiveInteger($scope.interviewAdminProcess.interview.edit.interview.interviewer_vacancy)? '' : $scope.inputNotSetCss;
  };

  $scope.interviewAdminProcess.interview.edit.maxNumTimeSlotPerInterviewerOnChange = function()
  {
     $scope.interviewAdminProcess.interview.edit.noMaxNumTimeSlotPerInterviewerCss = checkPositiveInteger($scope.interviewAdminProcess.interview.edit.interview.max_time_slot_per_interviewer)? '' : $scope.inputNotSetCss;
  };

  $scope.interviewAdminProcess.interview.timeSlot.placeOnChange = function()
  {
    $scope.interviewAdminProcess.interview.timeSlot.isTimeAdding = true;
    $scope.interviewAdminProcess.interview.timeSlot.noPlaceCss = ($scope.interviewAdminProcess.interview.timeSlot.place)? '' : $scope.inputNotSetCss;
  };

  $scope.interviewAdminProcess.interview.timeSlot.intervalOnChange = function()
  {
    $scope.interviewAdminProcess.interview.timeSlot.isTimeAdding = true;
    $scope.interviewAdminProcess.interview.timeSlot.noIntervalCss = checkPositiveInteger($scope.interviewAdminProcess.interview.timeSlot.timepicker.interval)? '' : $scope.inputNotSetCss;
  };

  $scope.interviewAdminProcess.interview.timeSlot.quantityOnChange = function()
  {
    $scope.interviewAdminProcess.interview.timeSlot.isTimeAdding = true;
    $scope.interviewAdminProcess.interview.timeSlot.noQuantityCss = checkPositiveInteger($scope.interviewAdminProcess.interview.timeSlot.timepicker.quantity)? '' : $scope.inputNotSetCss;
  };

  $scope.interviewAdminProcess.interview.timeSlot.startTimeOnChange = function()
  {
    $scope.interviewAdminProcess.interview.timeSlot.isTimeAdding = true;
  };

  $scope.interviewAdminProcess.interview.schedule.setting.placeOnChange = function()
  {
    $scope.interviewAdminProcess.interview.schedule.setting.noPlaceCss = ($scope.interviewAdminProcess.interview.schedule.setting.timeSlot.place)? '' : $scope.inputNotSetCss;
  };

  $scope.interviewAdminProcess.interview.interviewer.newInterviewer.sunetIdOnChange = function()
  {
    $scope.interviewAdminProcess.interview.interviewer.newInterviewer.noSunetIdCss = ($scope.interviewAdminProcess.interview.interviewer.newInterviewer.sunetId)? '' : $scope.inputNotSetCss;
  };

  $scope.interviewAdminProcess.interview.interviewer.newInterviewer.emailOnChange = function()
  {
    $scope.interviewAdminProcess.interview.interviewer.newInterviewer.noEmailCss = ($scope.interviewAdminProcess.interview.interviewer.newInterviewer.email)? '' : $scope.inputNotSetCss;
  };

  $scope.interviewAdminProcess.interview.interviewer.newInterviewer.firstNameOnChange = function()
  {
    $scope.interviewAdminProcess.interview.interviewer.newInterviewer.noFirstNameCss = ($scope.interviewAdminProcess.interview.interviewer.newInterviewer.firstName)? '' : $scope.inputNotSetCss;
  };

});
/* EOF */
