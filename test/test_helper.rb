#Use vendored rails
Dir[File.dirname(__FILE__)+'/../../../rails/*/lib'].each{|lib| $: << lib }

#Depends on SimpleAuthentication
simple_auth_dir = File.join(File.dirname(__FILE__), '..', '..', 'simple_authentication')
$: << File.join(simple_auth_dir, 'lib')

#Add controller and model paths for both SA and SPA
%w(controllers models).each do |s|
  $: << File.join(simple_auth_dir, 'app', s)
  $: << File.join(File.dirname(__FILE__), '..', 'app', s)
end

require 'action_controller'
require 'active_record'

#SA and ActionController expects to find ApplicationController
class ApplicationController < ActionController::Base
end

#Add view paths for both SA and SPA
ActionController::Base.view_paths << File.join(File.dirname(__FILE__), '..', 'app', 'views') << File.join(simple_auth_dir, 'app', 'views')

require 'rubygems'
require 'test/unit'

$: << File.join(File.dirname(__FILE__), '..', 'lib')
require 'simple_password_authentication'

def load_routes(&b)
  ActionController::Routing::Routes.configuration_files << File.join(File.dirname(__FILE__), '..', 'config', 'routes.rb')
  ActionController::Routing::Routes.load!
  ActionController::Routing::Routes.draw(&b) if block_given?
end

#Initialises ActiveRecord and loads the schema using sqlite3
def load_schema
  ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")

  require 'sqlite3'

  ActiveRecord::Base.establish_connection({:adapter => 'sqlite3', :database => File.join(File.dirname(__FILE__), 'test.sqlite3')})
  load(File.dirname(__FILE__) + "/schema.rb")
end
