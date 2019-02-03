# Service for finding image files
class FindImageFiles < Service
  attr_reader :directory

  ACCEPTED_FILE_EXTENSIONS = [
    'jpg',
    'jpeg'
  ].freeze

  def initialize(directory)
    @directory = directory
  end

  def call
    puts "Looking for images in #{directory.inspect}.."

    Dir.glob(directory + "/**/*.{#{ACCEPTED_FILE_EXTENSIONS.join(',')}}")
  end
end
