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
		puts "Found #{image_count} images to process.."
		image_analysis.analyzed_images = image_analysis.image_file_paths.each_with_index.map do |image_path, i|
			print "\rProcessing #{i + 1} of #{image_count}"
      print "\n" if (i+1 == image_count)
			OpenStruct.new({
				filename: File.basename(image_path),
				analysis: EXIFR::JPEG.new(image_path)
			})
		end
	end

	private

	def image_count
		@image_count ||= image_analysis.image_file_paths.size
	end
end


