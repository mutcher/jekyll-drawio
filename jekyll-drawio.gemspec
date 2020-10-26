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
  spec.description   = "Jekyll plugin to generate HTML snippets for embedding draw.io diagrams"
  
  spec.license       = "MIT"
  spec.require_paths = ["lib"]
  spec.homepage    = 'https://github.com/mutcher/jekyll-drawio'

  spec.add_dependency 'jekyll'
  spec.add_dependency 'nokogiri'
  spec.add_dependency 'erb'
end