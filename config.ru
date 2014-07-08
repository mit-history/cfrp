# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

# Uncomment this to enable asset compression for JSON data feeds
#use Rack::Deflater

run Cfrp::Application

# Enable CORS requests, for CFRP data-essays. ("HTTP GET" only, for security.)
require 'rack/cors'
use Rack::Cors do

  # allow get requests from all origins
  allow do
    origins '*'
    resource '*',
        :headers => :any,
        :methods => [:get, :options]
  end
end
