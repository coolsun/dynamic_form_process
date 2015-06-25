rsasApp.controller('rdFlag',
  function($scope, $rootScope, $location, waitingIcon, rdFlagFactory) {
    // Main program
    $scope.getApplicantList = function(){
      waitingIcon.open();
      rdFlagFactory.getApplicantList($rootScope.current_process.id, $rootScope.current_year.id, $location.search().page)
      .success(function(data){
        if(data.success) {
          //console.log(data.applicant_list);
          $scope.applicant_list = data.applicant_list;
  
          $scope.current_path = data.current_host_url + $location.path();
          $scope.page_num_list = data.page_num_list;
          $scope.current_page = data.current_page;
          $scope.switch_page = data.current_page;
  
          angular.forEach($scope.applicant_list, function(single_applicant){
            angular.forEach(single_applicant.user.rd_records, function(this_applicant_rec){
              this_applicant_rec.involvedStudentIdArray = this_applicant_rec.involved_student_id.split("; ");
              this_applicant_rec.involvedStudentNameArray = this_applicant_rec.involved_student_name.replace(/\,/g, "").split("; ");
              this_applicant_rec.involvedStudentArray = [];
              angular.forEach(this_applicant_rec.involvedStudentNameArray, function(involved_std_name, key){
                if(this_applicant_rec.involvedStudentIdArray[key] != this_applicant_rec.primary_student_id && this_applicant_rec.involvedStudentIdArray[key] != single_applicant.user.suid) {
                  this_applicant_rec.involvedStudentArray.push({"suid" : this_applicant_rec.involvedStudentIdArray[key], "name" : involved_std_name});
                }
              });
            });
          });
        }
        else {
          $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the applicant list."});
        }
        waitingIcon.close();
      })
      .error(function() {
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the applicant list."});
        waitingIcon.close();
      });
    };

    $scope.changeRdFlagConfirm = function(applicant, rd_flag_color){
      confirmDoParams = [applicant, rd_flag_color];
      $rootScope.defaultConfirm(
        "",
        "Do you want to change RD flag for student " + applicant.user.name + " from " + applicant.rd_flag_color + " to " + rd_flag_color + "?",
        $scope.change_rd_flag,
        confirmDoParams
      );
    };
    
    $scope.change_rd_flag = function(flag_params) {
      applicant = flag_params[0];
      rd_flag_color = flag_params[1];
      
      applicant.wait_ajax = true;
      rdFlagFactory.changeRdFlag(applicant, rd_flag_color, $rootScope.current_process.id, $rootScope.current_year.id)
      .success(function(data){
        if(data.success) {
          applicant.rd_flag_color = data.rd_flag_color;
          applicant_in_list = findObj($scope.applicant_list, "id", applicant.id);
          applicant_in_list.rd_flag_color = applicant.rd_flag_color;
        }
        else {
          $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to update the RD flag."});
        }
        applicant.wait_ajax = false;
      })
      .error(function(){
        $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to update the RD flag."});
        applicant.wait_ajax = false;
      });
    };
    
    $scope.remove_dot = function(string) {
      return string.replace(/\,/g, "");
    };
    
    $scope.showInvolvedStudent = function(suid, name) {
      $scope.other_applicant_suid = suid;
      $scope.other_applicant_name = $scope.remove_dot(name);
      
      waitingIcon.open();
      rdFlagFactory.getInvolvedStudent(suid, $rootScope.current_process.id, $rootScope.current_year.id)
      .success(function(data) {
        $scope.get_other_applicant_success = data.success;
        $scope.get_other_applicant_msg = data.msg;
        
        $scope.other_applicant = data.applicant;
        $scope.other_applicant_ill_rec = data.ill_rec;
        
        waitingIcon.close();
      })
      .error(function() {
        waitingIcon.close();
        $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to get the involved student's RD flag."});
      });
    };

    angular.element(document).ready(function () {
      if($rootScope.isRunNowProcess){
        $scope.getApplicantList();
      }
    });

  }
);
