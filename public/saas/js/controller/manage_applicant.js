var adminEditApplicantModule = angular.module('adminEditApplicantApp', ['checklist-model', 'ui.multiselect']);

adminEditApplicantModule.controller('AdminApplicationForm',
  function($scope, $window, $sce, CTableRsas, waitingIcon, $rootScope, applicantFactory, userFormFactory, recommendationFormFactory, transcriptFactory, fileFactory, limitPeriodFactory, processFactory, applicationFactory){

    $scope.selectFormTypes = [];
    $scope.formTypes = [
      {"name": "System Forms", "value": "system"},
      {"name": "Attachable Forms", "value": "attachable"},
      {"name": "Recommendations", "value": "recommendations"},
      {"name": "Transcripts", "value": "transcripts"},
    ];

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

    $scope.setDatetimepicker = function() {
      $(".setDatetimepicker").datetimepicker({
        dateFormat: "mm/dd/yy",
        closeText: "Close",
        beforeShow: (function(){
          setTimeout(function(){$('.ui-datepicker').css('z-index', 1000);}, 0);
        })
      });
    };
    //$scope.setDatetimepicker();

    $scope.applicationFormTable = {};
    $scope.applicationFormTable.tbl = new CTableRsas('applicationFormTable.tbl', JSON_URL + '/applicants/applicant_list');
    $scope.applicationFormTable.tbl.setHeader(['First Name', 1], ['Last Name', 1], ['Email', 1], ['Application', 0], ['Status', 0], ['Interview (Selected)', 0], ['Position ', 0]);
    $scope.applicationFormTable.tbl.setDataAndRequest = function(){
      interviews = pluck_array($scope.applicationFormTable.tbl.interviews, "id");
      locations = pluck_array($scope.applicationFormTable.tbl.locations, "id");
      roles = pluck_array($scope.applicationFormTable.tbl.roles, "id");
      var data = {
        /////////  Need Process Data  //////////
        "pageCount": $scope.applicationFormTable.tbl.perPage,
        "page": $scope.applicationFormTable.tbl.goPage,
        "searchText": $scope.applicationFormTable.tbl.searchText,
        "orderBy": $scope.applicationFormTable.tbl.orderBy,
        "ascOrDesc": $scope.applicationFormTable.tbl.sortOrder,
        "procedureId": $rootScope.current_process.id,
        "status": $scope.applicationFormTable.tbl.status,
        "interviews": http_array_safe(interviews),
        "locations": http_array_safe(locations),
        "roles": http_array_safe(roles),
        "question_filters": $scope.form_question_filters,
        "sub_step": $rootScope.current_sub_step.identify_name,
        "current_year_id": $rootScope.current_year.id,
        "current_process_id": $rootScope.current_process.id
      };
      $scope.applicationFormTable.tbl.linkServerPostData($scope.applicationFormTable.tbl, data);
    };

    $scope.applicationFormTable.tbl.successDo = function(data)
    {
      $scope.interview_list = data.interview_list;
      $scope.status_list = data.status_list;
      $scope.location_list = data.location_list;
      $scope.role_list = data.role_list;
      $scope.all_limits = data.all_limits;
      $scope.lower_mgr_see_time = data.permissions.lower_mgr_see_time;
      $scope.see_applicant_forms = data.permissions.see_applicant_filled_forms;
      $scope.disqualify_permission_show = data.permissions.applicant_disqualify.show;
      $scope.force_submit_permission_show = data.permissions.force_submit.show;
      $scope.is_staff = ($rootScope.current_user.status == 'Staff');
      $scope.forms_and_questions = data.forms_and_questions;
      $scope.email.editAll();
    };

    angular.element(document).ready(function () {
      if($rootScope.isRunNowProcess){
        $scope.applicationFormTable.tbl.init($scope, $scope.applicationFormTable.tbl);
        $scope.form = {schema: []};
      }
    });

    $scope.showForm = function(user_form_id){
      $scope.form = {"schema": []};
      waitingIcon.open();
      userFormFactory.showUserFilledForm(user_form_id, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function (data){
        if(data.success){
          data.form.schema = eval(data.form.schema);
          waitingIcon.close();
          $scope.form = data.form;
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the user form."});
        };
      })
      .error(function (data){
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the user form."});
        waitingIcon.close();
        $scope.form = {"schema": []};
      });
    };

    $scope.showTranscript = function(user_id){
      $scope.grades = [];
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

    $scope.showRecommendationForm = function(recommendation_form_id){
      $scope.form = {"schema": []};
      waitingIcon.open();
      recommendationFormFactory.showRecommendationForm(recommendation_form_id)
      .success(function (data){
        if(data.success){
          data.form.schema = eval(data.form.schema);
          waitingIcon.close();
          $scope.form = data.form;
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the recommendation form."});
        };
      })
      .error(function (data){
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the recommendation form."});
        waitingIcon.close();
        $scope.form = {"schema": []};
      });
    };

    $scope.previewApplicantSelectForms = function(applicant) {
      $scope.every_applicant_and_its_forms = [];
      $scope.every_applicant_and_its_form_ids = [];
      obj = $scope.addApplicantWithForms(applicant);
      $scope.getApplicantForms(applicant, obj.system_form_check_list, obj.user_form_check_list, obj.recommendation_form_check_list, obj.interview_form_check_list, obj.transcripts_check_list);
    };

    $scope.previewSelectTypesForms = function(){
      $("#formsWaitedPrint").modal('toggle');
      $scope.every_applicant_and_its_forms = [];
      $scope.every_applicant_and_its_form_ids = [];
      $scope.applicationFormTable.tbl.show.forEach(function(applicant) {
        var system_form_check_list         = [];
        var user_form_check_list           = [];
        var recommendation_form_check_list = [];
        var interview_form_check_list      = [];
        var transcripts_check_list         = [];

        if($scope.selectFormTypes.indexOf($scope.formTypes[0].value) >= 0) {
          applicant.system_forms.forEach(function(system_form){ system_form_check_list.push(system_form.id);});
        }
        if($scope.selectFormTypes.indexOf($scope.formTypes[1].value) >= 0) {
          applicant.user_forms.forEach(function(user_form){ user_form_check_list.push(user_form.id); });
        };
        if($scope.selectFormTypes.indexOf($scope.formTypes[2].value) >= 0) {
          applicant.recommendation_forms.forEach(function(recommendation_form){ recommendation_form_check_list.push(recommendation_form.id); });
        };
        if($scope.selectFormTypes.indexOf($scope.formTypes[3].value) >= 0) {
          transcripts_check_list.push(applicant.id);
        };
        $scope.getApplicantForms(applicant, system_form_check_list, user_form_check_list, recommendation_form_check_list, interview_form_check_list, transcripts_check_list);
      });
    };

    $scope.addApplicantWithForms = function(applicant){
      var system_form_check_list         = [];
      var user_form_check_list           = [];
      var recommendation_form_check_list = [];
      var interview_form_check_list      = [];
      var transcripts_check_list         = [];

      applicant.system_forms.forEach(function(system_form){
        if(system_form.print_check){
          system_form_check_list.push(system_form.id);
        };
      });
      applicant.user_forms.forEach(function(user_form){
        if(user_form.print_check){
          user_form_check_list.push(user_form.id);
        };
      });
      applicant.recommendation_forms.forEach(function(recommendation_form){
        if(recommendation_form.print_check){
          recommendation_form_check_list.push(recommendation_form.id);
        };
      });
      applicant.interview_forms.forEach(function(interview_form){
        if(interview_form.print_check){
          interview_form_check_list.push(interview_form.id);
        };
      });
      if(applicant.transcripts.print_check){
        transcripts_check_list.push(applicant.id);
      };
      obj = { "system_form_check_list": system_form_check_list,
               "user_form_check_list": user_form_check_list,
               "recommendation_form_check_list": recommendation_form_check_list,
               "interview_form_check_list": interview_form_check_list,
               "transcripts_check_list": transcripts_check_list };
      return obj;
    };

    $scope.getApplicantForms = function(applicant, system_form_check_list, user_form_check_list, recommendation_form_check_list, interview_form_check_list, transcripts_check_list){
      if((system_form_check_list + user_form_check_list + recommendation_form_check_list + interview_form_check_list + transcripts_check_list).length > 0){
        waitingIcon.open();
        userFormFactory.showApplicantForms(system_form_check_list, user_form_check_list, recommendation_form_check_list, interview_form_check_list, transcripts_check_list, $rootScope.current_year.id, $rootScope.current_process.id)
        .success(function (data){
          if (data.success){
            data.forms.forEach(function(form_obj){
              form_obj.schema = eval(form_obj.schema);
            });
            applicant_and_its_forms = {
              "applicant_name" : applicant.name,
              "all_forms_about_applicant" : data.forms,
              "transcripts" : data.transcripts
            };
            applicant_and_its_form_ids = {
              "name" : applicant.name,
              "system" : system_form_check_list,
              "application": user_form_check_list,
              "recommendation": recommendation_form_check_list,
              "interview": interview_form_check_list,
              "transcripts": transcripts_check_list
            };
            if(applicant_and_its_forms.all_forms_about_applicant.length != 0 || applicant_and_its_forms.transcripts.length != 0) {
              $scope.every_applicant_and_its_forms.push(applicant_and_its_forms);
              $scope.every_applicant_and_its_form_ids.push(applicant_and_its_form_ids);
            };
          }
          else{
            $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the applicant forms."});
          }
          waitingIcon.close();
        })
        .error(function (data){
          $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the applicant forms."});
          waitingIcon.close();
        });
      }
    };

    $scope.downloadUploadFiles = function(){
      $scope.every_applicant_and_its_forms = [];
      $scope.every_applicant_and_its_form_ids = [];
      $scope.applicationFormTable.tbl.show.forEach(function(applicant) {
        obj = $scope.addApplicantWithForms(applicant);
        applicant_and_its_form_ids = {
          "user_id" : applicant.id,
          "system" : obj.system_form_check_list,
          "application": obj.user_form_check_list,
          "recommendation": obj.recommendation_form_check_list,
          "interview": obj.interview_form_check_list,
        };
        $scope.every_applicant_and_its_form_ids.push(applicant_and_its_form_ids);
      });

      waitingIcon.open();
      fileFactory.getUploadFormsFiles($scope.every_applicant_and_its_form_ids, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function (data){
        if(data.success){
          waitingIcon.close();
          if(data.file_link){
            $window.location.href = data.file_link;
          }
          else{
            $rootScope.rsasAlert({type: 'danger', msg: "No upload files."});
          };
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: "Failed to download upload files."});
        };
      })
      .error(function (data){
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to download upload files."});
        waitingIcon.close();
      });
    };

    $scope.force_submit_confirm = function(applicant){
      $rootScope.defaultConfirm("", "Are you sure to submit the application on behalf of this applicant: " + applicant.name + " ?", $scope.force_submit, applicant);
    };

    $scope.force_submit = function(applicant){
      waitingIcon.open();
      applicantFactory.forceSubmitApplicant(applicant.id, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function (data) {
        if(data.success){
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
          applicant.submited = 'Y';
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to submit this application. Please try again."});
        waitingIcon.close();
      });
    };

    $scope.email = {};
    $scope.email.init = function(){
      $scope.rsas_email = {
        recipients : [],
        cc : [],
        bcc : [],
        subject: "",
        content: ""
      };
    };

    $scope.email.edit = function(applicant){
      $scope.email.init();
      $scope.rsas_email.recipients.push({name:applicant.name, email:applicant.email});
    };

    $scope.email.editAll = function(){
      $scope.email.init();
      if($scope.applicationFormTable.tbl.show) {
        $scope.applicationFormTable.tbl.show.forEach(function(applicant){
          $scope.rsas_email.recipients.push({name:applicant.name, email:applicant.email});
        });
      }
    };

    $scope.email.send = function(){
      waitingIcon.open();
      applicantFactory.sendEmailToApplicants($scope.rsas_email, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function (data) {
        if(data.success){
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
          $("#editEmail").modal('toggle');
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

    $scope.applicantDisqualify = function(applicant_data){
      waitingIcon.open();
      applicantFactory.applicantDisqualify($rootScope.current_process.id, applicant_data.id)
      .success(function(data){
        if(data.success){
          applicant_data.disqualify = data.disqualify;
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
        }
        else {
          $rootScope.rsasAlert({type: 'danger', msg: "Failed to set the applicant."});
        }
        waitingIcon.close();
      })
      .error(function(){
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to set the applicant."});
        waitingIcon.close();
      });
    };

    $scope.createLimit = function(limit) {
      waitingIcon.open();
      limitPeriodFactory.createLimit(limit, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function(data){
        if(data.success) {
          $scope.all_limits = data.all_limits;
          $rootScope.rsasAlert({type: 'success', msg: "Create limit successfully."});
        }
        else {
          $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to create limit."});
        }
        waitingIcon.close();
      })
      .error(function(){
        $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to create limit."});
        waitingIcon.close();
      });
    };

    $scope.updateLimit = function(limit) {
      waitingIcon.open();
      limitPeriodFactory.updateLimit(limit, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function(data){
        if(data.success) {
          $scope.all_limits = data.all_limits;
          $rootScope.rsasAlert({type: 'success', msg: "Update limit successfully."});
        }
        else {
          $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to update limit."});
        }
        waitingIcon.close();
      })
      .error(function(){
        $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to update limit."});
        waitingIcon.close();
      });
    };

    $scope.deleteLimit = function(limit) {
      waitingIcon.open();
      limitPeriodFactory.deleteLimit(limit, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function(data){
        if(data.success) {
          $scope.all_limits = data.all_limits;
          $rootScope.rsasAlert({type: 'success', msg: "Delete limit successfully."});
        }
        else {
          $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to delete limit."});
        }
        waitingIcon.close();
      })
      .error(function(){
        $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to delete limit."});
        waitingIcon.close();
      });
    };

    $scope.form_question_attributes = ['=', '>', '<', '>=', '<=', 'is null', 'not null'];

    $scope.form_question_filters = [];
    $scope.addQuestionFilter = function(){
      var query = {
        "form_type": $scope.applicant_form_filter,
        "form_name": $scope.applicant_form_name_filter,
        "question": $scope.applicant_form_question_filter,
        "question_attribute": $scope.form_question_attribute,
        "question_attribute_value": $scope.form_question_attribute_value
      };
      var is_same = false;
      for(var i = 0, len = $scope.form_question_filters.length; i < len; i ++) {
        if(angular.equals($scope.form_question_filters[i], query)){
          is_same = true;
          break;
        };
      };
      if(!is_same){
        $scope.form_question_filters.push(query);
      };
    };

    $scope.clearFormFilter = function(){
      $scope.form_question_filters = [];
    };

    $scope.showEditPosition = function(applicant){
      $scope.add_positions = {};
      $scope.add_positions.search_name = '';
      $scope.add_positions.applicant = applicant;

      waitingIcon.open();
      applicationFactory.manualPositionsList($rootScope.current_year.id, $rootScope.current_process.id, applicant.id)
      .success(function(data){
        if(data.success) {
          $scope.add_positions.positions = data.positions;
          $scope.position_selest_add_ids = [];
          $scope.position_selest_delete_ids = [];
        }
        else {
          $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to get add_position_list."});
        }
        waitingIcon.close();
      })
      .error(function(){
        $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to get add_position_list."});
        waitingIcon.close();
      });
    };

    $scope.checkPositionsSelect = function(position){
      if (position.is_select){
        var index_of = $scope.position_selest_delete_ids.indexOf(position.id);
        if(index_of != -1){
          $scope.position_selest_delete_ids.splice(index_of, 1);
        }
        $scope.position_selest_add_ids.push(position.id);
      }
      else{
        var index_of = $scope.position_selest_add_ids.indexOf(position.id);
        if(index_of != -1){
          $scope.position_selest_add_ids.splice(index_of, 1);
        }
        $scope.position_selest_delete_ids.push(position.id);
      }
    };

    $scope.manualUpdatePositions = function(applicant){
      waitingIcon.open();
      applicationFactory.manualUpdatePositions(applicant.id, $scope.position_selest_add_ids, $scope.position_selest_delete_ids, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function(data){
        if(data.success){
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
          applicant.positions = data.select_positions;
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to select the position."});
        waitingIcon.close();
      });
    };

  }
);
