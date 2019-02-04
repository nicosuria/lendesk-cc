# Service that builds exif data from a collection of image paths
require "exifr/jpeg"

class AnalyzeImages < Service
  attr_reader :image_analysis

  def initialize(image_analysis)
    @image_analysis = image_analysis
  end

  def call
    image_analysis.analyzed_images = image_analysis.image_file_paths.map do |image_path|
      EXIFR::JPEG.new(image_path)
    end
  end
end

#gps = exif_info.gps

#OpenStruct.new({
  #filename: File.basename(image_path),
  #latitude: gps&.latitude,
  #longitude: gps&.longitude
#})
