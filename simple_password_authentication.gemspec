Gem::Specification.new do |s|
  s.name     = "simple_password_authentication"
  s.version  = "0.1.1"
  s.date     = "2009-03-09"
  s.summary  = "Password authentication for SimpleAuthentication"
  s.email    = "toredarell@gmail.com"
  s.homepage = "http://github.com/toretore/simple_password_authentication"
  s.description = "Password authentication for SimpleAuthentication"
  #s.has_rdoc = true
  s.author  = "Tore Darell"
  s.files    = Dir["lib/**/*"] + Dir["rails/**/*"] + Dir["config/**/*"] + Dir["app/**/*"] + Dir["generators/**/*"] + Dir["tasks/**/*"]
  #s.rdoc_options = ["--main", "README.txt"]
  #s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.add_dependency("simple_authentication", ["= 0.1.1"])
end
