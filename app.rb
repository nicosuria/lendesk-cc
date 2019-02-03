# POSIX-style CLI options
require 'getoptlong'
require_relative 'app/service'
Dir[Dir.pwd + "/app/**/*.rb"].each { |project_file| require project_file }

options = GetoptLong.new(
  ['--dir', '-d', GetoptLong::OPTIONAL_ARGUMENT],
)

working_dir = Dir.pwd

options.each do |option, value|
  case option
  when '--dir'
    unless value == ''
      working_dir = value
    end
  else
    raise ArgumentError, "Unrecognized argument: #{option.inspect}"
  end
end


class App < Service
  def initialize(working_dir:)
    @working_dir = working_dir
  end

  def call
    puts "Looking for images in #{@working_dir.inspect}.."
    @image_files = FindImageFiles.(@working_dir)
    warn "Warning: No image files found" if @image_files.empty?
    puts @image_files.inspect
    #@geo_location_results = GeoLocateImages.(@images)
  end
end

App.call(working_dir: working_dir)
