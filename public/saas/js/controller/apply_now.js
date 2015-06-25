var applyNowModule = angular.module('applyNowApp', []);

applyNowModule.controller('ApplyNow',
  function ($scope, $rootScope, $sce, $routeParams, waitingIcon, processFactory, processStepFactory, applicantFactory, $location) {
    $scope.apply_now = {};
    $scope.url_sn = 0;
    $scope.processSubStepURL = [];
    $rootScope.applicantApplicationStatus = {};
    $rootScope.apply_white_list = false;

    $rootScope.applicant_step = null;
    $rootScope.applicant_sub_step = null;

    $scope.setCurrentSubStep = function(step){
      if (step.identify_name == 'submit_application' && !$rootScope.applicantApplicationStatus['can_submit']){
        $rootScope.defaultDialog("Warning: You have to complete all steps above before submitting the application.");
      }
      else{
        $rootScope.applicant_sub_step = step;
        $rootScope.applicant_step = null;
        $scope.url_sn = (new Date()).valueOf();
      };
    };

    $scope.isCurrentSubStep = function(){
      var isShow = true;
      var run_sub_step = '';

      $scope.processSubStepURL = [];

      if ($rootScope.applicant_sub_step)
      {
        if ($rootScope.applicant_sub_step.identify_name.match(/^interview\d+$/))
        {
          run_sub_step = "interview";
        }
        else
        {
          run_sub_step = $rootScope.applicant_sub_step.identify_name;
        }
      }

      switch(run_sub_step)
      {
        case "select_position":
          $scope.processSubStepURL.push("/saas/partials/user_select_positions.html" + "?sn=" + $scope.url_sn);
          break;
        case "fill_in_form":
        case "post_offer_fill_in_form":
          $scope.processSubStepURL.push("/saas/partials/user_fill_in_form.html" + "?sn=" + $scope.url_sn);
          break;
        case "recommendation":
          $scope.processSubStepURL.push("/saas/partials/user_recommendations.html" + "?sn=" + $scope.url_sn);
          break;
        case "submit_application":
          $scope.processSubStepURL.push("/saas/partials/submit_application.html" + "?sn=" + $scope.url_sn);
          break;
        case "interview":
          $scope.processSubStepURL.push("/saas/partials/interview_user_process.html" + "?sn=" + $scope.url_sn);
          break;
        case "offer":
        case "post_offer_offer":
          $scope.processSubStepURL.push("/saas/partials/user_offers.html" + "?sn=" + $scope.url_sn);
          break;
        case "ranking":
          $scope.processSubStepURL.push("/saas/partials/user_ranking.html" + "?sn=" + $scope.url_sn);
          break;
        case "post_offer_invitations":
          $scope.processSubStepURL.push("/saas/partials/user_select_positions.html" + "?sn=" + $scope.url_sn);
          break;
        default:
          isShow = false;
      };
      return (isShow);
    };

    $scope.isCurrentSubStepClassShow = function(key, value){
      return $rootScope.applicant_sub_step && $rootScope.applicant_sub_step[key] == value;
    };

    $scope.isCurrentStepClassShow = function(key, value){
      return $rootScope.applicant_step && $rootScope.applicant_step[key] == value;
    };

    $scope.getProcessStep = function(){
      waitingIcon.open();
      processStepFactory.getApplicantProcessStep($rootScope.current_year.id, $rootScope.current_process.id)
      .success(function (data) {
        if(data.success){
          $scope.process_steps = data.procedure_steps;
          $rootScope.apply_white_list = data.apply_white_list;
          var urlStep = $routeParams.urlStep;
          var urlSubStep = $routeParams.urlSubStep;
          var step = $.grep($scope.process_steps, function(e){ return e.url_acronym == urlStep; })[0];
          var substeps = [];
          if(step && step.procedure_sub_steps){
            substeps = step.procedure_sub_steps;
          }
          var sub_step = $.grep(substeps || [], function(e){ return e.url_acronym == urlSubStep; })[0];

          if(step && sub_step && $scope.checkSubmittid(step, sub_step)){
            $scope.setCurrentSubStep(sub_step);
          }
          else if(step && sub_step){
            $rootScope.rsasAlert({type: 'danger', msg: "You have not yet submitted your application."});
            $scope.changeStep(step);
          }
          else if(step){
            $scope.getStepLanding(step);
          }
          else{
            $scope.getStepLanding($scope.process_steps[1]);
          }
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the process steps."});
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the process steps."});
        waitingIcon.close();
      });
    };

    $scope.getStepLanding = function(step){
      waitingIcon.open();
      processStepFactory.getStepLanding(step.name, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function (data) {
        if(data.success){
          $rootScope.applicant_sub_step = null;
          $rootScope.applicant_step = step;
          $scope.landing = $sce.trustAsHtml(data.landing_after);
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

    $rootScope.getApplicantStatus = function(get_process_step)
    {
      waitingIcon.open();
      processStepFactory.getApplicantStatus($rootScope.current_year.id, $rootScope.current_process.id)
      .success(function (data) {
        if(data.success){
          $rootScope.applicantApplicationStatus = data.status;
          if(get_process_step){
            $scope.getProcessStep();
          }
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the applicant application status."});
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the applicant application status."});
        waitingIcon.close();
      });
    };

    $scope.apply_now.applyNow = function(){
      waitingIcon.open();
      applicantFactory.insertApply($rootScope.current_year.id, $rootScope.current_process.id)
      .success(function (data) {
        if(data.success){
          $rootScope.current_user = data.authorities;
          $rootScope.header_permissions = data.permissions;
          $rootScope.getApplicantStatus(true);
        }
        else{
          if (data.permissions.no_status)
          {
            $("#modalSystemProcessNotStart").modal('show').on('hidden.bs.modal', function (e) {
              location.href  = "/saas/index.html#/start/";
            });
          }
          else if('xSYS00012' == data.eCode)
          {
            $("#modalSystemApplyFail").modal('show');
          }
          else
          {
            $("#modalSystemError").modal('show');
          }
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $("#modalSystemError").modal('show');
        waitingIcon.close();
      });
    };

    $rootScope.isInTime = function(step){
      if($rootScope.apply_white_list){
        return true;
      }
      else{
        start_at = new Date(step.t_start);
        end_at = new Date(step.t_end);
        return start_at < Date.now() && Date.now() < end_at;
      }
    };

    $scope.checkSubStepDisabled = function(step, sub_step){
      var disabled = false;
      if(!$rootScope.isInTime(sub_step)){
        disabled = true;
      }else if(sub_step.identify_name == 'submit_application' && !$rootScope.applicantApplicationStatus['can_submit']){
        disabled = true;
      }else if(!$scope.checkSubmittid(step, sub_step)){
        disabled = true;
      }
      return disabled;
    };

    $scope.checkSubmittid = function(step, sub_step){
      var checked = true;
      var need_submit_step = ["Interview", "Ranking", "Offer", "Post Match"];
      if(!$rootScope.applicantApplicationStatus['submit_application']){
        if(need_submit_step.indexOf(step.name) != -1){
           checked = false;
        }
      }
      return checked;
    };

    $scope.changeStep = function(step){
      $rootScope.isRunNowProcess = false;
      $rootScope.current_sub_step = null;
      $rootScope.current_step = null;
      $scope.processSubStepURL = [];
      var url = "/" + $routeParams.urlProcessYear + "/" + $routeParams.urlProcessAcronym + "/apply_now/" + step.url_acronym;
      $location.path(url);
    };

    $scope.changeSubStep = function(step, sub_step){
      if($scope.checkSubmittid(step, sub_step)){
        $rootScope.isRunNowProcess = false;
        $rootScope.current_sub_step = null;
        $rootScope.current_step = null;
        $scope.processSubStepURL = [];
        var url = "/" + $routeParams.urlProcessYear + "/" + $routeParams.urlProcessAcronym + "/apply_now/" + step.url_acronym + "/" + sub_step.url_acronym;
        $location.path(url);
      }
      else{
        $rootScope.defaultConfirm(step.name + " - Server Message", "You have not yet submitted your application.", null, null);
      }
    };

    angular.element(document).ready(function () {
      $rootScope.isRunNowProcess = true;
      $scope.apply_now.applyNow();
    });

  }
);
