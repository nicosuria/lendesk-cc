# Service for finding image files
class FindImageFiles < Service
  ACCEPTED_FILE_EXTENSIONS = [
    'jpg',
    'jpeg'
  ].freeze

  def initialize(directory)
    @directory = directory
  end

  def call
    Dir.glob(@directory + "/**/*.{#{ACCEPTED_FILE_EXTENSIONS.join(',')}}")
  end
end
