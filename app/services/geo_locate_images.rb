# Service that Geo tags images
require "exifr/jpeg"

class GeoLocateImages < Service
  def initialize(image_paths)
    @image_paths = image_paths
  end

  def call
    @image_paths.map do |image_path|
      exif_info = EXIFR::JPEG.new(image_path)
      gps = exif_info.gps

      {
        image: image_path,
        latitude: gps&.latitude,
        longitude: gps&.longitude
      }
    end
  end
end
