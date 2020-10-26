require "jekyll"
require "jekyll-drawio/version"
require 'nokogiri'
require 'erb'

class DrawIOConverter < Liquid::Tag

  def initialize(tagName, variables, tokens)
    super
    @variables = variables.split " "
    @path_to_diagram = ""
    @selected_diagram_num = nil
    
    @variables.each do |variable|
      param_value_pair = variable.split "="
      if param_value_pair[0] == "path"
        # TODO: find appropriate method to trim the string
        @path_to_diagram = param_value_pair[1].tr('\"', '')
      elsif param_value_pair[0] == "page_number"
        @selected_diagram_num = param_value_pair[1].to_i
      end
    end

    puts "path=\"#{ @path_to_diagram}\" page_num=#{ @selected_diagram_num }"
  end

  def extract_diagram(path, selected_diagram_num)
    doc = File.open(path) { |f| Nokogiri::XML(f) }
    diagrams = doc.xpath("//mxfile//diagram")
    puts "Diagrams found at \"#{ path }\": #{ diagrams.length }. Selected: #{ @selected_diagram_num }"
    diagram = diagrams[selected_diagram_num]

    diagram_name = diagram["name"]
    diagram_content = diagram.content

    return diagram_name, diagram_content
  end

  def render(context)
    diagram_name, diagram_content = self.extract_diagram @path_to_diagram, @selected_diagram_num
    encoded_diagram = ERB::Util.url_encode diagram_content
    encoded_diagram_name = ERB::Util.url_encode diagram_name

    viewer_url_base = "https://viewer.diagrams.net/?highlight=0000ff&edit=_blank&layers=1&nav=1"
    viewer_url = "#{ viewer_url_base }&title=#{ encoded_diagram_name }\#R#{ encoded_diagram }"

    %Q{<iframe frameborder="0" style="width:100%;height:200px" src="#{ viewer_url }"></iframe>}
  end

  Liquid::Template.register_tag "drawio", self
end