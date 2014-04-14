require 'rubygems'
require 'bundler'

Bundler.require

require 'rack'
require 'rack/contrib'

# assets
require 'sprockets'

use Rack::Deflater

map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'assets'
  #environment.engines['.slim'] = Slim::Template

  run environment
end

# deliver static content from the public folder
use Rack::Static, :root => 'public', :index => 'index.html'

# mount the phonebook api
require_relative 'lib/app/api_v1'

run Phonebook::APIv1

