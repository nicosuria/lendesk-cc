# A configurable analysis of all the images in a directory.
class ImageAnalysis
  attr_reader :working_dir, :analysis_services, :presenter_service
  attr_accessor :image_file_paths, :analyzed_images, :results_set

  # @param [String] working_dir The absolute path to be scanned.
  # @param [Array <Service>] analysis_services Collection of Services that will be called in sequence on this instance. 
  # @param [Service] presenter_service Service that will be called to present the results of this analysis.
  def initialize(working_dir, analysis_services:, presenter_service:)
    @working_dir = working_dir
    @analysis_services = analysis_services
    @presenter_service = presenter_service

    @image_file_paths = []
    @analyzed_images = []
    @results_set = []
  end

  def perform!
    analysis_services.each do |analysis_service|
      analysis_service.call(self)
    end
  end
end
