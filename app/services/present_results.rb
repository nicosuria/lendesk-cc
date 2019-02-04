# Service that displays a hash onto the terminal
require "ostruct"

class PresentResults < Service
  attr_reader :image_analysis

  # @param [ImageAnalysis] image_analysis Analysis containing analyses to be presented using its @presenter_service.
  def initialize(image_analysis)
    @image_analysis = image_analysis
  end

  # Forwards the constructed @headings and @rows to the @presenter_service configured in the @image_analysis.
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
        image.analysis.gps&.latitude,
        image.analysis.gps&.longitude,
      ]
    end
  end
end
