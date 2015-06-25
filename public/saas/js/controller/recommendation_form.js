var recommendationFormModule = angular.module('recommendationFormApp', ['checklist-model', 'ui.multiselect', 'angularFileUpload']);

recommendationFormModule.controller('RecommendationForm',
  function($scope, $route, $http, $sce, $window, $location, FileUploader, fileFactory, waitingIcon, recommendationFormFactory) {
    $scope.after_submit = false;
    $scope.show_recommendation_option = false;
    $scope.message = "";

    if($location.search().rid) {
      waitingIcon.open();
      recommendationFormFactory.getRecommendationForm($location.search().rid, $location.search().token, $location.search().key)
      .success(function(data) {
        if(data.success) {
          $scope.recommendation_record = data.this_record;

          $scope.show_recommendation_option = data.show_recommendation_option;
          $scope.show_for_std_interviewers = data.this_record.show_for_std_interviewers;
          $scope.permission_to_active = data.permission_to_active;

          angular.forEach(data.recommendation_form, function(form_obj){
            form_obj.schema = eval(form_obj.schema);
            $scope.get_form_file(form_obj.id);
          });
          $scope.forms = data.recommendation_form;
        }
        else {
          $scope.message = data.msg;
        }
        waitingIcon.close();
      })
      .error(function() {
        $scope.message = "There was a problem to get recommendation form(s).";
        waitingIcon.close();
      });
    }
    else {
      $scope.message = "You must know the record id to fill the recommendation form";
    }

    $scope.submit = function(form_index) {
      waitingIcon.open();
      recommendation_fill_form = $scope.forms[form_index];
      recommendationFormFactory.fillRecommendationForm($scope.recommendation_record.id,
                                                       recommendation_fill_form.form_name,
                                                       JSON.stringify(recommendation_fill_form.schema),
                                                       Date.now() / 1000,
                                                       $scope.show_for_std_interviewers)
      .success(function(data) {
        recommendation_fill_form = data;
        waitingIcon.close();
        //$location.url($location.url() + "&submit=true");
        $scope.after_submit = true;
      })
      .error(function(state){
        console.log(state);
        waitingIcon.close();
      });
    };

    // **************************************************
    // * Main code end, the form module after this line *
    // **************************************************

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

    $scope.to_html = function(str) {
      return $sce.trustAsHtml(str);
    };

    $scope.get_form_file = function(form_id) {
      send_data = {
        "form_id" : form_id,
        "type": "Recommender",
      };
      $http.post(JSON_URL + "/files/form_file_list", send_data).success(function (data) {
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

    // file upload

    $scope.set_uploader = function(form_id) {

      var uploader = $scope.uploader =
        new FileUploader({
          url: '/files/upload',
          autoUpload: true,
          removeAfterUpload: true,
        });

      $scope.uploader.formData.push({
        "recommendation_form_id": form_id
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
        $scope.get_form_file(form_id);
      };

      console.info('uploader', uploader);

      return uploader;
    };

    $scope.delete_file = function(form, file_id, index){
      console.log(file_id);
      if($window.confirm("Are you sure?")){
        fileFactory.deleteFile(file_id, "", "")
        .success(function (data) {
          if(data.success){
            console.log("file Delete Success");
            form.upload_files.splice(index, 1);
          }
          else{
            console.log("file Delete fail");
          }
        })
        .error(function (data) {
          console.log("file Delete Error");
        });
      };
    };

  }
);

recommendationFormModule.directive('recommendation', function(){
    return{
      restrict: 'E',
      templateUrl: '/saas/partials/rsas_form_template.html'
    };
  }
);
