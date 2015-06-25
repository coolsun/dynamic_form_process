var mailer = angular.module("mailer", ["waitingIconModule"]);

mailer.factory("Mailer", function($http, waitingIcon, mailerFactory, $rootScope) {

    function Mailer(url) {
      this.url = url;
    }

    Mailer.prototype.init = function(data, template_id, mailer){
      var s;
      waitingIcon.open();

      //get mail template
      mailer.setting.getMailTemplate(template_id, mailer);
      //get to list
      $http({
          url: this.url,
          method: "POST",
          data: data
        })
        .success(function (data, status, headers, config) {
          mailer.to_list = {};
          mailer.to_list.all = data.all;
          mailer.to_list.select_list = data.select_list;
          s = true;
          waitingIcon.close();
        })
        .error(function (data, status, headers, config) {
          s = false;
          waitingIcon.close();
        });
      return(s);
    };

    Mailer.prototype.getMailTemplate = function(template_ids, mailer) {
      mailerFactory.getMailTemplate(template_ids, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function (data) {
        if(data.length > 0){
          mailer.current_template = data[0];
          mailer.templates = data;
        }
      })
      .error(function (data) {
        console.log("get template Error");
      });
    };

    Mailer.prototype.saveMailTemplate = function(template, mailer) {
      if(parseInt(template.id) > 0){
        mailerFactory.saveMailTemplate(template, $rootScope.current_year.id, $rootScope.current_process.id)
        .success(function (data) {
          $rootScope.alerts = [{type: 'success', msg: 'The email template has been updated successfully.'}];
        })
        .error(function (data) {
          console.log("save template Error");
          $rootScope.alerts.push({type: 'danger', msg: 'There was a problem to update the email template.'});
        });
      }
      else{
        mailerFactory.createMailTemplate(template, $rootScope.current_year.id, $rootScope.current_process.id)
        .success(function (data) {
          if(data.success){
            $rootScope.alerts= [{type: 'success', msg: 'The email template has been created successfully.'}];
            if(mailer.templates.length == 0){
              mailer.templates = [];
            }
            mailer.templates.push(data.email_template);
            mailer.current_template = data.email_template;
          }
          else{
            console.log("create template False");
            $rootScope.alerts.push({type: 'danger', msg: 'Failed to create the email template.'});
          }
        })
        .error(function (data) {
          console.log("create template Error");
          $rootScope.alerts.push({type: 'danger', msg: 'Failed to create the email template.'});
        });
      }
    };

    Mailer.prototype.snedMail = function(mailer, position_id, process_id) {
      mailerFactory.sendMail(mailer.current_template, mailer.to_list.select_list, position_id, process_id, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function (data) {
      })
      .error(function (data) {
        console.log("get template Error");
      });
    };

    return(Mailer);
});
