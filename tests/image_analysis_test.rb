require "test/unit"
require_relative "../app/image_analysis.rb"
require_relative "../app/service.rb"

class ImageAnalysisTest < Test::Unit::TestCase
  @working_dir = "/Users/test/test_directory"

  class TestService < Service
    def initialize(analysis)
      @analysis = analysis
    end

    def call
      @analysis.output_rows << :success
    end
  end

  class TestPresenter; end

  def prepare_subject
    ImageAnalysis.new(
      @working_dir,
      analysis_services: [TestService],
      presenter_service: TestPresenter
    )
  end

  def test_attributes
    @image_analysis = prepare_subject
    assert_equal(@image_analysis.working_dir, @working_dir)
    assert_equal(@image_analysis.analysis_services, [TestService])
    assert_equal(@image_analysis.presenter_service, TestPresenter)
    assert_equal(@image_analysis.image_file_paths, [])
    assert_equal(@image_analysis.output_rows, [])
  end

  def test_perform
    @image_analysis = prepare_subject
    @image_analysis.perform!
    assert_equal(@image_analysis.output_rows, [:success])
  end
end
