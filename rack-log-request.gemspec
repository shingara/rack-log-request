# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rack-log-request/version"

Gem::Specification.new do |s|
  s.name        = "rack-log-request"
  s.version     = Rack::LogRequest::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Cyril Mougel"]
  s.email       = ["cyril.mougel@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Log in mongoDB all request do with their time to generate it}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "rack-log-request"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
