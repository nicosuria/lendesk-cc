# Load Project files
Dir[__dir__ + "/app/**/*.rb"].each { |project_file| require project_file }

# POSIX-style CLI options
require 'getoptlong'

# Default configuration
working_dir = Dir.pwd
presenter_service = TerminalPresenter

options = GetoptLong.new(
  ['--help',   '-h', GetoptLong::OPTIONAL_ARGUMENT],
  ['--dir',    '-d', GetoptLong::OPTIONAL_ARGUMENT],
  ['--format', '-f', GetoptLong::OPTIONAL_ARGUMENT],
)

puts <<-EOF
Run with the -h option to show Help.

EOF

options.each do |option, value|
  case option
  when '--help'
    puts <<-EOF
ruby app.rb [OPTION]

-h, --help:
     show help

-d, --dir [absolute_path]:
     Target directory to analyze images in. Defaults to present working directory.

-f, --format [format]:
     Toggles the output of the program. Accepted values are 'csv', 'html', and 'terminal.'
       - csv  : Generates a CSV file then prints its path on the terminal.
       - html : Generates an HTML page then prints its path on the terminal.
       - terminal : (Default value) Displays the output on the terminal.
    EOF
    return
  when '--dir'
    unless value == ''
      working_dir = value
    end
  when '--format'
    case value
    when "csv"
      presenter_service = CsvPresenter
    when "html"
      presenter_service = HtmlPresenter
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
