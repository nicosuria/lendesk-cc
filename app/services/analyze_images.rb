# Service that builds exif data from a collection of image paths.
require "exifr/jpeg"
require "ostruct"

class AnalyzeImages < Service
  attr_reader :image_analysis

  # @param [ImageAnalysis] image_analysis Analysis containing the list of image paths to be analyzed.
  def initialize(image_analysis)
    @image_analysis = image_analysis
  end

  # Sets the @analyzed_images collection attribute on this service's @image_analysis instance.
  def call
    image_analysis.analyzed_images = image_analysis.image_file_paths.map do |image_path|
      OpenStruct.new({
        filename: File.basename(image_path),
        analysis: EXIFR::JPEG.new(image_path)
      })
    end
  end
end


