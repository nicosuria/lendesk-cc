require "spec_helper"

require_relative "../../app/service"
require_relative "../../app/image_analysis"
require_relative "../../app/services/present_results"

describe PresentResults do
  let(:presenter_service) { double :presenter_service, call: true }

  let(:image_analysis) do
    ImageAnalysis.new("/tmp", analysis_services: [], presenter_service: presenter_service)
  end

  let(:image_one) do
    double(:analyzed_image, filename: "img1.jpg",
           analysis: double(:exif_jpg,
                            gps_latitude: :latitude_one,
                            gps_longitude: :longitude_one
                           ))
  end

  let(:image_two) do
    double(:analyzed_image, filename: "img2.jpg",
           analysis: double(:exif_jpg,
                            gps_latitude: :latitude_two,
                            gps_longitude: :longitude_two
                           ))
  end


  before { image_analysis.analyzed_images = [image_one, image_two] }

  subject do
    described_class.send(:new, image_analysis)
  end

  it_behaves_like "a service"

  describe "#call" do
    let(:expected_headings) do
      [
        "Filename",
        "Latitude",
        "Longitude"
      ]
    end

    let(:expected_rows) do
      [
        ['img1.jpg', :latitude_one, :longitude_one],
        ['img2.jpg', :latitude_two, :longitude_two]
      ]
    end

    example do
      expect(presenter_service).to receive(:call).with(headings: expected_headings, rows: expected_rows)
      subject.call
    end
  end
end
