# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zoom_search_s4m/version'

Gem::Specification.new do |spec|
  spec.name          = "zoom_search_s4m"
  spec.version       = ZoomSearchS4m::VERSION
  spec.authors       = ["Eduardo Alencar"]
  spec.email         = ["lebas66@gmail.com"]

  spec.summary       = %q{Search in Zoom}
  spec.description   = %q{Search in Zoom}
  spec.homepage      = "https://facebook.com/Solution4Mac"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.10.1"
  spec.add_development_dependency "certified", '1.0.0'
  
  spec.add_dependency "nokogiri",  "1.7.1"
end
