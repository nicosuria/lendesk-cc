require_relative "../app/image_analysis.rb"
require_relative "../app/service.rb"

describe ImageAnalysis do
  let(:working_dir) do
    "/Users/test/test_directory"
  end

  class TestService < Service
    def initialize(analysis)
      @analysis = analysis
    end

    def call
      @analysis.output_rows << :success
    end
  end

  class TestPresenter; end

  subject(:image_analysis) do
    ImageAnalysis.new(
      @working_dir,
      analysis_services: [TestService],
      presenter_service: TestPresenter
    )
  end

  example do
    expect(image_analysis.working_dir).to eq(@working_dir)
    expect(image_analysis.analysis_services).to eq([TestService])
    expect(image_analysis.presenter_service).to eq(TestPresenter)
    expect(image_analysis.image_file_paths).to eq([])
    expect(image_analysis.output_rows).to eq([])
  end

  describe "#perform!" do
    example do
      image_analysis.perform!
      expect(image_analysis.output_rows).to eq [:success]
    end
  end
end
