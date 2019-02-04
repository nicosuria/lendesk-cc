# POSIX-style CLI options
require 'getoptlong'
require_relative 'app/service'
Dir[Dir.pwd + "/app/**/*.rb"].each { |project_file| require project_file }

options = GetoptLong.new(
  ['--dir', '-d', GetoptLong::OPTIONAL_ARGUMENT],
)

working_dir = Dir.pwd
format = "terminal"

options.each do |option, value|
  case option
  when '--dir'
    unless value == ''
      working_dir = value
    end
  when '--format'
    case value
    when "csv"
      format = "csv"
    else
      raise ArgumentError, "Unrecognized format: #{value.inspect}"
    end
  else
    raise ArgumentError, "Unrecognized argument: #{option.inspect}"
  end
end

#format_service =  case format
                  #when 'terminal'
                    #PresentOnTerminal
                  #when 'csv'
                    #PresentAsCSV
                  #end

image_analysis = ImageAnalysis.new(
  working_dir,
  analysis_services: [
    FindImageFiles,
    AnalyzeImages,
    PresentResults
  ],
  presenter_service: TerminalPresenter
)

image_analysis.perform!
