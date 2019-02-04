# Service for finding image files in an 
class FindImageFiles < Service
  attr_reader :image_analysis

  ACCEPTED_FILE_EXTENSIONS = [
    'jpg',
    'jpeg'
  ].freeze

  # @param [ImageAnalysis] image_analysis Analysis containing the directory reference to be searched.
  def initialize(image_analysis)
    @image_analysis = image_analysis
  end

  # Sets the @image_file_paths collection attribute on this service's @image_analysis instance with paths matching
  # accepted files.
  def call
    puts "Looking for images in #{image_analysis.working_dir.inspect}.."

    image_analysis.image_file_paths = Dir.glob(
      image_analysis.working_dir + "/**/*.{#{ACCEPTED_FILE_EXTENSIONS.join(',')}}"
    )
  end
end
