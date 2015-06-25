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
  $scope.duplicate_email_record = null;
  $scope.record_detail == null;

  $scope.showRecordList = function(){
    // Find the email send record and the process description
    recommendationRecordFactory.showRecordList($rootScope.current_user.id, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data){
      console.log(data);
      $scope.recommendation_emails = data.records;
      $scope.permission_to_active = data.permission_to_active;
      $scope.recommendation = findObj(data.settings, "procedure_id", $scope.current_process_id);
      $scope.recommendation_forms = data.recommendation_forms;
      $scope.requirementHTML = $sce.trustAsHtml($scope.recommendation.requirement);
      console.log("Get record and setting success.");
    })
    .error(function(data){
      console.log("Fail to get record and setting.");
    });
  };

  // Combine the first_name, middle_name, last_name to applicant_name
  var applicant_name = $rootScope.current_user.first_name;
  if($rootScope.current_user.middle_name){
    applicant_name += " " + $rootScope.current_user.middle_name;
  }
  if($rootScope.current_user.last_name){
    applicant_name += " " + $rootScope.current_user.last_name;
  }

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
    if($scope.duplicate_form_record != null) {
      console.log($scope.duplicate_form_record);
    }
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
