source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'activejob-retry'

gem 'dotenv-rails'

gem 'pg'
gem 'puma', '~> 3.0'

gem 'rails', '~> 5.0.2'
gem 'redis'
gem 'redis-namespace'

gem 'sidekiq'

gem 'telegram-bot-ruby'

gem 'virtus'

group :development do
  gem 'listen', '~> 3.0.5'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner'

  gem 'factory_girl_rails'

  gem 'rspec-rails', '~> 3.4'

  gem 'vcr'

  gem 'webmock'
end

group :development, :test do
  gem 'byebug', platform: :mri
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
