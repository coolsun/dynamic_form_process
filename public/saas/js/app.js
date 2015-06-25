'use strict';

/* App Module */

var rsasApp = angular.module('rsasApp', [
  'ngRoute',
  'adminEditApplicantApp',
  'interviewUserProcessApp',
  'interviewAdminProcessApp',
  'processApp',
  'homepageApp',
  'ui.tinymce',
  'ui.sortable',
  'formBuilderApp',
  'applyNowApp',
  'recommendationApp',
  'recommendationFormApp',
  'emailTemplateApp',
  'directiveModule',
  'factoryModule',
  'rsasFilters',
  'processSelectBarModule',
  'waitingIconModule',
  'indexApp',
  'tableRsas',
  'mailer',
  'ngTagsInput',
  'ngResource',
  'roundApp',
  'footerModule',
  'multi-select'
]);

rsasApp.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/', {
      }).
      when('/:urlProcessYear/:urlProcessAcronym/', {
        templateUrl: '/saas/partials/apply_now.html'
      }).
      when('/404', {
        templateUrl: '/saas/partials/404.html'
      }).
      when('/clone', {
        templateUrl: '/saas/partials/clone.html'
      }).
      when('/global', {
        templateUrl: '/saas/partials/global.html'
      }).
      when('/process', {
        templateUrl: '/saas/partials/process.html'
      }).
      when('/process_select', {
        templateUrl: '/saas/partials/process_select.html'
      }).
      when('/reports', {
        templateUrl: '/saas/partials/reports.html'
      }).
      when('/years', {
        templateUrl: '/saas/partials/years.html'
      }).
      when('/recommendation_form', {
        templateUrl: '/saas/partials/recommendation_form.html',
      }).
      when('/email_template', {
        templateUrl: '/saas/partials/email_template.html',
      }).
      when('/:urlProcessYear/:urlProcessAcronym/users', {
        templateUrl: '/saas/partials/users.html',
      }).
      when('/:urlProcessYear/:urlProcessAcronym/process_step', {
        templateUrl: '/saas/partials/process_step.html'
      }).
      when('/:urlProcessYear/:urlProcessAcronym/process_step/:urlStep', {
        templateUrl: '/saas/partials/process_step.html'
      }).
      when('/:urlProcessYear/:urlProcessAcronym/process_step/:urlStep/:urlSubStep', {
        templateUrl: '/saas/partials/process_step.html'
      }).
      when('/:urlProcessYear/:urlProcessAcronym/apply_now', {
        templateUrl: '/saas/partials/apply_now.html',
      }).
      when('/:urlProcessYear/:urlProcessAcronym/apply_now/:urlStep', {
        templateUrl: '/saas/partials/apply_now.html',
      }).
      when('/:urlProcessYear/:urlProcessAcronym/apply_now/:urlStep/:urlSubStep', {
        templateUrl: '/saas/partials/apply_now.html',
      }).
      when('/:urlProcessYear/:urlProcessAcronym/application', {
        templateUrl: '/saas/partials/application.html',
        controller: 'Application'
      }).
      when('/:urlProcessYear/:urlProcessAcronym/offers', {
        templateUrl: '/saas/partials/offers.html',
      }).
      when('/:urlProcessYear/:urlProcessAcronym/user_offers', {
        templateUrl: '/saas/partials/user_offers.html',
      }).
      when('/:urlProcessYear/:urlProcessAcronym/form_builder', {
        templateUrl: '/saas/partials/form_builder.html',
        controller: 'FormBuilder'
      }).
      when('/:urlProcessYear/:urlProcessAcronym/manage_applicant', {
        templateUrl: '/saas/partials/manage_applicant.html',
      }).
      when('/:urlProcessYear/:urlProcessAcronym/fill_form', {
        templateUrl: '/saas/partials/fill_form.html',
      }).
      when('/:urlProcessYear/:urlProcessAcronym/select_positions', {
        templateUrl: '/saas/partials/select_positions.html',
      }).
      when('/:urlProcessYear/:urlProcessAcronym/invitations', {
        templateUrl: '/saas/partials/invitations.html',
      }).
      when('/:urlProcessYear/:urlProcessAcronym/submit_application', {
        templateUrl: '/saas/partials/submit_application.html',
      }).
      otherwise({
        redirectTo: '/404'
      });
  }
]);
