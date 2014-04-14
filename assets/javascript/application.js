// it would be nice to have bower handle all this for us ...
//= require './vendor/lodash/dist/lodash.js'
//= require './vendor/async/lib/async.js'
//= require './vendor/active-support/active-support.js'
//= require './vendor/angular/angular.js'
//= require './vendor/angular-route/angular-route.js'
//= require './vendor/angular-resource/angular-resource.js'
//= require './vendor/ngactiveresource/dist/ng-active-resource.js'

// The angular app:
var phonebook = angular.module('phonebook', ['ngRoute', 'ngResource', 'ActiveResource']);

// service that talks to the backend:
phonebook.factory('Contact', ['ActiveResource', function(ActiveResource){
  function Contact(data){
    this.number('id');
    this.string('name');
    this.string('phone');
  }

  Contact.inherits(ActiveResource.Base);
  Contact.api.set('http://localhost:9292').format('json');

  return Contact;
}])


// contactsController handles front end behaviour
phonebook.controller('contactsController', ['$scope', '$window', 'Contact',
  function($scope, $window, Contact){

    $scope.contacts = [];

    $scope.loadContacts = function(){
      Contact.all().then(function(response) {
        $scope.contacts = response;
      });
    };

    $scope.addContact = function(){
      $scope.newContact.$save().then(function(response){
        $scope.setupNewContact();
        $scope.contacts.push(response);
      });
    };

    $scope.setupNewContact = function(){
      $scope.newContact = Contact.new();
    };

    $scope.setupNewContact();
    $scope.loadContacts();
}]);


phonebook.controller('contactController', ['$scope', 'Contact', function($scope, Contact){

}]);


phonebook.directive('inlineEditable', function(){
  return {
    restrict: 'A',
    scope: {
      model: "=inlineEditableModel",
      modelAttribute: "=inlineEditableAttribute"
    },
    link: function(scope, element){
      scope.editing = false;

      element.bind('click', function(){
        if(!scope.editing){
          scope.$apply(edit);
        }
      });

      function edit(){
        scope.originalContact = angular.copy(scope.model);
        setTimeout(function(){ element.children()[1].focus();}, 10);
        scope.editing = true;
      };

      function cancel(){
        scope.model = scope.originalContact;
        scope.originalContact = null;
        scope.editing = false;
      };

      function save(){
        scope.model.$save().then(function(response){
          scope.model = response;
        });
        scope.originalContact = null;
        scope.editing = false;
      };

      angular.element(element.find('input')[0]).bind('keydown', function(event){
        switch(event.keyCode){
          case 27: scope.$apply(cancel); break;
          case 13: scope.$apply(save); break;
        }
      });

    },
    template: '<span ng-bind="modelAttribute" ng-show="!editing"></span><input type="text" ng-model="modelAttribute" ng-show="editing"/>'

  };
});

