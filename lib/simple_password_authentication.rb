require "simple_authentication"
require "simple_password_authentication/password_authenticator"
require "simple_password_authentication/model_methods"
require "simple_password_authentication/controller_methods"
require "user"

User.send(:include, SimplePasswordAuthentication::ModelMethods::User)
User.send(:include, SimplePasswordAuthentication::ModelMethods::User::Behavior)
SimpleAuthentication::ControllerMethods::Logins.send(:include, SimplePasswordAuthentication::ControllerMethods::Logins)
I18n.load_path << File.join(File.dirname(__FILE__), '..', 'config', 'locales', 'simple_password_authentication.yml')
