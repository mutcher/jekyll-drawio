require "test_utils.rb"

TEST_UTF8_PATH = "ПТН-ПНХ"

class DrawIOConverterTest < Minitest::Test
  def test_parse_parameters
    params = "path=\"#{TEST_FILE}\" page_number=12 height=600"
    converter = create_converter_with_stub_extractor(params)
    converter.render nil
    assert_equal context_helper().line_number, converter.line_number
    assert_equal TEST_FILE, converter.path_to_diagram
    assert_equal 12, converter.selected_diagram_num
    assert_equal 600, converter.diagram_height
  end

  def test_parse_parameters_utf_path
    params = "path=\"#{TEST_UTF8_PATH}\" page_number=12 height=1600"
    converter = create_converter_with_stub_extractor(params)
    converter.render nil
    assert_equal context_helper().line_number, converter.line_number
    assert_equal TEST_UTF8_PATH, converter.path_to_diagram
    assert_equal 12, converter.selected_diagram_num
    assert_equal 1600, converter.diagram_height
  end
end
