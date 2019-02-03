# Service that displays a hash onto the terminal
require 'terminal-table'

class PresentOnTerminal < Service
  attr_reader :results

  def initialize(results)
    @results = results
  end

  def call
    puts Terminal::Table.new(headings: headings, rows: rows)
  end

  def rows
    results.map do |result|
      [
        result.filename,
        result.latitude,
        result.longitude
      ]
    end
  end

  private

  def headings
    [
      "Filename",
      "Latitude",
      "Longitude"
    ]
  end
end
