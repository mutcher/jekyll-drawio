require "jekyll"
require "jekyll-drawio/version"
require "diagram_extractor"
require "nokogiri"
require "erb"

MODULE_TAG_NAME = "drawio"

def split_parameters_line(parameters_line)
  params = []
  tmp = ""

  parameters_line.each_char do |symbol|
    if symbol == " "
      params.push tmp
      tmp = ""
    else
      tmp += symbol
    end
  end

  params.push tmp
  params
end

class DrawIOConverter < Liquid::Tag
  attr_accessor :path_to_diagram,
                :selected_diagram_num,
                :diagram_height,
                :markup,
                :diagram_extractor

  def initialize(tagName, markup, tokens)
    super
    @path_to_diagram = ""
    @selected_diagram_num = 0
    @diagram_height = 200
    @markup = markup
    @diagram_extractor = DiagramExtractor.new()
  end

  def parse_content(context)
    parameters_line = Liquid::Template.parse(@markup).render context
    parameters_line.strip!
    parameters = split_parameters_line(parameters_line)

    parameters.each do |param|
      param_value_pair = param.split "="
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

  def render(context)
    if @markup.empty?
      return "Error processing input, incorrect syntax"
    end
    parse_content context

    diagram_name, diagram_content = self.diagram_extractor.extract_diagram @path_to_diagram, @selected_diagram_num
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
