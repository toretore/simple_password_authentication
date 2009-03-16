Gem::Specification.new do |s|
  s.name     = "simple_password_authentication"
  s.version  = "0.1.2"
  s.date     = "2009-03-16"
  s.summary  = "Password authentication for SimpleAuthentication"
  s.email    = "toredarell@gmail.com"
  s.homepage = "http://github.com/toretore/simple_password_authentication"
  s.description = "Password authentication for SimpleAuthentication"
  #s.has_rdoc = true
  s.author  = "Tore Darell"
  #s.files    = Dir["lib/**/*"] + Dir["rails/**/*"] + Dir["config/**/*"] + Dir["app/**/*"] + Dir["generators/**/*"] + Dir["tasks/**/*"]
  s.files   = %w(lib/simple_password_authentication.rb lib/simple_password_authentication lib/simple_password_authentication/password_authenticator.rb lib/simple_password_authentication/controller_methods.rb lib/simple_password_authentication/model_methods.rb rails/uninstall.rb rails/install.rb rails/init.rb config/locales config/locales/simple_password_authentication.yml app/views app/views/logins app/views/logins/password.html.erb app/views/logins/_password.html.erb generators/simple_password_authentication generators/simple_password_authentication/USAGE generators/simple_password_authentication/templates generators/simple_password_authentication/simple_password_authentication_generator.rb tasks/simple_password_authentication_tasks.rake)
  #s.rdoc_options = ["--main", "README.txt"]
  #s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.add_dependency("toretore-simple_authentication", ["= 0.1.2"])
end
