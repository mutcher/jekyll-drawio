class DiagramExtractor
  def initialize
  end

  def extract_diagram(path, diagram_num)
    doc = File.open(path) { |f| Nokogiri::XML(f) }
    diagrams = doc.xpath("//mxfile//diagram")
    puts "Diagrams found at \"#{path}\": #{diagrams.length}. " \
         "Selected: #{diagram_num}. "

    diagram = diagrams[diagram_num]

    diagram_name = diagram["name"]
    diagram_content = diagram.to_html

    return diagram_name, diagram_content
  end
end
