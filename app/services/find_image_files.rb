# Service for finding image files
class FindImageFiles < Service
  attr_reader :image_analysis

  ACCEPTED_FILE_EXTENSIONS = [
    'jpg',
    'jpeg'
  ].freeze

  def initialize(image_analysis)
    @image_analysis = image_analysis
  end

  def call
    puts "Looking for images in #{image_analysis.working_dir.inspect}.."

    image_analysis.image_file_paths = Dir.glob(image_analysis.working_dir + "/**/*.{#{ACCEPTED_FILE_EXTENSIONS.join(',')}}")
  end
end
