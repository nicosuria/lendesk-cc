require 'erb'
require 'fileutils'

# Service that presents a table onto a HTML file.
class HtmlPresenter < PresenterService
  def call
    FileUtils.mkdir_p 'tmp/output'


    File.open(filename, 'w+') do |f|
      f.write html_result
    end

    puts "Results generated to #{absolute_filepath.inspect}"
  end

  private

  def absolute_filepath
    [__dir__, filename].join('/')
  end

  def filename
    "tmp/output/#{Time.now.strftime("%Y%m%d%H%M%S")}-image-analysis.html"
  end

  def html_result
    ERB.new(template).result(binding)
  end

  def template
    File.read(__dir__ + '/templates/output.html.erb')
  end
end
