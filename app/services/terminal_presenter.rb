# Service that displays a hash onto the terminal
require 'terminal-table'

class TerminalPresenter < Service
  attr_reader :rows, :headings

  def initialize(headings:, rows:)
    @headings = headings
    @rows = rows
  end

  def call
    puts Terminal::Table.new(headings: headings, rows: rows)
  end
end
