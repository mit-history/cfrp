source 'http://rubygems.org'

ruby '2.3.4'

gem 'rake'
gem 'rails', '~> 3.2'
gem 'pg'
gem 'devise'
gem 'cancan'
gem 'iconv'
gem 'paperclip'
gem 'dotenv-rails'
gem 'unicorn'
gem 'newrelic_rpm'
gem 'aws-sdk', '~> 1.5.7'
gem 'delayed_job_active_record'

# jQuery is the default JavaScript library in Rails 3.1
gem 'jquery-rails'
# gem 'jquery-ui-rails', '5.0.0'
gem 'jquery-ui-rails', '~> 5.0'
gem 'therubyracer' # bundle can't find this one, even though it's a dependency?

# GOSH I HOPE THIS WORKS
gem 'nested_form'

gem 'rails_12factor', group: :production

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier',     '>= 1.0.3'
end

gem 'less-rails'
gem 'twitter-bootstrap-rails', '~>2.2.8'

# gem 'repertoire-groups', :git => 'git@github.com:repertoire/Repertoire-Groups.git', :branch => 'bootstrap-flavor'
# gem 'repertoire-groups', '0.0.1', :path => './vendor/repertoire-groups-0.0.1' #, :require => 'repertoire-groups'
gem 'repertoire-groups', '0.0.1', :path => 'vendor/repertoire-groups-0.0.1' #, :require => 'repertoire-groups'
gem 'repertoire-faceting', '~>0.7.6'
gem 'acts-as-taggable-on'

# enable CORS, for use in CFRP data-essays
gem 'rack-cors', :require => 'rack/cors'

gem 'test-unit', '~> 3.0'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem 'capybara'
  # gem 'autotest'
  # gem 'autotest-growl'
  # gem 'autotest-fsevent'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'annotate'
  gem 'guard-rspec'
  gem 'rb-fsevent', '~> 0.9.1'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'shoulda-matchers'
end

# Caching, used for AJAX API endpoints
gem 'rack-cache'
gem 'dalli'
gem 'nokogiri'
# gem 'activeadmin'
gem 'activeadmin', '~> 1.0.0.pre5'
gem 'activeadmin_addons'
gem 'pry'
