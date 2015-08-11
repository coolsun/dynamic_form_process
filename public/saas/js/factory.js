var factoryModule = angular.module('factoryModule', []);

factoryModule.factory('applicantFactory', function($http){
    var urlBase = JSON_URL + "/applicants";
    var applicantFactory = {};

    applicantFactory.insertApply = function(current_year_id, current_process_id){
      return $http({
        url: urlBase,
        method: "POST",
        data: {"current_year_id": current_year_id, "current_process_id": current_process_id}
      });
    };
    applicantFactory.submitApplication = function(current_year_id, current_process_id){
      return $http({
          url: urlBase + '/submit_application',
          method: "POST",
          data: {"current_year_id": current_year_id, "current_process_id": current_process_id}
      });
    };
    applicantFactory.sendEmailToApplicants = function(email_info, current_year_id, current_process_id){
      return $http({
          url: urlBase + '/send_email_to_applicants',
          method: "POST",
          data: {
            "email_info": email_info,
            "current_year_id": current_year_id,
            "current_process_id": current_process_id
          }
      });
    };
    applicantFactory.applicantDisqualify = function(current_process_id, user_id){
      return $http({
        url : urlBase + "/applicant_disqualify",
        method : "POST",
        data : {
          "current_process_id" : current_process_id,
          "user_id" : user_id
        }
      });
    };
    applicantFactory.forceSubmitApplicant = function(user_id, current_year_id, current_process_id){
      return $http({
        url : urlBase + "/force_submit",
        method : "POST",
        data : {
          "user_id" : user_id,
          "current_year_id": current_year_id,
          "current_process_id" : current_process_id,
        }
      });
    };
    return applicantFactory;
});

factoryModule.factory('applicantTagFactory', function($http){
    var urlBase = JSON_URL + "/applicant_tags";
    var applicantTagFactory = {};

    applicantTagFactory.getApplicantTags = function(user_id, current_year_id, current_process_id){
      return $http({
        url: urlBase + "/get_applicant_tags",
        method: "GET",
        params: {
          "user_id": user_id,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    applicantTagFactory.updateApplicantTags = function(user_id, tags, current_year_id, current_process_id){
      return $http({
        url: urlBase + "/update_applicant_tags",
        method: "POST",
        data: {
          "user_id": user_id,
          "tags": http_array_safe(tags),
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };

    return applicantTagFactory;
});

factoryModule.factory('userFactory', function($http){
    var urlBase = JSON_URL + "/users";
    var userFactory = {};

    userFactory.insertUser = function(user, current_year_id, current_process_id){
      return $http({
        url: urlBase,
        method: "POST",
        data: {
          "user": user,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    userFactory.updateUser = function(user, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/' + user.id,
        method: "PUT",
        data: {
          "user": user,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    userFactory.deleteUser = function(id, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/' + id,
        method: "DELETE",
        params: {
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    userFactory.removeUser = function(id, current_year_id, current_process_id){
      return $http({
        url: urlBase + "/remove_user",
        method: "GET",
        params: {
          "user_id": id,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    userFactory.changeUser = function(id, current_year_id, current_process_id){
      return $http({
        url: urlBase + "/get_user_authority",
        method: "GET",
        params: {
          "user_id": id,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    userFactory.checkManager = function(current_year_id, current_process_id){
      return $http({
        url: urlBase + "/check_user_manager",
        method: "GET",
        params: {
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };

    return userFactory;
});

factoryModule.factory('locationFactory', function($http){
    var urlBase = JSON_URL + "/locations";
    var locationFactory = {};

    locationFactory.insertLocation = function(location, current_year_id, current_process_id){
      return $http({
        url: urlBase,
        method: "POST",
        data: {
          "location": location,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    locationFactory.updateLocation = function(location, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/' + location.id,
        method: "PUT",
        data: {
          "location":location,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    locationFactory.deleteLocation = function(id, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/' + id,
        method: "DELETE",
        params: {
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    return locationFactory;
});

factoryModule.factory('locationMgrFactory', function($http){
    var urlBase = JSON_URL + "/location_mgrs";
    var locationMgrFactory = {};

    locationMgrFactory.getSeletList = function(location_id, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/get_select_list',
        method: "GET",
        params: {
          "location_id": location_id,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    locationMgrFactory.updateLocationMgrs = function(location_id, add_ids, delete_ids, current_year_id, current_process_id){
      data = {
        "location_id": location_id,
        "add_ids": http_array_safe(add_ids),
        "delete_ids": http_array_safe(delete_ids),
        "current_year_id": current_year_id,
        "current_process_id": current_process_id
      };
      return $http({
        url: urlBase + '/update_location_mgrs',
        method: "POST",
        data: data
      });
    };
    return locationMgrFactory;
});

factoryModule.factory('hiringMgrFactory', function($http){
    var urlBase = JSON_URL + "/procedure_mgrs";
    var hiringMgrFactory = {};

    hiringMgrFactory.getSeletList = function(procedure_id, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/get_select_list',
        method: "GET",
        params: {
          "procedure_id": procedure_id,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    hiringMgrFactory.updateHiringMgrs = function(procedure_id, add_ids, delete_ids, current_year_id, current_process_id){
      data = {
        "procedure_id": procedure_id,
        "add_ids": http_array_safe(add_ids),
        "delete_ids": http_array_safe(delete_ids),
        "current_year_id": current_year_id,
        "current_process_id": current_process_id
      };
      return $http({
        url: urlBase + '/update_procedure_mgrs',
        method: "POST",
        data: data
      });
    };
    return hiringMgrFactory;
});

factoryModule.factory('rdMgrFactory', function($http){
    var urlBase = JSON_URL + "/rd_mgrs";
    var rdMgrFactory = {};

    rdMgrFactory.getSeletList = function(procedure_id, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/get_select_list',
        method: "GET",
        params: {
          "procedure_id": procedure_id,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    rdMgrFactory.updateRdMgrs = function(procedure_id, add_ids, delete_ids, current_year_id, current_process_id){
      data = {
        "procedure_id": procedure_id,
        "add_ids": http_array_safe(add_ids),
        "delete_ids": http_array_safe(delete_ids),
        "current_year_id": current_year_id,
        "current_process_id": current_process_id
      };
      return $http({
        url: urlBase + '/update_rd_mgrs',
        method: "POST",
        data: data
      });
    };
    return rdMgrFactory;
});

factoryModule.factory('applyWhiteListFactory', function($http){
    var urlBase = JSON_URL + "/apply_white_lists";
    var applyWhiteListFactory = {};

    applyWhiteListFactory.getWhiteList = function(current_year_id, current_process_id){
      return $http({
        url: urlBase,
        method: "GET",
        params: {
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    applyWhiteListFactory.createApplyWhiteList = function(user, current_year_id, current_process_id){
      data = {
        "user": user,
        "current_year_id": current_year_id,
        "current_process_id": current_process_id
      };
      return $http({
        url: urlBase,
        method: "POST",
        data: data
      });
    };
    applyWhiteListFactory.deleteApplyWhiteList = function(id, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/' + id,
        method: "DELETE",
        params: {
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    return applyWhiteListFactory;
});

factoryModule.factory('roleFactory', function($http){
    var urlBase = JSON_URL + "/roles";
    var roleFactory = {};

    roleFactory.insertRole = function(role, current_year_id, current_process_id){
      return $http({
        url: urlBase,
        method: "POST",
        data: {
          "role": role,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    roleFactory.updateRole = function(role, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/' + role.id,
        method: "PUT",
        data: {
          "role": role,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    roleFactory.deleteRole = function(id, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/' + id,
        method: "DELETE",
        params: {
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    return roleFactory;
});

factoryModule.factory('roleMgrFactory', function($http){
    var urlBase = JSON_URL + "/role_mgrs";
    var roleMgrFactory = {};

    roleMgrFactory.getSeletList = function(role_id, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/get_select_list',
        method: "GET",
        params: {
          "role_id": role_id,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    roleMgrFactory.updateRoleMgrs = function(role_id, add_ids, delete_ids, current_year_id, current_process_id){
      data = {
        "role_id": role_id,
        "add_ids": http_array_safe(add_ids),
        "delete_ids": http_array_safe(delete_ids),
        "current_year_id": current_year_id,
        "current_process_id": current_process_id
      };
      return $http({
        url: urlBase + '/update_role_mgrs',
        method: "POST",
        data: data
      });
    };
    return roleMgrFactory;
});

factoryModule.factory('positionFactory', function($http){
    var urlBase = JSON_URL + "/positions";
    var positionFactory = {};

    positionFactory.insertPosition = function(position, current_year_id, current_process_id){
      return $http({
        url: urlBase,
        method: "POST",
        data: {
          "position": position,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    positionFactory.updatePosition = function(position, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/' + position.id,
        method: "PUT",
        data: {
          "position":position,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    positionFactory.deletePosition = function(id, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/' + id,
        method: "DELETE",
        params: {
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    positionFactory.getSelectLists = function(current_year_id, current_process_id){
      return $http({
        url: urlBase + '/get_select_lists',
        method: "GET",
        params: {
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    positionFactory.invitationCreatePosition = function(position, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/invitation_create_position',
        method: "POST",
        data: {
          "position": position,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    return positionFactory;
});

factoryModule.factory('interviewFactory', function($http) {
    var interviewFactory = {};
    interviewURL = JSON_URL + "/interviews/";

    interviewFactory.adminCalendarView = function(params){
      return (
        $http({
          url: interviewURL + "/admin_calendar_view/",
          method: "GET",
          params: params
        })
      );
    };

    interviewFactory.getProcessPositions = function(p, current_year_id, current_process_id){
      return (
        $http({
          url: interviewURL + "/get_procedure_positions/",
          method: "GET",
          params: {
            p:p,
            "current_year_id": current_year_id,
            "current_process_id": current_process_id
          }
        })
      );
    };

    interviewFactory.getProcessRounds = function(p, current_year_id, current_process_id){
      return (
        $http({
          url: interviewURL + "/get_procedure_rounds/",
          method: "GET",
          params: {
            p:p,
            "current_year_id": current_year_id,
            "current_process_id": current_process_id
          }
        })
      );
    };

    interviewFactory.getProcessRoundInterviews = function(p, current_year_id, current_process_id){
      return (
        $http({
          url: interviewURL + "/get_procedure_round_interviews/",
          method: "GET",
          params: {
            p:p,
            "current_year_id": current_year_id,
            "current_process_id": current_process_id
          }
        })
      );
    };

    interviewFactory.getRoundInterviews = function(roundId, current_year_id, current_process_id){
      return (
        $http({
          url: interviewURL + "/get_round_interviews/",
          method: "GET",
          params: {
            roundId:roundId,
            "current_year_id": current_year_id,
            "current_process_id": current_process_id
          }
        })
      );
    };

    interviewFactory.getRoundAdminSelectedInterviews = function(roundId, current_year_id, current_process_id){
      return (
        $http({
          url: interviewURL + "/get_round_admin_selected_interviews/",
          method: "GET",
          params: {
            roundId:roundId,
            "current_year_id": current_year_id,
            "current_process_id": current_process_id
          }
        })
      );
    };

    interviewFactory.getRoundInterviewTimeSlots = function(roundId, current_year_id, current_process_id){
      return (
        $http({
          url: interviewURL + "/get_round_interview_time_slots/",
          method: "GET",
          params: {
            roundId:roundId,
            "current_year_id": current_year_id,
            "current_process_id": current_process_id
          }
        })
      );
    };

    interviewFactory.getOneRound = function(roundId, current_year_id, current_process_id){
      return (
        $http({
          url: interviewURL + "/get_one_round/",
          method: "GET",
          params: {
            roundId:roundId,
            "current_year_id": current_year_id,
            "current_process_id": current_process_id
          }
        })
      );
    };

    interviewFactory.getPositions = function(interviewId, current_year_id, current_process_id, roundId){
      return (
        $http({
          url: interviewURL + "/get_positions/",
          method: "POST",
          data: {
            "interviewId": interviewId,
            "current_year_id": current_year_id,
            "current_process_id": current_process_id,
            round_id: roundId
          }
        })
      );
    };

    interviewFactory.getInterviewers = function(interviewId, current_year_id, current_process_id){
      return (
        $http({
          url: interviewURL + "/get_interviewers/",
          method: "GET",
          params: {
            interviewId: interviewId,
            "current_year_id": current_year_id,
            "current_process_id": current_process_id
          }
        })
      );
    };

    interviewFactory.getApplicantList = function(interviewId, current_year_id, current_process_id){
      return (
        $http({
          url: interviewURL + "/get_applicant_list/",
          method: "GET",
          params: {
            interviewId: interviewId,
            "current_year_id": current_year_id,
            "current_process_id": current_process_id
          }
        })
      );
    };

    interviewFactory.getInterviewApplicantList = function(interviewId, current_year_id, current_process_id, current_user_status){
      return (
        $http({
          url: interviewURL + "/get_interview_applicant_list/",
          method: "GET",
          params: {
            interviewId: interviewId,
            "current_user_status": current_user_status,
            "current_year_id": current_year_id,
            "current_process_id": current_process_id
          }
        })
      );
    };

    interviewFactory.getInterviewTimeList = function(interviewId, current_year_id, current_process_id){
      return (
        $http({
          url: interviewURL + "/get_interview_time_list/",
          method: "GET",
          params: {
            interviewId: interviewId,
            "current_year_id": current_year_id,
            "current_process_id": current_process_id
          }
        })
      );
    };

    interviewFactory.newInterview = function(postData){
      return (
        $http({
          url: interviewURL,
          method: "POST",
          data: postData
        })
      );
    };

    interviewFactory.editInterview = function(postData, interviewId){
      return (
        $http({
          url: interviewURL + interviewId,
          method: "PUT",
          data: postData
        })
      );
    };

    interviewFactory.deleteInterview = function(interviewId, current_year_id, current_process_id){
      return (
        $http({
          url: interviewURL + interviewId,
          method: "DELETE",
          params: {
            "current_year_id": current_year_id,
            "current_process_id": current_process_id
          }
        })
      );
    };

    interviewFactory.setPositions = function(postData){
      return (
        $http({
          url: interviewURL + "/set_positions/",
          method: "POST",
          data: postData
        })
      );
    };

    interviewFactory.setInterviewers = function(postData){
      return (
        $http({
          url: interviewURL + "/set_interviewers/",
          method: "POST",
          data: postData
        })
      );
    };

    interviewFactory.setInvitees = function(postData){
      return (
        $http({
          url: interviewURL + "/set_invitees/",
          method: "POST",
          data: postData
        })
      );
    };

    interviewFactory.setTimeSlots = function(postData){
      return (
        $http({
          url: interviewURL + "/set_time_slots/",
          method: "POST",
          data: postData
        })
      );
    };

    interviewFactory.userCalendarView = function(params){
      return (
        $http({
          url: interviewURL + "/user_process_calendar_view/",
          method: "GET",
          params: params
        })
      );
    };

    interviewFactory.sendEmailToApplicants = function(email_info, current_year_id, current_process_id){
      return $http({
        url: interviewURL + '/send_email_to_applicants',
        method: "POST",
        data: {
          "email_info": email_info,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };

    interviewFactory.sendEmailToInterviewers = function(email_info, current_year_id, current_process_id){
      return $http({
        url: interviewURL + '/send_email_to_interviewers',
        method: "POST",
        data: {
          "email_info": email_info,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };

    interviewFactory.getInterviewScheduledApplicants = function(interviewId, current_year_id, current_process_id){
      return (
        $http({
          url: interviewURL + "/get_interview_scheduled_applicants/",
          method: "GET",
          params: {
            interviewId: interviewId,
            "current_year_id": current_year_id,
            "current_process_id": current_process_id
          }
        })
      );
    };

    interviewFactory.getInterviewSelectApplicants = function(interviewId, current_year_id, current_process_id){
      return (
        $http({
          url: interviewURL + "/get_interview_selected_applicants/",
          method: "GET",
          params: {
            interviewId: interviewId,
            "current_year_id": current_year_id,
            "current_process_id": current_process_id
          }
        })
      );
    };

    return interviewFactory;
});

factoryModule.factory('intervieweeFactory', function($http) {
    var intervieweeFactory = {};

    intervieweeURL = JSON_URL + "/interviewees/";

    intervieweeFactory.reserve = function(postData){
      return (
        $http({
          url: intervieweeURL,
          method: "POST",
          data: postData
        })
      );
    };

    intervieweeFactory.cancel = function(timeSlotId, current_year_id, current_process_id){
      return (
        $http({
          url: intervieweeURL + timeSlotId,
          method: "DELETE",
          params: {
            "current_year_id": current_year_id,
            "current_process_id": current_process_id
          }
        })
      );
    };

    return intervieweeFactory;
});

factoryModule.factory('timeSlotInterviewerFactory', function($http) {
    var timeSlotInterviewerFactory = {};

    timeSlotInterviewerURL = JSON_URL + "/time_slot_interviewers/";

    timeSlotInterviewerFactory.signup = function(postData){
      return (
        $http({
          url: timeSlotInterviewerURL,
          method: "POST",
          data: postData
        })
      );
    };

    timeSlotInterviewerFactory.cancel = function(timeSlotInterviewerId, current_year_id, current_process_id){
      return (
        $http({
          url: timeSlotInterviewerURL + timeSlotInterviewerId,
          method: "DELETE",
          params: {
            "current_year_id": current_year_id,
            "current_process_id": current_process_id
          }
        })
      );
    };

    return timeSlotInterviewerFactory;
});

factoryModule.factory('recommendationSettingFactory', function($http){
    var urlBase = JSON_URL + "/recommendation_settings";
    var recommendationSettingFactory = {};

    recommendationSettingFactory.showRecommendationSetting = function(id, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/get_setting',
        method: "POST",
        data: {
          "procedure_id" : id,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    recommendationSettingFactory.updateRecommendationSetting = function(recommendation_setting, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/' + recommendation_setting.id,
        method: "PUT",
        data: {
          "recommendation_setting" : recommendation_setting,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    return recommendationSettingFactory;
});

factoryModule.factory('recommendationRecordFactory', function($http){
    var urlBase = JSON_URL + "/recommendation_records";
    var recommendationRecordFactory = {};

    recommendationRecordFactory.showRecordList = function(user_id, current_year_id, current_process_id){
      return $http({
        url: urlBase,
        method: "GET",
        params: {
          "user_id" : user_id,
          "current_year_id" : current_year_id,
          "current_process_id" : current_process_id
        }
      });
    };
    recommendationRecordFactory.sendRecommendation = function(user_id, procedure_id, request, request_date, current_year_id){
      return $http({
        url: urlBase,
        method: "POST",
        data: {
          "user_id" : user_id,
          "procedure_id" : procedure_id,
          "name" : request.name,
          "title" : request.title,
          "relationship" : request.relationship,
          "email" : request.email,
          "recommendation_form_id" : request.recommendation_form_id,
          "request_date" : request_date ,
          "current_year_id" : current_year_id,
          "current_process_id" : procedure_id
        },
      });
    };
    recommendationRecordFactory.resendRecommandation = function(record_id, current_year_id, current_process_id){
      return $http({
        url : urlBase + "/send_reminder_email",
        method : "POST",
        data : {
          "recommendation_record_id" : record_id,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    recommendationRecordFactory.disableRecord = function(record_id, current_year_id, current_process_id){
      return $http({
        url : urlBase + "/" + record_id,
        method : "PUT",
        data : {
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    return recommendationRecordFactory;
});

factoryModule.factory('recommendationFormFactory', function($http){
    var urlBase = JSON_URL + "/recommendation_forms";
    var recommendationFormFactory = {};

    recommendationFormFactory.showRecommendationForm = function(recommendationFormId){
      return $http({
          url: urlBase + "/" + recommendationFormId,
          method: "GET"
      });
    };
    recommendationFormFactory.getRecommendationForm = function(rid, token, key){
      return $http({
        url : urlBase,
        method : "GET",
        params : {
          "rid" : rid,
          "token" : token,
          "key" : key
        }
      });
    };
    recommendationFormFactory.fillRecommendationForm = function(recommendation_record_id, form_name, schema, submit_datetime, show_for_std_interviewers){
      return $http({
        url : urlBase + "/fill_recommendation_form",
        method : "POST",
        data : {
          "recommendation_record_id" : recommendation_record_id,
          "form_name" : form_name,
          "schema" : schema,
          "submit_datetime" : submit_datetime,
          "show_for_std_interviewers" : show_for_std_interviewers
        }
      });
    };
    return recommendationFormFactory;
});

factoryModule.factory('processFactory', function($http){
    var urlBase = JSON_URL + "/procedures";
    var processFactory = {};

    processFactory.getProcess = function(process_id, current_year_id, current_process_id){
      return $http({
        url: urlBase + "/" + process_id,
        method: "GET",
        params: {
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    processFactory.insertProcess = function(process, current_year_id, current_process_id){
      return $http({
        url: urlBase,
        method: "POST",
        data: {
          "procedure": process,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    processFactory.updateProcess = function(process, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/' + process.id,
        method: "PUT",
        data: {
          "procedure": process,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    processFactory.deleteProcess = function(id, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/' + id,
        method: "DELETE",
        params: {
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    processFactory.cloneProcess = function(process, clone_process_id, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/clone_process',
        method: "POST",
        data: {
          "procedure": process,
          "clone_process_id": clone_process_id,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    processFactory.cloneAllProcess = function(source_year_id, target_year_id, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/clone_all_process',
        method: "GET",
        params:{
          "source_year_id": source_year_id,
          "target_year_id": target_year_id,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    processFactory.checkRecommendationFormOpen = function(process_id, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/check_recommendation_form_open',
        method: "POST",
        data:{
          "procedure_id": process_id,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    processFactory.mgrProceduresSelect = function(current_year_id, current_process_id){
      return $http({
        url: urlBase + '/mgr_procedures_select',
        method: "GET",
        params:{
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    return processFactory;
});

factoryModule.factory('processStepFactory', function($http){
    var urlBase = JSON_URL + "/procedure_steps";
    var processStepFactory = {};
    /*
    processStepFactory.getProcessStep = function(current_year_id, current_process_id, current_user_id){
      return $http({
        url: urlBase + "/show_procedure_steps",
        method: "POST",
        data: {
          "current_user_id": current_user_id,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    */

    processStepFactory.getManagerProcessStep = function(current_year_id, current_process_id, current_user_id){
      return $http({
        url: urlBase + "/show_manager_procedure_steps",
        method: "POST",
        data: {
          "current_user_id": current_user_id,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };

    processStepFactory.getApplicantProcessStep = function(current_year_id, current_process_id, current_user_id){
      return $http({
        url: urlBase + "/show_applicant_procedure_steps",
        method: "POST",
        data: {
          "current_user_id": current_user_id,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };

    processStepFactory.updateProcessStep = function(processStep, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/' + processStep.id,
        method: "PUT",
        data: {
          "procedure_step": processStep,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id

        }
      });
    };
    processStepFactory.getApplicantStatus = function(current_year_id, current_process_id){
      return $http({
        url: urlBase + "/applicant_status",
        method: "POST",
        data: {
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    processStepFactory.getStepLanding = function(step_name, current_year_id, current_process_id){
      return $http({
        url: urlBase + "/get_step_landing",
        method: "GET",
        params: {
          "step_name": step_name,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    processStepFactory.updateStepLanding = function(step_name, landing, current_year_id, current_process_id){
      return $http({
        url: urlBase + "/update_step_landing",
        method: "POST",
        data: {
          "step_name": step_name,
          "landing": landing,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    return processStepFactory;
});

factoryModule.factory('processSubStepFactory', function($http){
    var urlBase = JSON_URL + "/procedure_sub_steps";
    var processSubStepFactory = {};

    processSubStepFactory.updateProcessSubStep = function(processSubStep, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/' + processSubStep.id,
        method: "PUT",
        data: {
          "procedure_sub_step": processSubStep,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    processSubStepFactory.updateSubStepsTime = function(step_time, sub_steps_time, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/update_sub_steps_time',
        method: "POST",
        data: {
          "step_time": step_time,
          "sub_steps_time": sub_steps_time,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    return processSubStepFactory;
});

factoryModule.factory('processHelpLandingFactory', function($http){
    var urlBase = JSON_URL + "/procedure_help_landings";
    var processHelpLandingFactory = {};
    processHelpLandingFactory.getHelpLandings = function(process_id, current_year_id, current_process_id){
      return $http({
        url: urlBase,
        method: "GET",
        params:{
          "procedure_id": process_id,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    processHelpLandingFactory.addHelpLanding = function(new_help, process_id, current_year_id, current_process_id){
      return $http({
        url: urlBase,
        method: "POST",
        data:{
          "new_help": new_help,
          "procedure_id": process_id,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    processHelpLandingFactory.updateHelpLanding = function(old_help, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/' + old_help.id,
        method: "PUT",
        data:{
          "old_help": old_help,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    processHelpLandingFactory.deleteHelpLanding = function(delete_help_id, process_id, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/' + delete_help_id,
        method: "DELETE",
        params:{
          "procedure_id": process_id,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    return processHelpLandingFactory;
});

factoryModule.factory('applicationFactory', function($http){
    var urlBase = JSON_URL + "/applications";
    var applicationFactory = {};

    applicationFactory.getSelectPositionList = function(current_year_id, current_process_id, sub_step){
      return $http({
        url: urlBase + '/get_select_position_list',
        method: "GET",
        params: {
          "current_year_id": current_year_id,
          "current_process_id": current_process_id,
          "sub_step": sub_step
        }
      });
    };
    applicationFactory.updatePositionsSelect = function(add_ids, delete_ids, current_year_id, current_process_id, sub_step){
      return $http({
        url: urlBase + '/update_positions_select',
        method: "POST",
        data: {
          "add_ids": http_array_safe(add_ids),
          "delete_ids": http_array_safe(delete_ids),
          "current_year_id": current_year_id,
          "current_process_id": current_process_id,
          "sub_step": sub_step
        }
      });
    };
    applicationFactory.getSelectPositionSettings = function(current_year_id, current_process_id){
      return $http({
        url: urlBase + '/get_select_position_settings',
        method: "GET",
        params: {
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    applicationFactory.updateSelectPositionSettings = function(select_position_settings, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/update_select_position_settings',
        method: "POST",
        data: {
          "select_position_settings" : select_position_settings,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    applicationFactory.manualPositionsList = function(current_year_id, current_process_id, user_id){
      return $http({
        url: urlBase + '/manual_positions_list',
        method: "POST",
        data: {
          "current_year_id": current_year_id,
          "current_process_id": current_process_id,
          "user_id": user_id
        }
      });
    };
    applicationFactory.manualUpdatePositions = function(user_id, add_ids, delete_ids, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/manual_update_positions',
        method: "POST",
        data: {
          "user_id": user_id,
          "add_ids": http_array_safe(add_ids),
          "delete_ids": http_array_safe(delete_ids),
          "current_year_id": current_year_id,
          "current_process_id": current_process_id,
        }
      });
    };
    return applicationFactory;
});

factoryModule.factory('rankingFactory', function($http){
    var urlBase = JSON_URL + "/ranking";
    var rankingFactory = {};

    rankingFactory.getUserRankList = function(current_year_id, current_process_id){
      return $http({
        url: urlBase + '/get_user_rank_list',
        method: "GET",
        params: {
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };

    rankingFactory.updateUserRank = function(user_rank_list, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/update_user_rank',
        method: "POST",
        data: {
          "user_rank_list": user_rank_list,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };

    rankingFactory.getMgrRankList = function(selected_location_id, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/get_mgr_rank_list',
        method: "GET",
        params: {
          "selected_location_id": selected_location_id,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };

    rankingFactory.updateMgrRank = function(mgr_rank_list, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/update_mgr_rank',
        method: "POST",
        data: {
          "mgr_rank_list": mgr_rank_list,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };

    return rankingFactory;
});

factoryModule.factory('matchingFactory', function($http){
    var urlBase = JSON_URL + "/matching";
    var matchingFactory = {};

    matchingFactory.match = function(match_conditions, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/match',
        method: "POST",
        data: {
          "match_conditions": match_conditions,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    matchingFactory.getMatchData = function(current_year_id, current_process_id){
      return $http({
        url: urlBase + '/get_match_data',
        method: "GET",
        params: {
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    return matchingFactory;
});

factoryModule.factory('formFactory', function($http){
    var urlBase = JSON_URL + "/forms";
    var formFactory = {};
    formFactory.getApplicationFormList = function(current_year_id, current_process_id){
      return $http({
        url: urlBase + '/get_application_form_list',
        method: "GET",
        params: {
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    formFactory.updateFormRank = function(form_rank, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/update_form_rank',
        method: "POST",
        data: {
          "form_rank": http_array_safe(form_rank),
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    return formFactory;
});

factoryModule.factory('userFormFactory', function($http){
    var urlBase = JSON_URL + "/user_forms";
    var userFormFactory = {};

    userFormFactory.showUserFilledForm = function(user_form_id, current_year_id, current_process_id){
      return $http({
        url: urlBase + "/" + user_form_id,
        method: "GET",
        params: {
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    userFormFactory.showUserFilledForms = function(current_year_id, current_process_id, sub_step){
      return $http({
        url: urlBase + '/show_user_filled_forms',
        method: "POST",
        data: {
          "current_year_id": current_year_id,
          "current_process_id": current_process_id,
          "sub_step": sub_step
        }
      });
    };
    userFormFactory.updateUserFilledForms = function(user_form, current_year_id, current_process_id, is_submit){
      return $http({
        url: urlBase + "/" + user_form.id,
        method: "PUT",
        data: {
          "user_form": user_form,
          "is_submit": is_submit,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    userFormFactory.showApplicantForms = function(system, application, recommendation, interview, transcripts, current_year_id, current_process_id){
      return $http({
        url: urlBase + "/applicant_forms",
        method: "POST",
        data: {
          "system": system,
          "application": application,
          "recommendation": recommendation,
          "interview": interview,
          "transcripts": transcripts,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    userFormFactory.getFormTranslations = function(){
      return $http({
        url: urlBase + "/form_translations",
        method: "GET"
      });
    };
    return userFormFactory;
});

factoryModule.factory('interviewEvaluateFactory', function($http){
    var urlBase = JSON_URL + "/interview_evaluates";
    var interviewEvaluateFactory = {};
    interviewEvaluateFactory.getEvaluateForms = function(current_year_id, current_process_id, interviewee_id, interview_id){
      return $http({
        url: urlBase + '/show_evaluate_forms',
        method: "POST",
        data: {
          "interviewee_id": interviewee_id,
          "interview_id": interview_id,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    interviewEvaluateFactory.saveEvaluateForm = function(form, current_year_id, current_process_id){
      return $http({
        url: urlBase + "/" + form.id,
        method: "PUT",
        data: {
          "interview_evaluate": form,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };

    interviewEvaluateFactory.getReviewForms = function(current_year_id, current_process_id, interviewee_id, interview_id){
      return $http({
        url: urlBase + '/show_review_forms',
        method: "POST",
        data: {
          "interviewee_id": interviewee_id,
          "interview_id": interview_id,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };




    return interviewEvaluateFactory;
});

factoryModule.factory('fileFactory', function($http){
    var urlBase = JSON_URL + "/files";
    var fileFactory = {};

    fileFactory.getFileList = function(form_id, form_type, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/form_file_list',
        method: "POST",
        data: {
          "form_id" : form_id,
          "type": form_type,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    fileFactory.deleteFile = function(id, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/' + id,
        method: "DELETE",
        params: {
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    fileFactory.getUploadFormsFiles = function(every_applicant_and_its_form_ids, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/download_forms_files',
        method: "POST",
        data: {
          "selected_forms": JSON.stringify(every_applicant_and_its_form_ids),
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    return fileFactory;
});

factoryModule.factory('offerFactory', function($http){
    var urlBase = JSON_URL + "/offer";
    var offerFactory = {};

    offerFactory.offerAllList = function(position_id, current_year_id, current_process_id, sub_step){
      return $http({
        url: urlBase + '/offer_all_list',
        method: "GET",
        params: {
          "position_id": position_id,
          "current_year_id": current_year_id,
        	"current_process_id": current_process_id,
          "sub_step": sub_step,
       }
      });
    };
    offerFactory.preOfferApplicant = function(application_ids, position_id, current_year_id, current_process_id, sub_step){
      return $http({
        url: urlBase + '/pre_offer_applicants',
        method: "POST",
        data: {
          "offer": {"position_id": position_id, "application_ids": application_ids},
          "current_year_id": current_year_id,
          "current_process_id": current_process_id,
          "sub_step": sub_step,
        }
      });
    };
    offerFactory.preOfferAll = function(ids, position_id, current_year_id, current_process_id, sub_step){
      return $http({
        url: urlBase + '/pre_offer_all',
        method: "POST",
        data: {
          "offer": {"position_id": position_id, "applicants": ids},
          "current_year_id": current_year_id,
          "current_process_id": current_process_id,
          "sub_step": sub_step,
        }
      });
    };
    offerFactory.userOfferList = function(current_year_id, current_process_id, sub_step){
      return $http({
        url: urlBase + '/user_offer_list',
        method: "GET",
        params: {
          "current_year_id": current_year_id,
          "current_process_id": current_process_id,
          "sub_step": sub_step,
        }
      });
    };
    offerFactory.positionOfferedList = function(position_id, current_year_id, current_process_id, sub_step){
      return $http({
        url: urlBase + '/position_pre_offered_list',
        method: "GET",
        params: {
          "position_id": position_id,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id,
          "sub_step": sub_step,
        }
      });
    };
    offerFactory.getOfferEmailTemplate = function(current_year_id, current_process_id){
      return $http({
          url: urlBase + '/offer_mail_template',
          method: "GET",
          params: {
            "current_year_id": current_year_id,
            "current_process_id": current_process_id
          }
      });
    };
    offerFactory.sendOfferedEmail = function(position_id, email_info, current_year_id, current_process_id, sub_step){
      return $http({
          url: urlBase + '/send_offered_email',
          method: "POST",
          data: {
            "position_id": position_id,
            "email_info": email_info,
            "current_year_id": current_year_id,
            "current_process_id": current_process_id,
            "sub_step": sub_step
          }
      });
    };
    offerFactory.offerConfirm = function(position_id, attitude, current_year_id, current_process_id, sub_step){
      return $http({
          url: urlBase + '/offer_confirm',
          method: "POST",
          data: {
            "position_id": position_id,
            "attitude": attitude,
            "current_year_id": current_year_id,
            "current_process_id": current_process_id,
            "sub_step": sub_step
          }
      });
    };
    offerFactory.quickSendOfferList = function(position_ids, current_year_id, current_process_id, sub_step){
      return $http({
          url: urlBase + '/quick_send_offer_list',
          method: "POST",
          data: {
            "positions": position_ids,
            "current_year_id": current_year_id,
            "current_process_id": current_process_id,
            "sub_step": sub_step
          }
      });
    };
    offerFactory.quickSendOffer = function(position_ids, email_info, current_year_id, current_process_id, sub_step){
      return $http({
          url: urlBase + '/quick_send_offer',
          method: "POST",
          data: {
            "positions": position_ids,
            "email_info": email_info,
            "current_year_id": current_year_id,
            "current_process_id": current_process_id,
            "sub_step": sub_step
          }
      });
    };
    offerFactory.getOfferedResponseApplicants = function(position_id, current_year_id, current_process_id){
      return $http({
          url: urlBase + '/get_offered_response_applicants',
          method: "get",
          params: {
            "position_id": position_id,
            "current_year_id": current_year_id,
            "current_process_id": current_process_id
          }
      });
    };
    offerFactory.updateOfferedResponse = function(applications, current_year_id, current_process_id){
      return $http({
          url: urlBase + '/update_offered_response',
          method: "POST",
          data: {
            "applications": applications,
            "current_year_id": current_year_id,
            "current_process_id": current_process_id
          }
      });
    };
    return offerFactory;
});

factoryModule.factory('postOfferFactory', function($http){
    var urlBase = JSON_URL + "/post_offer";
    var postOfferFactory = {};

    postOfferFactory.getOfferEmailTemplate = function(current_year_id, current_process_id){
      return $http({
          url: urlBase + '/post_offer_mail_template',
          method: "GET",
          params: {
            "current_year_id": current_year_id,
            "current_process_id": current_process_id
          }
      });
    };
    postOfferFactory.sendInviteEmail = function(position_id, email_info, current_year_id, current_process_id){
      return $http({
          url: urlBase + '/send_invite_email',
          method: "POST",
          data: {
            "position_id": position_id,
            "email_info": email_info,
            "current_year_id": current_year_id,
            "current_process_id": current_process_id
          }
      });
    };

    return postOfferFactory;
});

factoryModule.factory('mailerFactory', function($http){
    var urlBase = JSON_URL + "/email_templates";
    var mailerFactory = {};

    mailerFactory.getMailTemplate = function(ids, current_year_id, current_process_id){
      return $http({
        url: urlBase + "/get_template",
        method: "POST",
        data: {
          "eid": ids,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };

    mailerFactory.saveMailTemplate = function(emailTemplate, current_year_id, current_process_id){
      return $http({
        url: urlBase + "/" + emailTemplate.id,
        method: "PUT",
        data: {
          "email_template": emailTemplate,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };

    mailerFactory.createMailTemplate = function(emailTemplate, current_year_id, current_process_id){
      return $http({
        url: urlBase,
        method: "POST",
        data: {
          "title": emailTemplate.title,
          "content": emailTemplate.content,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };

    mailerFactory.sendMail = function(emailTemplate, mail_to, position_id, process_id, current_year_id, current_process_id){
      return $http({
        url: JSON_URL + "/mail" + "/send_mail",
        method: "POST",
        data: {
          "title": emailTemplate.title,
          "content": emailTemplate.content,
          "to": mail_to,
          "position_id": position_id,
          "process_id": process_id,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };

    return mailerFactory;
});



factoryModule.factory('timeSlotFactory', function($http) {
    var timeSlotFactory = {};
    timeSlotURL = JSON_URL + "/time_slots/";

    timeSlotFactory.timeSlotUpdate = function(postData, timeSlotId){
      return (
        $http({
          url: JSON_URL + "/time_slots/" + timeSlotId,
          method: "PUT",
          data: postData
        })
      );
    };

    timeSlotFactory.getInterviewers = function(timeSlotId, current_year_id, current_process_id){
      return (
        $http({
          url: JSON_URL + "/time_slots/get_interviewers/",
          method: "GET",
          params: {
            timeSlotId: timeSlotId,
            "current_year_id": current_year_id,
            "current_process_id": current_process_id
          }
        })
      );
    };

    timeSlotFactory.setInterviewers = function(postData){
      return (
        $http({
          url: "/time_slots/set_interviewers/",
          method: "POST",
          data: postData
        })
      );
    };

    timeSlotFactory.getApplicantList = function(timeSlotId, current_year_id, current_process_id){
      return (
        $http({
          url: "/time_slots/get_applicant_list/",
          method: "GET",
          params: {
            timeSlotId: timeSlotId,
            "current_year_id": current_year_id,
            "current_process_id": current_process_id
          }
        })
      );
    };

    timeSlotFactory.setInterviewees = function(postData){
      return (
        $http({
          url: "/time_slots/set_interviewees",
          method: "POST",
          data: postData
        })
      );
    };

    return timeSlotFactory;
});

factoryModule.factory('yearFactory', function($http){
    var urlBase = JSON_URL + "/years";
    var yearFactory = {};

    yearFactory.insertYear = function(year, current_year_id, current_process_id){
      return $http({
        url: urlBase,
        method: "POST",
        data: {
          "year": year,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    yearFactory.updateYear = function(year, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/' + year.id,
        method: "PUT",
        data: {
          "year":year,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    yearFactory.deleteYear = function(id, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/' + id,
        method: "DELETE",
        params: {
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    yearFactory.getYearList = function(current_year_id, current_process_id){
      return $http({
        url: urlBase + '/get_year_list',
        method: "GET",
        params: {
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    yearFactory.setCurrentYear = function(id, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/set_current_year',
        method: "GET",
        params: {
          "id": id,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    yearFactory.adminSwitchYear = function(id, current_year_id, current_process_id){
      return $http({
        url: urlBase + '/admin_switch_year',
        method: "GET",
        params: {
          "id": id,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    return yearFactory;
});

factoryModule.factory('formBuilderFactory', function($http){
    var urlBase = JSON_URL + "/forms";
    var formBuilderFactory = {};

    formBuilderFactory.showProcessForms = function(process_id, identify_name, current_year_id, current_process_id){
      return $http({
        url: urlBase + "/show_process_forms",
        method: "POST",
        data: {
          "process_id" : process_id,
          "identify_name" : identify_name,
          "current_year_id" : current_year_id,
          "current_process_id" : current_process_id
        }
      });
    };
    formBuilderFactory.editOldForm = function(id, process_id, identify_name, tag_type, selected, form_name, form, schema, current_year_id, current_process_id){
      return $http({
        url: urlBase + "/edit_old_form",
        method: "POST",
        data: {
          "id" : id,
          "process_id" : process_id,
          "identify_name" : identify_name,
          "tag_type" : tag_type,
          "selected" : selected,
          "form_name" : form_name,
          "form" : form,
          "schema" : schema,
          "current_year_id" : current_year_id,
          "current_process_id" : current_process_id
        }
      });
    };
    formBuilderFactory.saveNewForm = function(process_id, identify_name, tag_type, selected, form_name, form, schema, current_year_id, current_process_id){
      return $http({
        url: urlBase + "/save_new_form",
        method: "POST",
        data: {
          "process_id" : process_id,
          "identify_name" : identify_name,
          "tag_type" : tag_type,
          "selected" : selected,
          "form_name" : form_name,
          "display" : false,
          "form" : form,
          "schema" : schema,
          "current_year_id" : current_year_id,
          "current_process_id" : current_process_id
        },
      });
    };
    formBuilderFactory.deleteForm = function(id, process_id, identify_name, current_year_id, current_process_id){
      return $http({
        url: urlBase + "/delete_form",
        method: "POST",
        data: {
          "id" : id,
          "process_id" : process_id,
          "identify_name" : identify_name,
          "current_year_id" : current_year_id,
          "current_process_id" : current_process_id
        }
      });
    };
    formBuilderFactory.toggleShow = function(id, display, process_id, identify_name, current_year_id, current_process_id){
      return $http({
        url: urlBase + "/toggle_show",
        method: "POST",
        data: {
          "id" : id,
          "display" : display,
          "process_id" : process_id,
          "identify_name" : identify_name,
          "current_year_id" : current_year_id,
          "current_process_id" : current_process_id
        }
      });
    };
    formBuilderFactory.cloneForm = function(form, current_year_id, current_process_id){
      return $http({
        url: urlBase + "/clone_form",
        method: "POST",
        data: {
          "form_id": form.id,
          "current_year_id": current_year_id,
          "current_process_id": current_process_id
        }
      });
    };
    return formBuilderFactory;
});

factoryModule.factory('emailTemplateFactory', function($http){
    var urlBase = JSON_URL + "/email_templates";
    var emailTemplateFactory = {};

    emailTemplateFactory.getEmailTemplates = function(procedure_id, email_type, current_year_id) { //index
      return $http({
        url: urlBase,
        method: "GET",
        params: {
          "procedure_id" : procedure_id,
          "email_type" : email_type,
          "current_year_id": current_year_id,
          "current_process_id": procedure_id
        }
      });
    };
    emailTemplateFactory.showTemplate = function(email_template_id, current_year_id, current_process_id) { //show
      return $http({
        url: urlBase + "/" + email_template_id,
        method: "GET",
        params: {
          "current_year_id" : current_year_id,
          "current_process_id" : current_process_id
        }
      });
    };
    emailTemplateFactory.createTemplate = function(email_template, current_year_id, current_process_id) { //create
      return $http({
        url: urlBase,
        method: "POST",
        data: {
          "email_template" : email_template,
          "current_year_id" : current_year_id,
          "current_process_id" : current_process_id
        }
      });
    };
    emailTemplateFactory.updateTemplate = function(email_template, current_year_id, current_process_id) { //update
      return $http({
        url: urlBase + "/" + email_template.id,
        method: "PUT",
        data: {
          "email_template" : email_template,
          "current_year_id" : current_year_id,
          "current_process_id" : current_process_id
        }
      });
    };
    emailTemplateFactory.deleteTemplate = function(email_template, email_type, current_year_id, current_process_id) { //delete
      return $http({
        url: urlBase + "/" + email_template.id,
        method: "DELETE",
        params: {
          "email_type" : email_type,
          "current_year_id" : current_year_id,
          "current_process_id" : current_process_id
        }
      });
    };
    emailTemplateFactory.runTemplate = function(email_template, email_type, current_year_id, current_process_id) {
      return $http({
        url: urlBase + "/use_it",
        method: "POST",
        params: {
          "email_template_id" : email_template.id,
          "email_type" : email_type,
          "current_year_id" : current_year_id,
          "current_process_id" : current_process_id
        }
      });
    };
    return emailTemplateFactory;
});

factoryModule.factory('rdFlagFactory', function($http){
    var urlBase = JSON_URL + "/rd_flags";
    var rdFlagFactory = {};

    rdFlagFactory.getApplicantList = function(current_process_id, current_year_id, page, keyword) {
      return $http({
        url : urlBase,
        method : "GET",
        params : {
          "current_process_id" : current_process_id,
          "current_year_id" : current_year_id,
          "page" : page,
          "keyword" : keyword
        }
      });
    };

    rdFlagFactory.changeRdFlag = function(applicant, rd_flag_color, current_process_id, current_year_id) {
      return $http({
        url : urlBase + "/" + applicant.id,
        method : "PUT",
        data : {
          "rd_flag_color" : rd_flag_color,
          "current_process_id" : current_process_id,
          "current_year_id" : current_year_id
        }
      });
    };

    rdFlagFactory.getInvolvedStudent = function(involved_suid, current_process_id, current_year_id) {
      return $http({
        url : urlBase + "/get_involved_student",
        method : "POST",
        data : {
          "involved_suid" : involved_suid,
          "current_process_id" : current_process_id,
          "current_year_id" : current_year_id
        }
      });
    };

    return rdFlagFactory;
});

factoryModule.factory('transcriptFactory', function($http){
    var urlBase = JSON_URL + "/transcripts";
    var transcriptFactory = {};

    transcriptFactory.showApplicantTranscripts = function(user_id, current_process_id, current_year_id) {
      return $http({
        url : urlBase + "/applicant_transcripts",
        method : "GET",
        params : {
          "user_id": user_id,
          "current_process_id": current_process_id,
          "current_year_id": current_year_id
        }
      });
    };
    return transcriptFactory;
});

factoryModule.factory('systemMessageFactory', function($http){
    var urlBase = JSON_URL + "/system_messages";
    var systemMessageFactory = {};

    systemMessageFactory.getSystemMessageList = function(current_year_id, current_process_id) {
      return $http({
        url : urlBase,
        method : "GET",
        params : {
          "current_process_id" : current_process_id,
          "current_year_id" : current_year_id
        }
      });
    };

    systemMessageFactory.updateSystemMessage = function(system_message, current_year_id, current_process_id) {
      return $http({
        url : urlBase + "/" + system_message.id,
        method : "PUT",
        data : {
          "system_message" : system_message,
          "current_process_id" : current_process_id,
          "current_year_id" : current_year_id
        }
      });
    };

    return systemMessageFactory;
});

factoryModule.factory('reportFactory', function($http){
    var urlBase = JSON_URL + "/reports";
    var reportFactory = {};

    reportFactory.index = function(current_year_id, current_process_id) {
      return $http({
        url : urlBase,
        method : "GET",
        params : {
          "current_process_id" : current_process_id,
          "current_year_id" : current_year_id
        }
      });
    };

    reportFactory.ExportFormSchema = function(current_year_id, current_process_id) {
      return $http({
        url : "/batch_jobs/translate_form_schema",
        method : "GET",
        params : {
          "current_process_id" : current_process_id,
          "current_year_id" : current_year_id
        }
      });
    };

    return reportFactory;
});

factoryModule.factory('limitPeriodFactory', function($http){
    var urlBase = JSON_URL + "/limit_periods";
    var limitPeriodFactory = {};

    limitPeriodFactory.createLimit = function(limit, current_year_id, current_process_id) {
      return $http({
        url : urlBase,
        method : "POST",
        data : {
          "limit" : limit,
          "current_process_id" : current_process_id,
          "current_year_id" : current_year_id
        }
      });
    };

    limitPeriodFactory.updateLimit = function(limit, current_year_id, current_process_id) {
      return $http({
        url : urlBase + "/" + limit.id,
        method : "PUT",
        params : {
          "limit" : limit,
          "current_process_id" : current_process_id,
          "current_year_id" : current_year_id
        }
      });
    };

    limitPeriodFactory.deleteLimit = function(limit, current_year_id, current_process_id) {
      return $http({
        url : urlBase + "/" + limit.id,
        method : "DELETE",
        params : {
          "limit" : limit,
          "current_process_id" : current_process_id,
          "current_year_id" : current_year_id
        }
      });
    };

    return limitPeriodFactory;
});

factoryModule.factory('saasFactory', function($http){
    var urlBase = JSON_URL + "/saas";
    var saasFactory = {};

    saasFactory.sendQuestion = function(contact, current_year_id, current_process_id) {
      return $http({
        url : urlBase + '/send_question',
        method : "POST",
        data : {
          "contact" : contact,
          "current_process_id" : current_process_id,
          "current_year_id" : current_year_id
        }
      });
    };

    return saasFactory;
});

factoryModule.factory('permissionFactory', function($http){
    var urlBase = JSON_URL + "/permission";
    var permissionFactory = {};

    permissionFactory.getPermissionList = function(current_year_id, current_process_id) {
      return $http({
        url : urlBase + '/get_permission_list',
        method : "GET",
        params : {
          "current_process_id" : current_process_id,
          "current_year_id" : current_year_id
        }
      });
    };

    permissionFactory.updatePermissions = function(permission_list, current_year_id, current_process_id) {
      return $http({
        url : urlBase + '/update_permissions',
        method : "POST",
        data : {
          "permission_list" : permission_list,
          "current_process_id" : current_process_id,
          "current_year_id" : current_year_id
        }
      });
    };

    return permissionFactory;
});
