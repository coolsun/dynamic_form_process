rsasApp.controller('Offers', function($scope, $rootScope, CTableRsas, offerFactory, applicantFactory, waitingIcon) {
  $scope.current_process_id = $rootScope.current_process.id;

  $scope.offerTable = {};
  $scope.offerTable.tbl = new CTableRsas('offerTable.tbl', JSON_URL + '/offer/offer_list?procedure_id=' + $scope.current_process_id);
  $scope.offerTable.tbl.setHeader(['Position', 1], ['Vacancy', 1], ['Auto Match Applicant', 0], ['Ready To Offer', 0], ['Offered', 0], ['Accepted', 0], ['Declined', 0]);
  $scope.offerTable.tbl.setDataAndRequest = function(){
    locations = pluck_array($scope.offerTable.tbl.locations, "id");
    roles = pluck_array($scope.offerTable.tbl.roles, "id");
    var data = {
      /////////  Need Offer Data  //////////
      "pageCount": $scope.offerTable.tbl.perPage,
      "page": $scope.offerTable.tbl.goPage,
      "searchText": $scope.offerTable.tbl.searchText,
      "orderBy": $scope.offerTable.tbl.orderBy,
      "ascOrDesc": $scope.offerTable.tbl.sortOrder,
      "procedureId": 0,
      "current_year_id": $rootScope.current_year.id,
      "current_process_id": $rootScope.current_process.id,
      "locations": http_array_safe(locations),
      "roles": http_array_safe(roles),
      "sub_step": $rootScope.current_sub_step.identify_name,
    };
    $scope.offerTable.tbl.linkServerPostData($scope.offerTable.tbl, data);
  };

  $scope.offerTable.tbl.successDo = function(data){
    if(data.success){
      $scope.permission_to_active = data.permission_to_active;
      $scope.show_import_offer_page = data.show_import_offer_page;
      $scope.show_change_offered_response = data.show_change_offered_response;
      $scope.location_list = data.location_list;
      $scope.role_list = data.role_list;
    }
    else{
      $rootScope.rsasAlert({type: 'danger', msg: data.msg});
    }

  };

  $scope.email_init = function(){
    $scope.rsas_email = {
      recipients : [],
      cc : [],
      bcc : [],
      subject: "",
      content: "",
    };
  };

  $scope.position_applicants_status = function(position) {
    var auto_match_applicants = [];
    $scope.readt_to_offer_applicants = [];
    $scope.offer_applicants = [];
    $scope.accepted_applicants = [];
    $scope.decliend_applicants = [];
    for(i = 0; i < position.applicants.length; i ++) {
      if(position.applicants[i].auto_match){
        auto_match_applicants.push(position.applicants[i].name);
      }
      if(($rootScope.current_sub_step.identify_name == 'offer' && position.applicants[i].offered == 'pre_offered') || ($rootScope.current_sub_step.identify_name != 'offer' && position.applicants[i].offered == 'post_pre_offered')){
        $scope.readt_to_offer_applicants.push(position.applicants[i].name);
      }
      else if(($rootScope.current_sub_step.identify_name == 'offer' && position.applicants[i].offered == 'offered') || ($rootScope.current_sub_step.identify_name != 'offer' && position.applicants[i].offered == 'post_offered')){
        $scope.offer_applicants.push(position.applicants[i].name);
        if(position.applicants[i].offer_accept == 'accepted'){
          $scope.accepted_applicants.push(position.applicants[i].name);
        }
        else if(position.applicants[i].offer_accept == 'rejected'){
          $scope.decliend_applicants.push(position.applicants[i].name);
        }
      }
    };

    return auto_match_applicants.join(", ");
  };

  $scope.checkbox_limit = function(applicants, vacancy){
    if($rootScope.current_sub_step.identify_name == 'offer'){
      if(findObjs(applicants, "pre_offered", true).length >= vacancy)
        return true;
      else
        return false;
    }
    else{
      var i = 0;
      angular.forEach(applicants, function(applicant) {
        if(applicant.pre_offered == true && applicant.offer_accept != 'rejected'){
          i ++;
        }
      });
      return i >= vacancy;
    }
  };

  $scope.copy_offer_applicants = function() {
    $scope.editing_offer = angular.copy(this.tblTr);
    $scope.update_offer = this.tblTr;
    $scope.editing_offer.search_name = '';
  };

  $scope.pre_offer_applicants = function() {
    waitingIcon.open();
    arr = [];
    angular.forEach($scope.editing_offer.applicants, function(applicant, key) {
      if(applicant.pre_offered && applicant.offered != 'offered' && applicant.offered != 'post_offered') {
        arr.push(applicant.application_id);
      };
    });
    offerFactory.preOfferApplicant(arr.join(", "), $scope.editing_offer.id, $rootScope.current_year.id, $rootScope.current_process.id, $rootScope.current_sub_step.identify_name).success(function (data) {
      if(data.success){
        $scope.editing_offer.applicants = data.applicants;
        angular.extend($scope.update_offer, $scope.editing_offer);
        if (data.pre_offer_fail_list.length > 0){
          $scope.pre_offer_fail_list = data.pre_offer_fail_list;
          $("#preOfferFailList").modal('toggle');
        }
        else{
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
        }
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to update the Offer.'});
      waitingIcon.close();
    });
  };

  $scope.get_offer_all_list = function() {
    waitingIcon.open();
    $scope.editing_offer = angular.copy(this.tblTr);
    $scope.update_offer = this.tblTr;
    $scope.offer_all_list = {};
    $scope.offer_all_list.id = this.tblTr.id;
    $scope.offer_all_list.vacancy = this.tblTr.vacancy;
    offerFactory.offerAllList($scope.editing_offer.id, $rootScope.current_year.id, $rootScope.current_process.id, $rootScope.current_sub_step.identify_name).success(function (data) {
      if(data.success){
        $scope.offer_all_list.applicants = data.applicants;
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: 'Failed to get the offer all list.'});
      };
      waitingIcon.close();
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: 'Failed to get the offer all list.'});
      waitingIcon.close();
    });
  };

  $scope.pre_offer_all = function() {
    waitingIcon.open();
    arr = [];
    angular.forEach($scope.offer_all_list.applicants, function(applicant, key) {
      if(applicant.pre_offered && applicant.offered != 'offered' && applicant.offered != 'post_offered') {
        arr.push(applicant.user_id);
      };
    });
    offerFactory.preOfferAll(arr.join(", "), $scope.offer_all_list.id, $rootScope.current_year.id, $rootScope.current_process.id, $rootScope.current_sub_step.identify_name).success(function (data) {
      if(data.success){
        $scope.editing_offer.applicants = data.applicants;
        angular.extend($scope.update_offer, $scope.editing_offer);
        if (data.pre_offer_fail_list.length > 0){
          $scope.pre_offer_fail_list = data.pre_offer_fail_list;
          $("#preOfferFailList").modal('toggle');
        }
        else {
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
        }
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      };
      waitingIcon.close();
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem to update the offer all.'});
      waitingIcon.close();
    });
  };

  $scope.email_edit = function(){
    $scope.editing_offer = angular.copy(this.tblTr);
    $scope.update_offer = this.tblTr;
    $scope.rsas_email.recipients = [];
    waitingIcon.open();
    offerFactory.positionOfferedList($scope.editing_offer.id, $rootScope.current_year.id, $rootScope.current_process.id, $rootScope.current_sub_step.identify_name).success(function (data) {
      if(data.success){
        angular.forEach(data.applicants, function(applicant) {
          $scope.rsas_email.recipients.push({"name": applicant.user.name, "email": applicant.user.email, "is_constant": true});
        });
        if ($scope.rsas_email.recipients.length > 0){
          $("#editEmail").modal('toggle');
        }
        else{
          $rootScope.defaultDialog("Warning: You haven't selected any applicants to offer. Please select applicants first and try again.");
        };
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: 'Failed to get the offered list.'});
      };
      waitingIcon.close();
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: 'Failed to get the offered list.'});
      waitingIcon.close();
    });
  };

  $scope.email_send = function(){
    if (!$scope.quick_send){
      waitingIcon.open();
      offerFactory.sendOfferedEmail($scope.editing_offer.id, $scope.rsas_email, $rootScope.current_year.id, $rootScope.current_process.id, $rootScope.current_sub_step.identify_name)
      .success(function (data) {
        if(data.success){
          $scope.editing_offer.applicants = data.applicants;
          angular.extend($scope.update_offer, $scope.editing_offer);
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
    }
    else {
      $scope.quick_send_offer();
    }
  };

  $scope.reloadTable = function(){
    $scope.offerTable.tbl.searchClick($scope.offerTable.tbl);
  };

  $scope.quick_send_offer_list = function(){
    waitingIcon.open();
    var arr = [];
    angular.forEach($scope.offerTable.tbl.show, function(position, key) {
      arr.push(position.id);
    });
    offerFactory.quickSendOfferList(arr, $rootScope.current_year.id, $rootScope.current_process.id, $rootScope.current_sub_step.identify_name)
    .success(function (data) {
      if(data.success){
        $scope.rsas_email.recipients = data.recipients;
        if($scope.rsas_email.recipients.length > 0){
          $("#editEmail").modal('toggle');
          $scope.quick_send = true;
        }
        else{
          $rootScope.rsasAlert({type: 'success', msg: "All selected applicants have been offered."});
        }
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: "Get Email failure"});
      waitingIcon.close();
    });
  };

  $scope.quick_send_offer = function(){
    waitingIcon.open();
    var arr = [];
    angular.forEach($scope.offerTable.tbl.show, function(position, key) {
      arr.push(position.id);
    });
    offerFactory.quickSendOffer(arr, $scope.rsas_email, $rootScope.current_year.id, $rootScope.current_process.id, $rootScope.current_sub_step.identify_name)
    .success(function (data) {
      if(data.success){
        $rootScope.rsasAlert({type: 'success', msg: data.msg});
        $scope.reloadTable();
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
      $("#editEmail").modal('toggle');
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: "Email delivery failure"});
      waitingIcon.close();
      $("#editEmail").modal('toggle');
    });
    $scope.quick_send = false;
  };

  $scope.getOfferedResponseApplicants = function(position_id){
    $scope.change_offered_response = {};
    waitingIcon.open();
    offerFactory.getOfferedResponseApplicants(position_id, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function (data) {
      if(data.success){
        $scope.change_offered_response.applications = data.applications;
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to get the list."});
      waitingIcon.close();
      $("#ChangeOfferedResponse").modal('hide');
    });

  };

  $scope.updateOfferedResponse = function(){
    waitingIcon.open();
    offerFactory.updateOfferedResponse($scope.change_offered_response.applications, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function (data) {
      if(data.success){
        $rootScope.rsasAlert({type: 'success', msg: data.msg});
        $scope.reloadTable();
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      }
      waitingIcon.close();
      $("#ChangeOfferedResponse").modal('hide');
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to update the response."});
      waitingIcon.close();
      $("#ChangeOfferedResponse").modal('hide');
    });
    $scope.quick_send = false;
  };

  angular.element(document).ready(function () {
    if($rootScope.isRunNowProcess){
      $scope.offerTable.tbl.init($scope, $scope.offerTable.tbl);
      $scope.email_init();
      offerFactory.getOfferEmailTemplate($rootScope.current_year.id, $rootScope.current_process.id).success(function (data) {
        if(data.success){
          $scope.rsas_email.content = data.mail_template.content;
          $scope.rsas_email.subject = data.mail_template.title;
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: 'Failed to get the offer email template.'});
        }
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: 'Failed to get the offer email template.'});
      });
    }
  });
});

//#################################################################################################################################################################################################

rsasApp.controller('UserOffers',function($scope, $rootScope, $sce, waitingIcon, offerFactory) {

  angular.element(document).ready(function () {
    if($rootScope.isRunNowProcess){
      waitingIcon.open();
      $scope.offers = [];
      $scope.bSelectOffer = false;
      offerFactory.userOfferList($rootScope.current_year.id, $rootScope.current_process.id, $rootScope.applicant_sub_step.identify_name)
      .success(function(data){
        $scope.offers = data.offer;
        $scope.selected = data.selected;
        $scope.permission_to_active = data.permission_to_active;
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the offer list."});
        waitingIcon.close();
      });
    }
  });

  $scope.to_html = function(str) {
    return $sce.trustAsHtml(str);
  };

  $scope.check_again = function(offer, result){
    $scope.current_applicant = offer;
    $scope.bSelectOffer = true;
    $scope.bSelectAccept = result;
    $scope.bSelectDecline = !result;
  };

  $scope.submitOffer = function(offer, result){
    $scope.current_applicant = offer;
    $scope.submitResult(result);
  };

  $scope.cancelSelectOffer = function(){
    $scope.current_applicant = null;
    $scope.bSelectOffer = false;
    $scope.bSelectAccept = false;
    $scope.bSelectDecline = false;
  };


  $scope.submitResult = function(result){
    waitingIcon.open();
    offerFactory.offerConfirm($scope.current_applicant.position_id, result, $rootScope.current_year.id, $rootScope.current_process.id, $rootScope.applicant_sub_step.identify_name)
    .success(function (data) {
      if(data.success){
        angular.extend($scope.current_applicant, data.offer);
        $scope.permission_to_active = data.permission_to_active;
        $scope.selected = true;
        if(data.success_html.length > 0){
          $scope.success_html = data.success_html;
          $("#success_dialog").modal('show');
          if($rootScope.current_process.name == 'House Staff Selection') {
            $scope.current_applicant.offer_msg = result ? "Congratulations! You have received an offer." : "You have declined the offer.";
          }
          else{
            $scope.current_applicant.offer_msg = data.offer.offer_msg;
          }
        }
        angular.forEach($scope.offers, function(offer){
          if($scope.current_applicant.position_name != offer.position_name) {
            offer.offer_msg = '';
          }
        });
      }
      else{
        $rootScope.rsasAlert({type: 'danger', msg: data.msg});
      };
      $scope.bSelectOffer = false;
      $scope.bSelectAccept = false;
      $scope.bSelectDecline = false;
      waitingIcon.close();
    })
    .error(function (data) {
      $rootScope.rsasAlert({type: 'danger', msg: "Failed to submit the result."});
      waitingIcon.close();
    });
  };

});
