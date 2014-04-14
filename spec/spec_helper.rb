require 'rubygems'
require 'bundler'

Bundler.require(:default, :test)

require 'simplecov'
require 'simplecov-html'

SimpleCov.start do
  add_filter 'spec'
  add_filter 'public'
end

require 'rack'

require_relative '../lib/phonebook'

require 'rspec/autorun'

RSpec.configure do |config|

end
