require "jekyll"
require "jekyll-drawio/version"
require "nokogiri"
require "erb"

MODULE_TAG_NAME = "drawio"

class DrawIOConverter < Liquid::Tag
  attr_accessor :path_to_diagram, :selected_diagram_num, :diagram_height

  def initialize(tagName, variables, tokens)
    super
    @path_to_diagram = ""
    @selected_diagram_num = nil
    @diagram_height = 200

    variables.each do |variable|
      param_value_pair = variable.split "="
      if param_value_pair[0] == "path"
        # TODO: find appropriate method to trim the string
        @path_to_diagram = param_value_pair[1].tr('\"', "")
      elsif param_value_pair[0] == "page_number"
        @selected_diagram_num = param_value_pair[1].to_i
      elsif param_value_pair[0] == "height"
        @diagram_height = param_value_pair[1].to_i
      end
    end

    puts "path=\"#{@path_to_diagram}\" page_num=#{@selected_diagram_num}"
  end

  def extract_diagram(path)
    doc = File.open(path) { |f| Nokogiri::XML(f) }
    diagrams = doc.xpath("//mxfile//diagram")
    puts "Diagrams found at \"#{path}\": #{diagrams.length}. " \
         "Selected: #{@selected_diagram_num}. "

    diagram = diagrams[@selected_diagram_num]

    diagram_name = diagram["name"]
    diagram_content = diagram.to_html

    return diagram_name, diagram_content
  end

  def render(context)
    diagram_name, diagram_content = self.extract_diagram @path_to_diagram
    encoded_diagram = ERB::Util.url_encode diagram_content
    encoded_diagram_name = ERB::Util.url_encode diagram_name

    puts "Parsed diagram: name=#{diagram_name} length=#{diagram_content.length} height=#{@diagram_height}"

    viewer_url_base = "https://viewer.diagrams.net/?highlight=0000ff&edit=_blank&layers=1&nav=1"
    viewer_url = "#{viewer_url_base}&title=#{encoded_diagram_name}\#R#{encoded_diagram}"
    viewer_style = "style=\"width:100%;height:#{@diagram_height}px\""

    %Q{<iframe frameborder="0" #{viewer_style} src="#{viewer_url}"></iframe>}
  end

  Liquid::Template.register_tag MODULE_TAG_NAME, self
end
