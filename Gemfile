source 'http://rubygems.org'

ruby '1.9.3'

gem 'rake', '~> 0.9'
gem 'rails', '~> 3.2'
gem 'pg', '~> 0.11.0'
gem 'devise'
gem 'cancan'

# jQuery is the default JavaScript library in Rails 3.1
gem 'jquery-rails'
gem 'twitter-bootstrap-rails'
gem 'therubyracer' # bundle can't find this one, even though it's a dependency?

# GOSH I HOPE THIS WORKS
gem 'nested_form'

gem 'rails_12factor', group: :production

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier',     '>= 1.0.3'
end

# gem 'repertoire-groups', :git => 'git@github.com:repertoire/Repertoire-Groups.git', :branch => 'bootstrap-flavor'
gem 'repertoire-groups', '0.0.1', :path => 'vendor/repertoire-groups-0.0.1' #, :require => 'repertoire-groups'
gem 'acts-as-taggable-on'

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
end

gem 'activeadmin'
gem "meta_search",    '>= 1.1.0.pre'
gem 'pry'
