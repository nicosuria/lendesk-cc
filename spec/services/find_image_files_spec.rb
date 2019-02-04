require "spec_helper"

require_relative "../../app/service"
require_relative "../../app/image_analysis"
require_relative "../../app/services/find_image_files"

describe FindImageFiles do
  include_context "Suppress STDOUT"

  let(:image_analysis) do
    ImageAnalysis.new("/tmp", analysis_services: [], presenter_service: nil)
  end

  subject do
    described_class.new(image_analysis)
  end

  it_behaves_like "a service"

  example do
    expect(described_class::ACCEPTED_FILE_EXTENSIONS).to eq(['jpg', 'jpeg'])
  end

  describe "#call" do
    before do
      allow(Dir).to receive(:glob).with("/tmp/**/*.{jpg,jpeg}").and_return([:file_path])
    end

    example do
      expect {
        subject.call
      }.to change(image_analysis, :image_file_paths).to [:file_path]
    end
  end
end
