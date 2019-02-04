# Service that displays a hash onto the terminal
require "ostruct"

class PresentResults < Service
  attr_reader :image_analysis

  def initialize(image_analysis)
    @image_analysis = image_analysis
  end

  def call
    presenter_service.call(
      headings: headings,
      rows: rows
    )
  end

  private

  def presenter_service
    image_analysis.presenter_service
  end

  def headings
    [
      "Filename",
      "Latitude",
      "Longitude"
    ]
  end

  def rows
    image_analysis.analyzed_images.map do |image|
      [
        image.filename,
        image.analysis.gps_latitude,
        image.analysis.gps_longitude,
      ]
    end
  end
end
