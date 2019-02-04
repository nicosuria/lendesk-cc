require "spec_helper"

require_relative "../../app/service"
require_relative "../../app/image_analysis"
require_relative "../../app/services/analyze_images"

describe AnalyzeImages do
  let(:image_analysis) do
    ImageAnalysis.new("/tmp", analysis_services: [], presenter_service: nil)
  end

  before { image_analysis.image_file_paths = [:one, :two, :three] }

  subject { described_class.new(image_analysis) }

  it_behaves_like "a service"

  describe "#call" do
    example do
      expect(EXIFR::JPEG).to receive(:new).with(:one).ordered.and_return(:analyzed_one)
      expect(EXIFR::JPEG).to receive(:new).with(:two).ordered.and_return(:analyzed_two)
      expect(EXIFR::JPEG).to receive(:new).with(:three).ordered.and_return(:analyzed_three)

      expect {
        subject.call
      }.to change(image_analysis, :analyzed_images).to [:analyzed_one, :analyzed_two, :analyzed_three]
    end
  end
end
