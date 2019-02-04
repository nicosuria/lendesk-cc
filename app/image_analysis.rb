class ImageAnalysis
  attr_reader :working_dir, :analysis_services, :presenter_service
  attr_accessor :image_file_paths, :analyzed_images, :results_set

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


