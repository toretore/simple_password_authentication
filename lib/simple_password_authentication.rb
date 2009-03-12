require "simple_authentication"
require "simple_password_authentication/password_authenticator"
require "simple_password_authentication/model_methods"
require "simple_password_authentication/controller_methods"

SimpleAuthentication::ModelMethods::User.send(:include, SimplePasswordAuthentication::ModelMethods::User)
SimpleAuthentication::ModelMethods::User::ClassMethods.send(:include, SimplePasswordAuthentication::ModelMethods::User::ClassMethods)
#User.send(:include, SimplePasswordAuthentication::ModelMethods::User::Behavior)
SimpleAuthentication::ControllerMethods::Logins.send(:include, SimplePasswordAuthentication::ControllerMethods::Logins)
I18n.load_path.unshift(File.join(File.dirname(__FILE__), '..', 'config', 'locales', 'simple_password_authentication.yml'))
