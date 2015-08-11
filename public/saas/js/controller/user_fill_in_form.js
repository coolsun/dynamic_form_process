rsasApp.controller('UserFillInForm',
  function($scope, $sce, $window, $rootScope, userFormFactory, FileUploader, fileFactory, waitingIcon){

    $scope.getNumberArray = function(input_array, key){
      n = findMax(input_array, key);
      var array = [];
      for(var i = 0; i <= n; i++){
        array.push(i);
      }
      return array;
    };

    $scope.getRows = function(){
      n = findMax(this.form.schema, "row");
      return $scope.getNumberArray(this.form.schema, "row");
    };

    $scope.getColumns = function(row){
      schema = findObjs(this.form.schema, "row", row);
      return $scope.getNumberArray(schema, "column");
    };

    $scope.forms = [];

    angular.element(document).ready(function () {
      if($rootScope.isRunNowProcess){
        waitingIcon.open();
        userFormFactory.showUserFilledForms($rootScope.current_year.id, $rootScope.current_process.id, $rootScope.applicant_sub_step.identify_name)
        .success(function (data){
          $scope.permission_to_active = data.permission_to_active;
          $scope.current_form = data.forms[0];
          angular.forEach(data.forms, function(form_obj){
            form_obj.schema = eval(form_obj.schema);
            //console.log(form_obj.schema);
            $scope.get_form_file(form_obj.id);
          });
          waitingIcon.close();
          $scope.forms = data.forms;
          if ($scope.forms.length > 0){
            $scope.forms[0].show = true;
          };
        })
        .error(function (data){
          $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the user form."});
          waitingIcon.close();
        });
      }
    });

    $scope.submit = function (process_form_index){
      waitingIcon.open();
      user_filled_form = $scope.forms[process_form_index];
      user_form = {"id": user_filled_form.id, "schema": JSON.stringify(user_filled_form.schema)};
      userFormFactory.updateUserFilledForms(user_form, $rootScope.current_year.id, $rootScope.current_process.id, true)
      .success(function(data){
        if(data.success){
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
          $rootScope.getApplicantStatus(false);
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to update the form."});
        waitingIcon.close();
      });
    };

    $scope.to_html = function(str) {
      return $sce.trustAsHtml(str);
    };

    $scope.change_current_form = function(form) {
      $scope.current_form = form;
    };

    $scope.get_form_file = function(form_id) {
      fileFactory.getFileList(form_id, "UserForm", $rootScope.current_year.id, $rootScope.current_process.id).success(function (data) {
        if(data.success){
          angular.forEach($scope.forms, function(form){
            if(form.id == form_id){
              form.upload_files = data.files;
            }
          });
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the file list."});
        }
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the file list."});
      });

    };

    $scope.save_form = function(process_form_index) {
      waitingIcon.open();
      user_filled_form = $scope.forms[process_form_index];
      console.log(user_filled_form);
      user_form = {"id": user_filled_form.id, "schema": JSON.stringify(user_filled_form.schema)};
      userFormFactory.updateUserFilledForms(user_form, $rootScope.current_year.id, $rootScope.current_process.id, false)
      .success(function(data){
        if(data.success){
          $rootScope.rsasAlert({type: 'success', msg: data.msg});
          $rootScope.getApplicantStatus(false);
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: data.msg});
        }
        waitingIcon.close();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to update the form."});
        waitingIcon.close();
      });
    };

    $scope.submitAllForm = function() {
      for (var i = 0; i < $scope.forms.length; i ++) {
        var rq_empty = false;
        angular.forEach( $scope.forms[i].schema, function(item){
          if (item.rq && !item.value) {
            rq_empty = true;
          }
        });
        if (rq_empty) {
          $scope.forms[i].show = true;
          $scope.forms[i].error_msg = "Required Field Can't Blank.";
          $rootScope.rsasAlert({type: 'danger', msg: "Failed to submit " + $scope.forms[i].form_name + "."});
        }
        else {
          $scope.forms[i].error_msg = null;
          $scope.submit(i);
        }
      }
    };

    // file upload

    $scope.set_uploader = function(user_form_id) {

      var uploader = $scope.uploader =
        new FileUploader({
          url: '/files/upload',
          autoUpload: true,
          removeAfterUpload: true,
        });

      $scope.uploader.formData.push({
        "user_form_id": user_form_id,
        "test": 123
      });

      // FILTERS

      uploader.filters.push({
          name: 'fileExtensionFilter',
          fn: function(item /*{File|FileLikeObject}*/, options) {
              var type = '|' + item.type.slice(item.type.lastIndexOf('/') + 1) + '|';
              return '|pdf|doc|xls|jpg|jpeg|bmp|tif|png|gif|bmp|vnd.openxmlformats-officedocument.wordprocessingml.document|vnd.openxmlformats-officedocument.spreadsheetml.sheet|'.indexOf(type) !== -1;
          }
      });

      // CALLBACKS

      uploader.onWhenAddingFileFailed = function(item /*{File|FileLikeObject}*/, filter, options) {
        console.info('onWhenAddingFileFailed', item, filter, options);
      };
      uploader.onAfterAddingFile = function(fileItem) {
        console.info('onAfterAddingFile', fileItem);
      };
      uploader.onAfterAddingAll = function(addedFileItems) {
        console.info('onAfterAddingAll', addedFileItems);
      };
      uploader.onBeforeUploadItem = function(item) {
        console.info('onBeforeUploadItem', item);
      };
      uploader.onProgressItem = function(fileItem, progress) {
        console.info('onProgressItem', fileItem, progress);
      };
      uploader.onProgressAll = function(progress) {
        console.info('onProgressAll', progress);
      };
      uploader.onSuccessItem = function(fileItem, response, status, headers) {
        console.info('onSuccessItem', fileItem, response, status, headers);
      };
      uploader.onErrorItem = function(fileItem, response, status, headers) {
        console.info('onErrorItem', fileItem, response, status, headers);
      };
      uploader.onCancelItem = function(fileItem, response, status, headers) {
        console.info('onCancelItem', fileItem, response, status, headers);
      };
      uploader.onCompleteItem = function(fileItem, response, status, headers) {
        console.info('onCompleteItem', fileItem, response, status, headers);
      };
      uploader.onCompleteAll = function() {
        console.info('onCompleteAll');
        $scope.get_form_file(user_form_id);
      };

      console.info('uploader', uploader);

      return uploader;
    };

    $scope.delete_file = function(form, file_id, index){
      console.log(file_id);
      if($window.confirm("Are you sure?")){
        fileFactory.deleteFile(file_id, $rootScope.current_year.id, $rootScope.current_process.id)
        .success(function (data) {
          if(data.success){
            form.upload_files.splice(index, 1);
          }
          else{
            $rootScope.rsasAlert({type: 'danger', msg: "Failed to delete the file."});
          }
        })
        .error(function (data) {
          $rootScope.rsasAlert({type: 'danger', msg: "Failed to delete the file."});
        });
      };
    };

  }
);
