rsasApp.controller('EmailTemplateList',
  function($rootScope, $scope, $location, $http) {
    $scope.emailTemplateList = function() {
      if($location.path().indexOf("global") != -1){
        $scope.process_id = 0;
      }
      else{
        $scope.process_id = $rootScope.current_process.id;
      }

      $scope.email_templates = [
        // About recommendation
        {email_type:"invite_recommender", name: "Edit Recommendation Request Email", pop_text: "Recommenders receive this email after applicants sent request."},
        {email_type:"remind_recommender", name: "Edit Recommendation Reminder Email", pop_text: "Recommenders receive this email after applicants hit the reminder button."},
        {email_type:"notice_applicant_send", name: "Edit The Email Notices Applicant The Recommendation Request Is Sent", pop_text: "Applicants receive this email after they sent recommendation request."},
        {email_type:"notice_recommender_submit", name: "Edit The Email Notices Recommender The Recommendation Form Is Submit", pop_text: "Recommenders receive this email after they submitted recommendation forms."},
        {email_type:"notice_applicant_get", name: "Edit The Email Notices Applicant The Recommendation Form Is Submit", pop_text: "Applicant receive this email after recommenders submitted recommendation forms."},
        {email_type:"submission_application", name: "Edit (submission application) email", pop_text: "Applicants receive this email after they submitted application."},
        // About application submit
        {email_type:"withdraw_application", name: "Edit (withdraw application) email", pop_text: "Applicants receive this email after they withdrew application."},
        {email_type:"interview_mgr_select_applicant", name: "Edit (interview_mgr_select_applicant) email", pop_text: "Applicants receive this email after managers selected them for an interview."},
        // About interview
        {email_type:"interview_mgr_cancel_select_applicant", name: "Edit (interview_mgr_cancel_select_applicant) email", pop_text: "Applicants receive this email after managers cancelled the action to select them for an interview."},
        {email_type:"interview_mgr_schedule_applicant", name: "Edit (interview_mgr_schedule_applicant) email", pop_text: "Applicants receive this email after managers scheduled them for an interview."},
        {email_type:"interview_mgr_cancel_schedule_applicant", name: "Edit (interview_mgr_cancel_schedule_applicant) email", pop_text: "Applicants receive this email after managers cancelled the action to schedule them for an interview."},
        {email_type:"interview_mgr_select_interviewer", name: "Edit (interview_mgr_select_interviewer) email", pop_text: "Interviewers receive this email after managers selected them as interviewers."},
        {email_type:"interview_mgr_cancel_select_interviewer", name: "Edit (interview_mgr_cancel_select_interviewer) email", pop_text: "Interviewers receive this email after managers cancelled the action to select them as interviewers."},
        {email_type:"interview_mgr_schedule_interviewer", name: "Edit (interview_mgr_schedule_interviewer) email", pop_text: "Interviewers receive this email after managers scheduled them as interviewers."},
        {email_type:"interview_mgr_cancel_schedule_interviewer", name: "Edit (interview_mgr_cancel_schedule_interviewer) email", pop_text: "Interviewers receive this email after managers cancelled the action to schedule them as interviewers."},
        {email_type:"interview_applicant_schedule_to_self", name: "Edit (interview_applicant_schedule_to_self) email", pop_text: "Applicants receive this email after they signed up for an interview."},
        {email_type:"interview_applicant_cancel_schedule_to_self", name: "Edit (interview_applicant_cancel_schedule_to_self) email", pop_text: "Applicants receive this email after they cancelled the action to attend an interview."},
        {email_type:"interview_interviewer_schedule_to_self", name: "Edit (interview_interviewer_schedule_to_self) email", pop_text: "Interviewers receive this email after they signed up for an interview."},
        {email_type:"interview_interviewer_cancel_schedule_to_self", name: "Edit (interview_interviewer_cancel_schedule_to_self) email", pop_text: "Interviewers receive this email after they cancelled the action to attend an interview."},
        // About offer
        {email_type:"offer_email", name: "Edit Offer email", pop_text: "Applicants receive this email after manager offered them jobs."},
        // About post match
        {email_type:"post_match_invitation", name: "Edit Post Match Invitation email", pop_text: "Applicants receive this email after managers send them Post Match invitation."},
      ];

      angular.forEach($scope.email_templates, function(email_template){
        email_template.href = "#/email_template";
        email_template.href += "?email_type="+ email_template.email_type;
        email_template.href += "&process_id="+ $scope.process_id;
      });
    };

    $scope.pop_out = function(text){
      $rootScope.defaultDialog(text);
    };

    angular.element(document).ready(function(){
      if($rootScope.isRunNowProcess){
        $scope.emailTemplateList();
      }
    });

  }
);
