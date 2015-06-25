var emailTemplateModule = angular.module('emailTemplateApp', []);

emailTemplateModule.controller('email_template_control',
  function ($scope, $rootScope, $location, $window, waitingIcon, emailTemplateFactory) {
    $scope.process_id = $location.search().process_id;

    // index
    $scope.getEmailTemplates = function(){
      if($location.search().email_type) {
        $scope.email_type = $location.search().email_type;
      }
      else {
        $scope.email_type = "invite_recommender";
      }
      waitingIcon.open();
      emailTemplateFactory.getEmailTemplates($scope.process_id, $scope.email_type, $rootScope.current_year.id)
      .success(function(data) {
        if(data.success){
          $scope.current_email = data.email_template;
          $scope.template_id_list = data.template_id_list;
          $scope.check_same_title();
          $scope.permission_to_active = data.permission_to_active;
          $rootScope.rsasAlert({type: 'success', msg: "The email templates has been got successfully."});
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function() {
        $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to get email templates."});
        waitingIcon.close();
      });
    };

    // show
    $scope.show_template = function(id) {
      waitingIcon.open();
      emailTemplateFactory.showTemplate(id, $rootScope.current_year.id, $scope.process_id)
      .success(function(data) {
        if(data.success) {
          $scope.current_email = data.email_template;
          $scope.check_same_title();
          $rootScope.rsasAlert({type: 'success', msg: "The email template has been got successfully."});
        }
        else {
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function() {
        $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to get email template."});
        waitingIcon.close();
      });
    };

    // new
    $scope.new_template = function() {
      new_template = {
        id: null,
        title: "New Template",
        content: "<p> </p>",
        email_type: $scope.email_type,
        is_active: false,
        procedure_id: $scope.process_id
      };
      angular.extend($scope.current_email, new_template);
      $scope.check_same_title();
    };

    // create
    $scope.create_template = function() {
      waitingIcon.open();
      emailTemplateFactory.createTemplate($scope.current_email, $rootScope.current_year.id, $scope.process_id)
      .success(function(data){
        if(data.success){
          $scope.current_email = data.email_template;
          $scope.template_id_list = data.template_id_list;
          $scope.check_same_title();
          $rootScope.rsasAlert({type: 'success', msg: "The email template has been created successfully."});
        }
        else{
          $scope.template_id_list = data.template_id_list;
          $scope.check_same_title();
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function(){
        $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to create email template."});
        waitingIcon.close();
      });
    };

    // update
    $scope.update_template = function() {
      waitingIcon.open();
      emailTemplateFactory.updateTemplate($scope.current_email, $rootScope.current_year.id, $scope.process_id)
      .success(function(data) {
        if(data.success) {
          $scope.current_email = data.email_template;
          $scope.template_id_list = data.template_id_list;
          $scope.check_same_title();
          $rootScope.rsasAlert({type: 'success', msg: "The email template has been updated successfully."});
        }
        else {
          $scope.template_id_list = data.template_id_list;
          $scope.check_same_title();
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function() {
        $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to update the email template."});
        waitingIcon.close();
      });
    };

    // delete
    $scope.delete_template = function() {
      if(confirm("Are you sure to delete this template?")) {
        waitingIcon.open();
        emailTemplateFactory.deleteTemplate($scope.current_email, $scope.email_type, $rootScope.current_year.id, $scope.process_id)
        .success(function(data){
          if(data.success){
            $scope.template_id_list = data.template_id_list;
            $scope.new_template();
            $rootScope.rsasAlert({type: 'success', msg: "The email template has been deleted successfully."});
          }
          else{
            $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to delete email template."});
          }
          waitingIcon.close();
        })
        .error(function(){
          $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to delete email template."});
          waitingIcon.close();
        });
      }
    };

    $scope.run_template = function() {
      waitingIcon.open();
      emailTemplateFactory.runTemplate($scope.current_email, $scope.email_type, $rootScope.current_year.id, $scope.process_id)
      .success(function(data){
        if(data.success) {
          $scope.current_email.is_active = data.email_template.is_active;
          $scope.template_id_list = data.template_id_list;
          $scope.check_same_title();
          $rootScope.rsasAlert({type: 'success', msg: "This email template is used now."});
        }
        else {
          $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to set this email template used."});
        }
        waitingIcon.close();
      })
      .error(function(){
        $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to set this email template used."});
        waitingIcon.close();
      });
    };

    $scope.check_same_title = function() {
      one_existed_template = findObj($scope.template_id_list, "title", $scope.current_email.title);
      $scope.disable_save_button = one_existed_template != null && one_existed_template.id != $scope.current_email.id;
    };

    $scope.getEmailTemplates();
});