require "spec_helper"

require_relative "../../app/service"
require_relative "../../app/image_analysis"
require_relative "../../app/services/analyze_images"

describe AnalyzeImages do
  let(:image_analysis) do
    ImageAnalysis.new("/tmp", analysis_services: [], presenter_service: nil)
  end

  before do
    image_analysis.image_file_paths = [
      '/Users/nico/image1.jpg',
      '/Users/nico/image2.jpg',
      '/Users/nico/image3.jpg'
    ]
  end

  subject { described_class.new(image_analysis) }

  it_behaves_like "a service"

  describe "#call" do
    let(:expected_analyses) do
      [
        OpenStruct.new(filename: "image1.jpg", analysis: :analyzed_one),
        OpenStruct.new(filename: "image2.jpg", analysis: :analyzed_two),
        OpenStruct.new(filename: "image3.jpg", analysis: :analyzed_three),
      ]
    end

    example do
      expect(EXIFR::JPEG).to receive(:new).with('/Users/nico/image1.jpg').ordered.and_return(:analyzed_one)
      expect(EXIFR::JPEG).to receive(:new).with('/Users/nico/image2.jpg').ordered.and_return(:analyzed_two)
      expect(EXIFR::JPEG).to receive(:new).with('/Users/nico/image3.jpg').ordered.and_return(:analyzed_three)

      expect {
        subject.call
      }.to change(image_analysis, :analyzed_images).to expected_analyses
    end
  end
end
