require 'csv'
require 'fileutils'

# Service that presents a table onto a CSV file.
class CsvPresenter < PresenterService
  def call
    FileUtils.mkdir_p 'tmp/output'

    CSV.open(csv_filename, "wb") do |csv|
      csv << headings
      rows.each { |row| csv << row }
    end

    puts "Results generated to #{absolute_csv_filepath.inspect}"
  end

  private

  def absolute_csv_filepath
    [__dir__, csv_filename].join('/')
  end

  def csv_filename
    "tmp/output/#{Time.now.strftime("%Y%m%d%H%M%S")}-image-analysis.csv"
  end
end
