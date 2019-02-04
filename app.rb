# POSIX-style CLI options
require 'getoptlong'
require_relative 'app/service'
Dir[Dir.pwd + "/app/**/*.rb"].each { |project_file| require project_file }

# Default configuration
working_dir = Dir.pwd
presenter_service = TerminalPresenter

options = GetoptLong.new(
  ['--dir',    '-d', GetoptLong::OPTIONAL_ARGUMENT],
  ['--format', '-f', GetoptLong::OPTIONAL_ARGUMENT],
)

options.each do |option, value|
  case option
  when '--dir'
    unless value == ''
      working_dir = value
    end
  when '--format'
    case value
    when "csv"
      presenter_service = CsvPresenter
    else
      raise ArgumentError, "Unrecognized format: #{value.inspect}"
    end
  else
    raise ArgumentError, "Unrecognized argument: #{option.inspect}"
  end
end

image_analysis = ImageAnalysis.new(
  working_dir,
  analysis_services: [
    FindImageFiles,
    AnalyzeImages,
    PresentResults
  ],
  presenter_service: presenter_service
)

image_analysis.perform!
