require_relative "service"

# Service subclass that presents a table.
class PresenterService < Service
  attr_reader :rows, :headings

  def initialize(headings:, rows:)
    @headings = headings
    @rows = rows
  end
end
