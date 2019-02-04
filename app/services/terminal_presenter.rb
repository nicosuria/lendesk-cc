require 'terminal-table'

# Service that presents a table onto the terminal.
class TerminalPresenter < PresenterService
  def call
    puts Terminal::Table.new(headings: headings, rows: rows)
  end
end
