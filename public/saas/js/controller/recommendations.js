var recommendationModule = angular.module('recommendationApp', []);

recommendationModule.controller('Recommendations',
function($scope, $location, recommendationSettingFactory, waitingIcon, $rootScope) {
  $scope.current_process_id = $rootScope.current_process.id;

  $scope.showRecommendationSetting = function(){
    waitingIcon.open();
    recommendationSettingFactory.showRecommendationSetting($scope.current_process_id, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success){
        $scope.recommendation_setting = data.recommendation_setting;
        $scope.permission_to_active = data.permission_to_active;
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function(data){
      $rootScope.rsasAlert({type: 'danger', msg: 'Failed to get the recommendation setting.'});
      waitingIcon.close();
    });
  };

  $scope.updateRecommendationSetting = function() {
    waitingIcon.open();
    recommendationSettingFactory.updateRecommendationSetting($scope.recommendation_setting, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      if(data.success){
        $scope.recommendation_setting = data.recommendation_setting;
        $rootScope.rsasAlert({type: 'success', msg: data.msg});
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function(data){
      $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to update the recommendation setting.'});
      waitingIcon.close();
    });
  };

  angular.element(document).ready(function(){
    if($rootScope.isRunNowProcess){
      $scope.showRecommendationSetting();
    }
  });
});

recommendationModule.controller('UserRecommendations',
function($scope, $location, $sce, $rootScope, waitingIcon, recommendationRecordFactory){
  $scope.current_process_id = $rootScope.current_process.id;
  $scope.request = {};
  $scope.edit_recommendation = {};
  $scope.duplicate_email_record = null;
  $scope.duplicate_email_record_edit = null;
  $scope.record_detail == null;

  $scope.showRecordList = function(){
    // Find the email send record and the process description
    recommendationRecordFactory.showRecordList($rootScope.current_user.id, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      //console.log(data);
      $scope.recommendation_emails = data.records;
      $scope.permission_to_active = data.permission_to_active;
      $scope.recommendation = findObj(data.settings, "procedure_id", $scope.current_process_id);
      $scope.recommendation_forms = data.recommendation_forms;
      $scope.requirementHTML = $sce.trustAsHtml($scope.recommendation.requirement);
      if(data.success) {
        console.log("Get record and setting success.");
      } else {
        $scope.error_msg = data.msg;
        console.log(data.msg);
      }
    })
    .error(function(data){
      console.log("Fail to get record and setting.");
    });
  };

  $scope.sendRecommendation = function() {
    waitingIcon.open();
    var request_timestamp = Date.now() / 1000;
    // Insert record into database
    recommendationRecordFactory.sendRecommendation($rootScope.current_user.id,
                                                   $rootScope.current_process.id,
                                                   $scope.request,
                                                   request_timestamp,
                                                   $rootScope.current_year.id)
    .success(function (data) {
      if(data.success){
        $scope.recommendation_emails = data.records;
        $rootScope.rsasAlert({type: 'success', msg: data.msg});
        $rootScope.getApplicantStatus(false);
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: "Failed to send the recommendation request."});
      waitingIcon.close();
    });

    $scope.request = {};
  };

  $scope.resendRecommandation = function(recommendation_record_id) {
    if(confirm("Do you want to send the reminder mail?") == true) {
      recommendationRecordFactory.resendRecommandation(recommendation_record_id, $rootScope.current_year.id, $rootScope.current_process.id);
    }
  };

  $scope.recommendation_into_edit = function(recommendation_record) {
    $scope.edit_recommendation.id = recommendation_record.id;
    $scope.edit_recommendation.name = recommendation_record.name;
    $scope.edit_recommendation.title = recommendation_record.title;
    $scope.edit_recommendation.relationship = recommendation_record.relationship;
    $scope.edit_recommendation.email = recommendation_record.email;
    $scope.edit_recommendation.recommendation_form_id = recommendation_record.recommendation_form_id;
    $scope.check_duplicate_email_edit();
  };

  $scope.update_recommendation = function(recommendation_record) {
    recommendationRecordFactory.updateRecommendation(recommendation_record, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data) {
      if(data.success) {
        updated_record = findObj($scope.recommendation_emails, "id", data.record.id);
        $scope.recommendation_emails[$scope.recommendation_emails.indexOf(updated_record)] = data.record;
        $rootScope.rsasAlert({type: 'success', msg: data.msg});
      }
      else {
        $rootScope.rsasAlert({type: 'danger', msg: "There is some problem to update recommendor data."});
      }
    })
    .error(function(data) {
      $rootScope.rsasAlert({type: 'danger', msg: "There is some problem to update recommendor data."});
    });
  };

  $scope.disable_record = function(recommendation_record) {
    console.log(recommendation_record);
    recommendationRecordFactory.disableRecord(recommendation_record.id, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data) {
      recommendation_record.disabled = data.disabled;
      console.log("Disable : " + data.disabled);
    })
    .error(function(data) {
      console.log(data);
    });
  };

  $scope.check_duplicate_email = function() {
    $scope.duplicate_email_record = findObjs($scope.recommendation_emails, "email", $scope.request.email);
    $scope.duplicate_form_record = findObj($scope.duplicate_email_record, "recommendation_form_id", $scope.request.recommendation_form_id);
  };

  $scope.check_duplicate_email_edit = function() {
    $scope.duplicate_email_record_edit = findObjs($scope.recommendation_emails, "email", $scope.edit_recommendation.email);
    $scope.duplicate_form_record_edit = findObj($scope.duplicate_email_record_edit, "recommendation_form_id", $scope.edit_recommendation.recommendation_form_id);
  };

  $scope.get_recommendation_form_name = function(form_id) {
    form_name = findObj($scope.recommendation_forms, "id", form_id).form_name;
    return form_name;
  };

  angular.element(document).ready(function(){
    if($rootScope.isRunNowProcess){
      $scope.showRecordList();
    }
  });

});
