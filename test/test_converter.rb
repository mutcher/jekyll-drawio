require "minitest/autorun"
require "jekyll-drawio"

TEST_FILE = "test/testable_diagram.drawio"
TEST_TAG = "testTag"

TEST_FILE_PAGE_0_NAME = "Page-0"

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

class DrawIOConverterTest < Minitest::Test
  def test_parse_parameters
    params = ["path=\"#{TEST_FILE}\"", "page_number=12", "height=600"]
    converter = create_converter(params)
    assert_equal context_helper().line_number, converter.line_number
    assert_equal TEST_FILE, converter.path_to_diagram
    assert_equal 12, converter.selected_diagram_num
    assert_equal 600, converter.diagram_height
  end

  def test_extracting_diagram_metadata
    params = ["path=\"#{TEST_FILE}\"", "page_number=0", "height=432"]
    converter = create_converter(params)
    diagram_name, diagram_content = converter.extract_diagram(TEST_FILE)
    assert_equal TEST_FILE_PAGE_0_NAME, diagram_name
    assert_equal 3092, diagram_content.length
  end

  def test_rendering
    expected_result = "<iframe frameborder=\"0\" style=\"width:100%;height:432px\" src=\"https://viewer.diagrams.net/?highlight=0000ff&edit=_blank&layers=1&nav=1&title=Page-0#R%3Cdiagram%20name%3D%22Page-0%22%20id%3D%22LaxfCNpSPWuLkdPQJo0J%22%3E%0A%20%20%20%20%3CmxGraphModel%20dx%3D%221418%22%20dy%3D%22820%22%20grid%3D%221%22%20gridSize%3D%2210%22%20guides%3D%221%22%20tooltips%3D%221%22%20connect%3D%221%22%20arrows%3D%221%22%20fold%3D%221%22%20page%3D%221%22%20pageScale%3D%221%22%20pageWidth%3D%22850%22%20pageHeight%3D%221100%22%20math%3D%220%22%20shadow%3D%220%22%3E%0A%20%20%20%20%20%20%3Croot%3E%0A%20%20%20%20%20%20%20%20%3CmxCell%20id%3D%220%22%3E%3C%2FmxCell%3E%0A%20%20%20%20%20%20%20%20%3CmxCell%20id%3D%221%22%20parent%3D%220%22%3E%3C%2FmxCell%3E%0A%20%20%20%20%20%20%20%20%3CmxCell%20id%3D%22NY2RaFPMxS_D9FvXeHKu-12%22%20style%3D%22edgeStyle%3DorthogonalEdgeStyle%3Brounded%3D0%3BorthogonalLoop%3D1%3BjettySize%3Dauto%3Bhtml%3D1%3BentryX%3D0%3BentryY%3D0.5%3BentryDx%3D0%3BentryDy%3D0%3BendArrow%3Dnone%3BendFill%3D0%3B%22%20parent%3D%221%22%20source%3D%22NY2RaFPMxS_D9FvXeHKu-2%22%20target%3D%22NY2RaFPMxS_D9FvXeHKu-3%22%20edge%3D%221%22%3E%0A%20%20%20%20%20%20%20%20%20%20%3CmxGeometry%20relative%3D%221%22%20as%3D%22geometry%22%3E%3C%2FmxGeometry%3E%0A%20%20%20%20%20%20%20%20%3C%2FmxCell%3E%0A%20%20%20%20%20%20%20%20%3CmxCell%20id%3D%22NY2RaFPMxS_D9FvXeHKu-2%22%20value%3D%22Client%22%20style%3D%22html%3D1%3BwhiteSpace%3Dwrap%3B%22%20parent%3D%221%22%20vertex%3D%221%22%3E%0A%20%20%20%20%20%20%20%20%20%20%3CmxGeometry%20x%3D%2290%22%20y%3D%2250%22%20width%3D%22110%22%20height%3D%2250%22%20as%3D%22geometry%22%3E%3C%2FmxGeometry%3E%0A%20%20%20%20%20%20%20%20%3C%2FmxCell%3E%0A%20%20%20%20%20%20%20%20%3CmxCell%20id%3D%22NY2RaFPMxS_D9FvXeHKu-9%22%20style%3D%22edgeStyle%3DorthogonalEdgeStyle%3Brounded%3D0%3BorthogonalLoop%3D1%3BjettySize%3Dauto%3Bhtml%3D1%3BendArrow%3Dnone%3BendFill%3D0%3B%22%20parent%3D%221%22%20source%3D%22NY2RaFPMxS_D9FvXeHKu-3%22%20target%3D%22NY2RaFPMxS_D9FvXeHKu-8%22%20edge%3D%221%22%3E%0A%20%20%20%20%20%20%20%20%20%20%3CmxGeometry%20relative%3D%221%22%20as%3D%22geometry%22%3E%3C%2FmxGeometry%3E%0A%20%20%20%20%20%20%20%20%3C%2FmxCell%3E%0A%20%20%20%20%20%20%20%20%3CmxCell%20id%3D%22NY2RaFPMxS_D9FvXeHKu-16%22%20style%3D%22edgeStyle%3DorthogonalEdgeStyle%3Bshape%3Dconnector%3Brounded%3D0%3BorthogonalLoop%3D1%3BjettySize%3Dauto%3Bhtml%3D1%3BlabelBackgroundColor%3Ddefault%3BstrokeColor%3Ddefault%3BfontFamily%3DHelvetica%3BfontSize%3D11%3BfontColor%3Ddefault%3BendArrow%3Dnone%3BendFill%3D0%3B%22%20parent%3D%221%22%20source%3D%22NY2RaFPMxS_D9FvXeHKu-3%22%20target%3D%22NY2RaFPMxS_D9FvXeHKu-4%22%20edge%3D%221%22%3E%0A%20%20%20%20%20%20%20%20%20%20%3CmxGeometry%20relative%3D%221%22%20as%3D%22geometry%22%3E%3C%2FmxGeometry%3E%0A%20%20%20%20%20%20%20%20%3C%2FmxCell%3E%0A%20%20%20%20%20%20%20%20%3CmxCell%20id%3D%22NY2RaFPMxS_D9FvXeHKu-3%22%20value%3D%22Visit%22%20style%3D%22html%3D1%3BwhiteSpace%3Dwrap%3B%22%20parent%3D%221%22%20vertex%3D%221%22%3E%0A%20%20%20%20%20%20%20%20%20%20%3CmxGeometry%20x%3D%22310%22%20y%3D%22240%22%20width%3D%22110%22%20height%3D%2250%22%20as%3D%22geometry%22%3E%3C%2FmxGeometry%3E%0A%20%20%20%20%20%20%20%20%3C%2FmxCell%3E%0A%20%20%20%20%20%20%20%20%3CmxCell%20id%3D%22NY2RaFPMxS_D9FvXeHKu-4%22%20value%3D%22Receipt%22%20style%3D%22html%3D1%3BwhiteSpace%3Dwrap%3B%22%20parent%3D%221%22%20vertex%3D%221%22%3E%0A%20%20%20%20%20%20%20%20%20%20%3CmxGeometry%20x%3D%22310%22%20y%3D%2250%22%20width%3D%22110%22%20height%3D%2250%22%20as%3D%22geometry%22%3E%3C%2FmxGeometry%3E%0A%20%20%20%20%20%20%20%20%3C%2FmxCell%3E%0A%20%20%20%20%20%20%20%20%3CmxCell%20id%3D%22NY2RaFPMxS_D9FvXeHKu-15%22%20style%3D%22edgeStyle%3DorthogonalEdgeStyle%3Bshape%3Dconnector%3Brounded%3D0%3BorthogonalLoop%3D1%3BjettySize%3Dauto%3Bhtml%3D1%3BentryX%3D1%3BentryY%3D0.5%3BentryDx%3D0%3BentryDy%3D0%3BlabelBackgroundColor%3Ddefault%3BstrokeColor%3Ddefault%3BfontFamily%3DHelvetica%3BfontSize%3D11%3BfontColor%3Ddefault%3BendArrow%3Dnone%3BendFill%3D0%3B%22%20parent%3D%221%22%20source%3D%22NY2RaFPMxS_D9FvXeHKu-5%22%20target%3D%22NY2RaFPMxS_D9FvXeHKu-3%22%20edge%3D%221%22%3E%0A%20%20%20%20%20%20%20%20%20%20%3CmxGeometry%20relative%3D%221%22%20as%3D%22geometry%22%3E%3C%2FmxGeometry%3E%0A%20%20%20%20%20%20%20%20%3C%2FmxCell%3E%0A%20%20%20%20%20%20%20%20%3CmxCell%20id%3D%22NY2RaFPMxS_D9FvXeHKu-5%22%20value%3D%22Employee%22%20style%3D%22html%3D1%3BwhiteSpace%3Dwrap%3B%22%20parent%3D%221%22%20vertex%3D%221%22%3E%0A%20%20%20%20%20%20%20%20%20%20%3CmxGeometry%20x%3D%22550%22%20y%3D%2250%22%20width%3D%22110%22%20height%3D%2250%22%20as%3D%22geometry%22%3E%3C%2FmxGeometry%3E%0A%20%20%20%20%20%20%20%20%3C%2FmxCell%3E%0A%20%20%20%20%20%20%20%20%3CmxCell%20id%3D%22NY2RaFPMxS_D9FvXeHKu-8%22%20value%3D%22Service%22%20style%3D%22html%3D1%3BwhiteSpace%3Dwrap%3B%22%20parent%3D%221%22%20vertex%3D%221%22%3E%0A%20%20%20%20%20%20%20%20%20%20%3CmxGeometry%20x%3D%22310%22%20y%3D%22360%22%20width%3D%22110%22%20height%3D%2250%22%20as%3D%22geometry%22%3E%3C%2FmxGeometry%3E%0A%20%20%20%20%20%20%20%20%3C%2FmxCell%3E%0A%20%20%20%20%20%20%3C%2Froot%3E%0A%20%20%20%20%3C%2FmxGraphModel%3E%0A%20%20%3C%2Fdiagram%3E\"></iframe>"
    params = ["path=\"#{TEST_FILE}\"", "page_number=0", "height=432"]
    converter = create_converter(params)
    result = converter.render(nil)
    assert_equal expected_result, result
  end
end