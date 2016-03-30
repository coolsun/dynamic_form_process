rsasApp.controller('ProcessSteps',function($scope, $sce, $location, $rootScope, $routeParams, processFactory, processStepFactory, processSubStepFactory, waitingIcon, processHelpLandingFactory){
  $scope.current_process_id = $rootScope.current_process.id;
  // main + sub list


  $scope.processSubStepURL = [];
  $scope.url_sn = 0;
  $scope.isNow = true;

  $rootScope.getProcessStep = function(first_get)
  {
    waitingIcon.open();
    processStepFactory.getManagerProcessStep($rootScope.current_year.id, $rootScope.current_process.id, $rootScope.current_user.id).success(function(data){
      if(data.success){
        $scope.permission_to_show = data.permission_to_show;
        tmpList = data.procedure_steps;
        $scope.sort_and_display = data.sort_and_display;
        $scope.process_steps = tmpList;
        if (first_get){
          $scope.setCurrentStepAndSubStep();
        }

        $scope.sortableOptions.disabled = !$scope.sort_and_display;
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});

      }
      waitingIcon.close();
    })
    .error(function(data){
      $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the process steps."});
      waitingIcon.close();
    });
  };

  var tmpList = [];

  $scope.setCurrentStep = function(process_step){
    $rootScope.current_sub_step = null;
    $rootScope.current_step = process_step;
    if(process_step){
      $scope.getStepLanding(process_step.name);
    }
  };

  $scope.landing_switch = function(){
    $scope.landing_edit = false;
  };
  $scope.landing = {};
  $scope.getStepLanding = function(step_name){
    waitingIcon.open();
    processStepFactory.getStepLanding(step_name, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function (data) {
      if(data.success){
        $rootScope.applicant_sub_step = null;
        $scope.landing[step_name] = data.landing;
        $scope.landing_show = $sce.trustAsHtml(data.landing_after); // New content of landing
        $scope.landing_switch();
        if(step_name == "Process"){
          $scope.getHelpLandings();
        }
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the landing page."});
      waitingIcon.close();
    });
  };

  $scope.updateStepLanding = function(step_name){
    waitingIcon.open();
    processStepFactory.updateStepLanding(step_name, $scope.landing[step_name], $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success){
        $scope.landing[step_name] = data.landing;
        $scope.landing_show = $sce.trustAsHtml(data.landing_after); // New content of landing
        $rootScope.rsasAlert({type: 'success', msg: data.msg});
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function(data){
      $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to update the landing page.'});
      waitingIcon.close();
    });
  };

  $scope.checkInTime = function(caller){
    $scope.check_in_time_message = "";
    step = $rootScope.current_step;
    step.is_over_time = false;
    step_start_at = new Date(step.t_start_string);
    step_end_at = new Date(step.t_end_string);
    angular.forEach(step.procedure_sub_steps, function(sub_step){
      sub_step_start_at = new Date(sub_step.t_start_string);
      sub_step_end_at = new Date(sub_step.t_end_string);
      if(step_start_at > sub_step_start_at || sub_step_start_at > step_end_at){
        sub_step.t_start_over_time = true;
        step.is_over_time = true;
        if(caller == "sub_step" && sub_step.t_start_over_time == true){
          $scope.check_in_time_message = "Please adjust the Sub Step Time to be in the range of Step Time in this table.";
        }
      }
      else{
        sub_step.t_start_over_time = false;
      }

      if(step_start_at > sub_step_end_at || sub_step_end_at > step_end_at){
        sub_step.t_end_over_time = true;
        step.is_over_time = true;
        if(caller == "sub_step" && sub_step.t_end_over_time == true){
          $scope.check_in_time_message = "Please adjust the Sub Step Time to be in the range of Step Time in this table.";
        }
      }
      else{
        sub_step.t_end_over_time = false;
      }
    });

    if(caller == "step" && step.is_over_time == true){
      $scope.check_in_time_message = "Please make sure the Step Time range is wider than all the other Sub Step time in this table.";
    }
  };

  $scope.updateSubStepsTime = function(){
    waitingIcon.open();
    step_time = {
      "id" : this.current_step.id,
      "t_start_string" : this.current_step.t_start_string,
      "t_end_string" : this.current_step.t_end_string
    };
    sub_steps_time = [];
    this.current_step.procedure_sub_steps.forEach(function(sub_step){
      sub_steps_time.push({
        "id" : sub_step.id,
        "t_start_string" : sub_step.t_start_string,
        "t_end_string" : sub_step.t_end_string
      });
    });
    processSubStepFactory.updateSubStepsTime(step_time, sub_steps_time, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success){
        $rootScope.rsasAlert({type: 'success', msg: data.msg});
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function(data){
      $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to update the time.'});
      waitingIcon.close();
    });
  };

  $scope.setDatetimepicker = function(){
    $(".setDatetimepicker").datetimepicker({
      dateFormat: "mm/dd/yy",
      closeText: "Close",
      beforeShow: (function(){
        setTimeout(function(){$('.ui-datepicker').css('z-index', 1000);}, 0);
      })
    });
  };

  $scope.sortableOptions = {
    stop: function(e, ui){
      var index = 1;
      var logEntry = tmpList.map(function(process_step){
        if (process_step.rank != index){
          process_step.rank = index;
          data = {"id": process_step.id, "rank": index};
          processStepFactory.updateProcessStep(data, $rootScope.current_year.id, $rootScope.current_process.id)
          .success(function(data){
            if(data.success){
              //$rootScope.rsasAlert({type: 'success', msg: 'Update steps rank Success.'});
            }
            else{
              $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to update steps rank.'});
            }
          })
          .error(function(data){
            $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to update steps rank.'});
          });
        }
        index ++;

        // sub list
        var sub_index = 1;
        process_step.procedure_sub_steps.map(function(sub_step){
          if (sub_step.rank != sub_index){
            sub_step.rank = sub_index;
            data = {"id": sub_step.id, "rank": sub_index};
            processSubStepFactory.updateProcessSubStep(data, $rootScope.current_year.id, $rootScope.current_process.id)
            .success(function(data){
              if(data.success){
                //$rootScope.rsasAlert({type: 'success', msg: 'Update sub_steps rank Success.'});
              }
              else{
                $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to update sub-steps rank.'});
              }
            })
            .error(function(data){
              $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to update sub-steps rank.'});
            });
          }
          sub_index ++;

          return sub_step.name;
        });

        return process_step.name;
      }).join(', ');

    }
  };

  $scope.setCurrentStepEnable = function(process_step){
    data = {"id": process_step.id, "enabled": process_step.enabled};
    processStepFactory.updateProcessStep(data, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success){
        //$rootScope.rsasAlert({type: 'success', msg: 'Update step enabled Success.'});
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to update step enabled.'});
      }
    })
    .error(function(data){
      $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to update step enabled.'});
    });
  };

  $scope.update_sub_step_enabled = function(process_sub_setp){
    data = {"id": process_sub_setp.id, "enabled": process_sub_setp.enabled};
    processSubStepFactory.updateProcessSubStep(data, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success){
        //$rootScope.rsasAlert({type: 'success', msg: 'Update sub_step enabled Success.'});
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to update sub-step enabled.'});
      }
    })
    .error(function(data){
      $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to update sub-step enabled.'});
    });
  };

  $scope.isSubStepEnabled = function(process_step, sub_step){
    return process_step.enabled && sub_step.enabled;
  };

  $scope.setCurrentSubStep = function(step){
    $rootScope.current_step = null;
    $rootScope.current_sub_step = step;
    $scope.url_sn = (new Date()).valueOf();
  };

  $scope.isCurrentStep = function(key, value){
    return $rootScope.current_step && $rootScope.current_step[key] == value;
  };

  $scope.isCurrentSubStep = function(){
    var isShow = true;
    var run_sub_step = '';

    $scope.processSubStepURL = [];

    if ($rootScope.current_sub_step)
    {

      if ($rootScope.current_sub_step.identify_name.match(/^interview\d+$/))
      {
        run_sub_step = "interview";
      }
      else
      {
        run_sub_step = $rootScope.current_sub_step.identify_name;
      }
    }

    switch(run_sub_step)
    {
      case "set_up_positions":
        $scope.processSubStepURL.push("/saas/partials/set_up_positions.html" + "?sn=" + $scope.url_sn);
        break;
      case "set_up_rounds":
        $scope.processSubStepURL.push("/saas/partials/round.html" + "?sn=" + $scope.url_sn);
        break;
      case "rd_flag":
        $scope.processSubStepURL.push("/saas/partials/rd_flag.html" + "?sn=" + $scope.url_sn);
        break;
      case "roles_and_permissions":
        $scope.processSubStepURL.push("/saas/partials/roles_and_permissions.html" + "?sn=" + $scope.url_sn);
        break;
      case "set_up_recommendation_forms":
      case "set_up_system_forms":
      case "set_up_attachable_forms":
      case "set_up_interview_forms":
      case "post_offer_fill_in_form":
        $scope.processSubStepURL.push("/saas/partials/form_builder.html" + "?sn=" + $scope.url_sn);
        break;
      case "set_up_emails":
        $scope.processSubStepURL.push("/saas/partials/email_template_list.html" + "?sn=" + $scope.url_sn);
        break;
      case "system_message":
        $scope.processSubStepURL.push("/saas/partials/system_messages.html" + "?sn=" + $scope.url_sn);
        break;
      case "applicants":
      case "manage_available_applicants":
        $scope.processSubStepURL.push("/saas/partials/manage_applicant.html" + "?sn=" + $scope.url_sn);
        break;
      case "select_position":
        $scope.processSubStepURL.push("/saas/partials/select_positions.html" + "?sn=" + $scope.url_sn);
        break;
      case "recommendation":
        $scope.processSubStepURL.push("/saas/partials/recommendations.html" + "?sn=" + $scope.url_sn);
        break;
      case "interview":
        $scope.processSubStepURL.push("/saas/partials/interview_admin_process.html" + "?sn=" + $scope.url_sn);
        break;
      case "offer":
      case "post_offer_offer":
        $scope.processSubStepURL.push("/saas/partials/offers.html" + "?sn=" + $scope.url_sn);
        break;
      case "ranking":
        $scope.processSubStepURL.push("/saas/partials/ranking.html" + "?sn=" + $scope.url_sn);
        break;
      case "match":
        $scope.processSubStepURL.push("/saas/partials/matching.html" + "?sn=" + $scope.url_sn);
        break;
      case "fill_in_form":
        $scope.processSubStepURL.push("/saas/partials/fill_in_form.html" + "?sn=" + $scope.url_sn);
        break;
      case "post_offer_invitations":
        $scope.processSubStepURL.push("/saas/partials/invitations.html" + "?sn=" + $scope.url_sn);
        break;
      default:
        isShow = false;
    };
    return (isShow);
  };

  $scope.isCurrentSubStepClassShow = function(key, value){
    return $rootScope.current_sub_step && $rootScope.current_sub_step[key] == value;
  };

  $scope.isCurrentStepClassShow = function(key, value){
    return $rootScope.current_step && $rootScope.current_step[key] == value;
  };

  $scope.add_help_landing = function() {
    $scope.wait_add = true;
    processHelpLandingFactory.addHelpLanding($scope.new_help, $scope.current_process_id, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success) {
        $scope.all_help = data.all_help_landings;
        $scope.new_help = { "doings" : "", "department" : "", "contact" : "" };
        $rootScope.rsasAlert({type: 'success', msg: 'Add help landing success.'});
      }
      else {
        $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to add the help landing.'});
      }
      $scope.wait_add = false;
    })
    .error(function(){
      $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to add the help landing.'});
      $scope.wait_add = false;
    });
  };
  $scope.update_help_landing = function(update_help_landing) {
    update_help_landing.wait_update = true;
    processHelpLandingFactory.updateHelpLanding(update_help_landing, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success) {
        angular.extend(update_help_landing, data.updated_help_landing);
        $rootScope.rsasAlert({type: 'success', msg: 'Update help landing success.'});
      }
      else {
        $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to update the help landing.'});
      }
      update_help_landing.wait_update = false;
    })
    .error(function(){
      $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to update the help landing.'});
      update_help_landing.wait_update = false;
    });
  };
  $scope.delete_help_landing = function(delete_help_landing) {
    delete_help_landing.wait_delete = true;
    processHelpLandingFactory.deleteHelpLanding(delete_help_landing.id, $scope.current_process_id, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success) {
        $scope.all_help = data.all_help_landings;
        $rootScope.rsasAlert({type: 'success', msg: 'Delete help landing success.'});
      }
      else {
        $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to delete the help landing.'});
      }
      delete_help_landing.wait_delete = false;
    })
    .error(function(){
      $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to delete the help landing.'});
      delete_help_landing.wait_delete = false;
    });
  };

  $scope.getHelpLandings = function(){
    waitingIcon.open();
    $scope.new_help = { "doings" : "", "department" : "", "contact" : "" };
    $scope.wait_add = false;
    processHelpLandingFactory.getHelpLandings($scope.current_process_id, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success) {
        $scope.all_help = data.all_help_landings;
        $scope.permission_edit_help = data.permission;
      }
      else {
        $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to get the help landings.'});
      }
      waitingIcon.close();
    })
    .error(function(){
      $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to get the help landings.'});
      waitingIcon.close();
    });
  };

  $scope.loadTimepickerAndCheckInTime = function(){
    $scope.setDatetimepicker();
    $scope.checkInTime('default');
  };

  $scope.changeStep = function(step){
    $rootScope.isRunNowProcess = false;
    $rootScope.current_sub_step = null;
    $rootScope.current_step = null;
    $scope.processSubStepURL = [];

    var url = "/" + $routeParams.urlProcessYear + "/" + $routeParams.urlProcessAcronym + "/process_step/" + step.url_acronym;
    $location.path(url);
  };

  $scope.changeSubStep = function(step, sub_step){
    $rootScope.isRunNowProcess = false;
    $rootScope.current_sub_step = null;
    $rootScope.current_step = null;
    $scope.processSubStepURL = [];

    var url = "/" + $routeParams.urlProcessYear + "/" + $routeParams.urlProcessAcronym + "/process_step/" + step.url_acronym + "/" + sub_step.url_acronym;
    $location.path(url);
  };

  $scope.getProcessStepName = function(process_step){
    if(process_step.name == "Offer"){
      return "Placement";
    }
    else{
      return process_step.name;
    }
  };

  $scope.setCurrentStepAndSubStep = function(){
    var urlStep = $routeParams.urlStep;
    var urlSubStep = $routeParams.urlSubStep;
    var step = $.grep($scope.process_steps, function(e){ return e.url_acronym == urlStep; })[0];
    var substeps = [];
    if(step && step.procedure_sub_steps){
      substeps = step.procedure_sub_steps;
    }
    var sub_step = $.grep(substeps || [], function(e){ return e.url_acronym == urlSubStep; })[0];



    if(step && sub_step){
      if (sub_step.go_sub_step)
      {
        $scope.setCurrentSubStep(sub_step);
      }
      else
      {
        $scope.setCurrentStep(step);
      }
    }
    else if(step){
      $scope.setCurrentStep(step);
    }
    else{
      $scope.setCurrentStep($scope.process_steps[0]);
    }
  };

  angular.element(document).ready(function () {
    $rootScope.isRunNowProcess = true;
    $scope.current_process = $rootScope.current_process;
    $rootScope.getProcessStep(true);

  });
});

