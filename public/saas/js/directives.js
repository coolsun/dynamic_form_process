var directiveModule = angular.module('directiveModule', []);

//---------------------------------RsasEmail start---------------------------------
/* add in your controller
  $scope.rsas_email = {
    recipients : [{name: 'name1',email:'email1'}, {name: 'name2',email:'email2'}],
    subject: "Subject",
    content: "Content"
  };
*/

directiveModule
.controller('RsasEmail', function($scope, $window) {
  $scope.mail_addtype = 'to';

  $scope.addNewEmail = function(){
    check_success = true;
    if(!$scope.$parent.rsas_email.add){
      $scope.$parent.rsas_email.add = {};
    }
    $scope.$parent.rsas_email.add.email_error = !$scope.$parent.rsas_email.add.email;
    if($scope.$parent.rsas_email.add.email_error){
      $scope.$parent.rsas_email.add.email_error_msg = "Eamil is required.";
      check_success = false;
    }
    if($scope.$parent.rsas_email.add.email && !validateEmail($scope.$parent.rsas_email.add.email)){
      $scope.$parent.rsas_email.add.email_error = true;
      $scope.$parent.rsas_email.add.email_error_msg = "Invalid E-Mail format.";
      check_success = false;
    }
    if(!$scope.$parent.rsas_email.add.name){
      $scope.$parent.rsas_email.add.name = $scope.$parent.rsas_email.add.email;
    }
    if(check_success){
      if($scope.mail_addtype == "to"){
        $scope.$parent.rsas_email.recipients.push($scope.$parent.rsas_email.add);
      }
      else if($scope.mail_addtype == "cc"){
        $scope.$parent.rsas_email.cc.push($scope.$parent.rsas_email.add);
      }
      else if($scope.mail_addtype == "bcc"){
        $scope.$parent.rsas_email.bcc.push($scope.$parent.rsas_email.add);
      };
      $scope.$parent.rsas_email.add = {};
    }
  };

  $scope.deleteRecipientEmail = function(index){
    if($scope.$parent.rsas_email.recipients.length == 1){
      $window.alert("There is no receiver in the ''To'' email space. Please at least add one email address.");
      return;
    }
    else if($scope.$parent.rsas_email.recipients[index].is_constant){
      $window.alert("Sorry, you can't delete this.");
      return;
    };
    $scope.$parent.rsas_email.recipients.splice(index, 1);
  };

})
.directive('rsasEmail', function(){
    return{
      restrict: 'E',
      templateUrl: '/saas/partials/rsas_email.html'
    };
  }
);

//---------------------------------RsasEmail end-----------------------------------
// rsasForm will map to directive rsas-form
// e.g. <rsas-form></rsas-form> will be replaced with '/saas/partials/form_template.html'
directiveModule.directive('rsasForm', function(){
    return{
      restrict: 'E',
      templateUrl: '/saas/partials/rsas_form_template.html?' + (new Date().valueOf())
    };
  }
);

directiveModule.directive('rsasFormShow', function(){
    return{
      restrict: 'E',
      templateUrl: '/saas/partials/rsas_form_show_template.html?' + (new Date().valueOf())
    };
  }
);

directiveModule.directive('rsasTranscripts', function(){
    return{
      restrict: 'E',
      templateUrl: '/saas/partials/rsas_transcript_template.html?' + (new Date().valueOf())
    };
  }
);

directiveModule.directive('rsasMaxlength', function() {
  return {
    restrict: 'A',
    require: 'ngModel',
    link: function (scope, elem, attrs, ctrl) {
      attrs.$set("ngTrim", "false");
              var maxlength = parseInt(attrs.rsasMaxlength, 10);
              ctrl.$parsers.push(function (value) {
                  if (value.length > maxlength)
                  {
                      value = value.substr(0, maxlength);
                      ctrl.$setViewValue(value);
                      ctrl.$render();
                  }
                  return value;
              });
    }
  };
});

//---------------------------------repeatDone start-----------------------------------
// repeatDone will done your function after ng-repeat
// ex: <tr ng-repeat="sub_step in current_step.procedure_sub_steps" repeat-done="loadTimepickerAndCheckInTime()">
directiveModule.directive('repeatDone', function() {
  return function(scope, element, attrs) {
    if (scope.$last) { // all are rendered
      scope.$eval(attrs.repeatDone);
    }
  };
});
//---------------------------------repeatDone end-------------------------------------
