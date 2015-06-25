rsasApp.controller('Invitations',
  function($scope, $rootScope, $window, CTableRsas, waitingIcon, positionFactory, postOfferFactory) {
    $scope.current_process_id = $rootScope.current_process.id;
    $scope.positionTable = {};
    $scope.positionTable.tbl = new CTableRsas('positionTable.tbl', JSON_URL + '/post_offer/invitation_list');
    $scope.positionTable.tbl.setHeader(['Name', 1], ['Tag', 1], ['Description', 1], ['Vacancy', 1], ['Auto Matching', 1], ['One Year Up', 1]);
    $scope.positionTable.tbl.setDataAndRequest = function(){
      var data = {
        /////////  Need Position Data  //////////
        pageCount: $scope.positionTable.tbl.perPage,
        page: $scope.positionTable.tbl.goPage,
        searchText: $scope.positionTable.tbl.searchText,
        orderBy: $scope.positionTable.tbl.orderBy,
        ascOrDesc: $scope.positionTable.tbl.sortOrder,
        procedureId : $scope.current_process_id,
        "current_year_id": $rootScope.current_year.id,
        "current_process_id": $rootScope.current_process.id
      };
      $scope.positionTable.tbl.linkServerGetData($scope.positionTable.tbl, data);
    };

    angular.element(document).ready(function () {
      if($rootScope.isRunNowProcess){
        $scope.positionTable.tbl.init($scope, $scope.positionTable.tbl);
      }
    });

    $scope.new_position = {"procedure_id": $scope.current_process_id};
    $scope.edit_position = {};
    $scope.update_position = {};

    $scope.addPosition = function() {
      waitingIcon.open();
      $scope.new_position.auto_matching = true;
      $scope.new_position.one_year_up = false;
      positionFactory.getSelectLists($rootScope.current_year.id, $rootScope.current_process.id)
      .success(function (data) {
        if(data.success){
          $scope.roles = data.roles;
          $scope.locations = data.locations;
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the position list."});
        waitingIcon.close();
      });
    };

    $scope.insertPosition = function() {
      waitingIcon.open();
      positionFactory.invitationCreatePosition(this.new_position, $rootScope.current_year.id, $rootScope.current_process.id).success(function (data) {
        if(data.success){
          console.log("Position Create Success");
          $scope.positionTable.tbl.show.splice(0 , 0, data.position);
          $("#addPosition").modal("hide");
          $scope.new_position = {"procedure_id": $scope.current_process_id};
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
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
        content: "",
      };
    };

    $scope.selectInviteApplicants = function() {
      $scope.editing_post_offer = angular.copy(this.tblTr);
      $scope.update_post_offer = this.tblTr;
      $scope.email.init();
    };

    $scope.updateRecipients = function(applicant) {
      if(applicant.invited) {
        $scope.rsas_email.recipients.push(applicant);
      }
      else{
        $scope.rsas_email.recipients.splice($scope.rsas_email.recipients.indexOf(applicant), 1);
      };
    };

    $scope.saveInviteList = function() {
      if($scope.rsas_email.recipients.length > 0){
        waitingIcon.open();
        postOfferFactory.getOfferEmailTemplate($rootScope.current_year.id, $rootScope.current_process.id).success(function (data) {
          if(data.success){
            $scope.rsas_email.content = data.mail_template.content;
            $scope.rsas_email.subject = data.mail_template.title;
          }
          else{
            $rootScope.rsasAlert({type: 'danger', msg: 'Failed to get the invitation email template.'});
          };
          waitingIcon.close();
        })
        .error(function (data) {
          $rootScope.rsasAlert({type: 'danger', msg: 'Failed to get the invitation email template.'});
          waitingIcon.close();
        });
        $("#selectInviteApplicants").modal("hide");
        $("#sendInvitations").modal("show");
      }
      else{
        $window.alert("Please at least select one applicant.");
      };
    };

    $scope.email.send = function(){
      waitingIcon.open();
      postOfferFactory.sendInviteEmail($scope.editing_post_offer.id, $scope.rsas_email, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function (data) {
        if(data.success){
          angular.extend($scope.update_post_offer, $scope.editing_post_offer);
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
          $("#sendInvitations").modal('toggle');
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

  }
);
