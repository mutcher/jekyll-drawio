# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll-drawio/version'

Gem::Specification.new do |spec|
  spec.name          = "jekyll-drawio"
  spec.version       = Jekyll::DrawIO::VERSION
  spec.authors       = ["Illia Gorbatiuk"]
  spec.email         = ["ilya.gorbatiuk@gmail.com"]

  spec.summary       = "Jekyll plugin to generate HTML snippets for embedding draw.io diagrams"
  
  spec.license       = "MIT"
  spec.files         = Dir["lib/**/*"]
  spec.require_paths = ["lib"]
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  spec.homepage    = 'https://github.com/mutcher/jekyll-drawio'
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.add_runtime_dependency 'jekyll', '~> 4.3'
  spec.add_runtime_dependency 'nokogiri', '~> 1.12'
  spec.add_runtime_dependency 'erb', '>= 2.2', '< 5.0'
end
