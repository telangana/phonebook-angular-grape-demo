# What is it?

This is a little Demo of how to use Grape for building an API
It is a Phonebook with Contacts that have a name and a phone number.

# Features

- Grape API in the backend
- Custom formatter for generating CSV
- Pluggable persistence layer via repositories
- In-Memory and Redis backends
- Download all Contacts as CSV
- AngularJS Frontend
- Add, inline-edit and delete contacts
- Validations for new contacts
- uses ngActiveResource to communicate with backend
- Styling provided by Bootstrap 3
- Uses sprockets to generate assets
- Javascript dependency management via bower
- run bower install to update dependencies

# Prerequisites

- Redis
- Ruby 2.1 (.ruby-version and .ruby-gemset for RVM are included)

# How to bootstrap:

- git clone git://github.com/the-architect/phonebook-angular-grape-demo
- bundle install
- rackup config.ru
- open http://localhost:9292

# TODO

- Add angular specs
- validate inline edit inputs
- inject repository via class method
- clean up framework code
- environments for test, development and production

Enjoy