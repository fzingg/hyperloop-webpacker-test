# require 'net/http'
# module Hyperloop
#   def self.on_server?
#     defined? Rails::Server
#   end
#   module AutoCreate
#     def table_exists?
#       # works with both rails 4 and 5 without deprecation warnings
#       if connection.respond_to?(:data_sources)
#         connection.data_sources.include?(table_name)
#       else
#         connection.tables.include?(table_name)
#       end
#     end

#     def needs_init?
#       Hyperloop.transport != :none && Hyperloop.on_server? && !table_exists?
#     end
#   end
#   class Connection < ActiveRecord::Base
#     def self.active
#       return [] unless table_exists?
#       if Hyperloop.on_server?
#         expired.delete_all
#         refresh_connections if needs_refresh?
#       end
#       all.pluck(:channel).uniq
#     end
#     def self.root_path
#       QueuedMessage.root_path if table_exists?
#     end
#   end
# end

Hyperloop.configuration do |config|
  config.transport = :action_cable
  config.import 'reactrb/auto-import'
  config.import 'opal_hot_reloader'
  config.cancel_import 'react'
  config.import Webpacker.manifest.lookup("client_and_server.js").split("/").last

end
