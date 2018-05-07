TUDO MVC TUTO RAILS 5.2 / RUBY 2.5.1


RBENV_VERSION=2.5.1 rbenv exec rails _5.2.0_ new hyperloop-rails-tudomvc --skip-bundle
cd hyperloop-rails-tudomvc

GEMFILE
gem 'hyperloop', '~>1.0.0.lap0'
gem 'opal-jquery', git: 'https://github.com/opal/opal-jquery.git', branch: 'master'


bundle install
bundle exec rails g hyperloop:install
bundle exec rails g hyper:component App

... edit routes file...
  get '/(*other)', to: 'hyperloop#app'

 bundle exec rails s
... visit localhost:3000


1. bundle exec rails g model Todo title:string completed:boolean priority:integer

If got ERROR:
uninitialized constant Hyperloop::AutoCreate::Net


Then in config/hyperloop.rb

module Hyperloop
  module AutoCreate
    def needs_init?
      return false if Hyperloop.transport == :none
      return true if connection.respond_to?(:data_sources) && !connection.data_sources.include?(table_name)
      return true if !connection.respond_to?(:data_sources) && !connection.tables.include?(table_name)
      Hyperloop.on_server?
    end
  end
  def self.on_server?
    return !Rails.const_defined?('Console')
  end
end

2. again
bundle exec rails g model Todo title:string completed:boolean priority:integer

3. bundle exec rails db:migrate

4. Move todo.rb to app/hyperloop/models

5. Move application_record.rb to app/hyperloop/models

6. Add regulate_scope :all to application_record.rb

7. Add to hyperloop.rb

require 'net/http'
module Hyperloop
  def self.on_server?
    defined? Rails::Server
  end
  module AutoCreate
    def table_exists?
      # works with both rails 4 and 5 without deprecation warnings
      if connection.respond_to?(:data_sources)
        connection.data_sources.include?(table_name)
      else
        connection.tables.include?(table_name)
      end
    end

    def needs_init?
      Hyperloop.transport != :none && Hyperloop.on_server? && !table_exists?
    end
  end
  class Connection < ActiveRecord::Base
    def self.active
      return [] unless table_exists?
      if Hyperloop.on_server?
        expired.delete_all
        refresh_connections if needs_refresh?
      end
      all.pluck(:channel).uniq
    end
    def self.root_path
      QueuedMessage.root_path if table_exists?
    end
  end
end