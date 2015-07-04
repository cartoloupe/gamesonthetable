source 'https://rubygems.org'
# ruby "2.1.2"
#
# gem 'rails_12factor', group: :production

gem 'mina'

gem 'haml-rails'
gem 'websocket-rails'
gem 'bower-rails'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use sqlite3 as the database for Active Record
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Had to use rails assets rather than this Gem. See http://nithinbekal.com/posts/rails-assets-jquery/
# Use jquery as the JavaScript library
gem 'jquery-rails'


# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Authentication

gem 'devise'
gem 'angular_rails_csrf'

source "https://rails-assets.org" do
  gem 'rails-assets-angular-devise'
  gem 'rails-assets-jquery-countdown'          # https://github.com/rendro/countdown
  gem 'rails-assets-angular-timer'
  gem 'rails-assets-humanize-duration'
  gem 'rails-assets-momentjs'
  gem 'rails-assets-angular-mocks'
  gem 'rails-assets-angular-resource'

  # Had to use rails assets rather than this Gem. See http://nithinbekal.com/posts/rails-assets-jquery/
  # gem 'rails-assets-jquery'
  # gem 'rails-assets-jquery-ujs'
end

gem 'high_voltage', '~> 2.3.0'
gem 'sexp_processor', '~> 4.5.1'

gem 'less-rails'
gem 'railsstrap'
gem 'chronic'
gem 'browser-timezone-rails'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'pry-rails'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  gem 'quiet_assets'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 1.3.6'

  gem 'jasmine-rails'

  gem 'guard'
  gem 'guard-minitest'
  gem 'guard-jasmine' # Note that phantomjs needs to be installed: https://github.com/guard/guard-jasmine
  gem 'minitest'
  gem 'minitest-reporters'

  gem 'awesome_print'
end

# group :production do
  gem 'pg'
# end
