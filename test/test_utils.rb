TEST_FILE = "test/testable_diagram.drawio"
TEST_TAG = "testTag"

TEST_FILE_PAGE_0_NAME = "Page-0"

class DiagramExtractorStub
  def initialize
  end

  def extract_diagram(path, diagram_num)
    return "name", "some data"
  end
end

def context_helper
  Class.new do
    def line_number
      "1234"
    end
  end.new
end

def create_converter(params)
  converter = DrawIOConverter.send :new, TEST_TAG, params, context_helper()
  return converter
end

def create_converter_with_stub_extractor(params)
    converter = create_converter params
    converter.diagram_extractor = DiagramExtractorStub.new()
    return converter
end
