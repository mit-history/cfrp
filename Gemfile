source 'http://rubygems.org'

gem 'rake', '0.9.2.2'
gem 'rails', '= 3.2.2'
gem 'pg', '0.11.0'
gem 'devise'
gem 'cancan'

# jQuery is the default JavaScript library in Rails 3.1
gem 'jquery-rails'
gem 'twitter-bootstrap-rails'
gem 'therubyracer' # bundle can't find this one, even though it's a dependency?

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier',     '>= 1.0.3'
end

# Repertoire Gems
gem 'repertoire-faceting', :git => 'git@github.com:repertoire/repertoire-faceting.git', :branch => '0.5.5.dev'
gem 'repertoire-groups', :git => 'git@github.com:repertoire/Repertoire-Groups.git'
gem 'rep.ajax.toolkit', :git => 'git@github.com:repertoire/rep.ajax.toolkit.git'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem 'capybara'
  gem 'autotest'
  gem 'autotest-growl'
  gem 'autotest-fsevent'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'annotate'
end
