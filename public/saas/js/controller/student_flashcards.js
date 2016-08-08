rsasApp.controller('StudentFlashcards',function($scope, $rootScope, waitingIcon, FileUploader) {
  $scope.current_year_id = $rootScope.current_year.id;
  $scope.current_process_id = $rootScope.current_process.id;

  $scope.errors = [];
  $scope.importStudentFlashcardsXlsx = function(url) {
    var uploader = $scope.uploader =
      new FileUploader({
        url: url,
        autoUpload: true,
        removeAfterUpload: true,
      });

    $scope.uploader.formData.push({
      "current_year_id": $rootScope.current_year.id,
      //"current_process_id": $rootScope.current_process.id,
      //"identify_name": $rootScope.current_sub_step ? $rootScope.current_sub_step.identify_name : nil
    });

    uploader.filters.push({
        name: 'fileExtensionFilter',
        fn: function(item /*{File|FileLikeObject}*/, options) {
            var type = '|' + item.type.slice(item.type.lastIndexOf('/') + 1) + '|';
            return '|xlsx|vnd.openxmlformats-officedocument.spreadsheetml.sheet|'.indexOf(type) !== -1;
        }
    });

    uploader.onWhenAddingFileFailed = function(item /*{File|FileLikeObject}*/, filter, options) {
      console.info('onWhenAddingFileFailed', item, filter, options);
    };
    uploader.onAfterAddingFile = function(fileItem) {
      console.info('onAfterAddingFile', fileItem);
      waitingIcon.open();
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
      $scope.errors = response.errors;

      if($scope.errors.length == 0){
        $rootScope.rsasAlert({type: 'success', msg: 'The xlsx file have been imported successfully.'});
      }
      waitingIcon.close();
    };
    uploader.onErrorItem = function(fileItem, response, status, headers) {
      console.info('onErrorItem', fileItem, response, status, headers);
      $rootScope.rsasAlert({type: 'danger', msg: 'There was a problem uploading the excel file. Please contact a system administrator.'});
      waitingIcon.close();
    };
    uploader.onCancelItem = function(fileItem, response, status, headers) {
      console.info('onCancelItem', fileItem, response, status, headers);
    };
    uploader.onCompleteItem = function(fileItem, response, status, headers) {
      console.info('onCompleteItem', fileItem, response, status, headers);
    };
    uploader.onCompleteAll = function() {
      console.info('onCompleteAll');
    };

    return uploader;
  };



});
