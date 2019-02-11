source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end
ruby '2.5.1'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.7', '>= 5.0.7.1'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

# needed for Quiply
gem 'groupdate', '~> 4.1.0'
gem 'ruby-progressbar', '~> 1.10.0'
gem 'smarter_csv', '~> 1.2.6'

group :development, :test do
  gem 'byebug', platform: :mri
end
group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end
gem 'bootstrap', '~> 4.2.1'
gem 'pg', '~> 0.18'
gem 'slim-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
group :development do
  gem 'better_errors'
  gem 'foreman'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'hub', require: nil
  gem 'rails_layout'
  gem 'rb-fchange', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-inotify', require: false
  gem 'rb-readline'
  gem 'spring-commands-rspec'
end
group :development do
  gem 'github-markup'
  gem 'guard-yard'
  gem 'redcarpet'
  gem 'yard'
end
group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rspec-collection_matchers', '~> 1.1.0'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'simplecov', '~> 0.16.1'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
end
