require_relative "../../app/service"
require_relative "../../app/presenter_service"
require_relative "../../app/services/terminal_presenter"
require 'terminal-table'

describe TerminalPresenter do
  include_context "Suppress STDOUT"

  let(:headings) do
    ["Song", "Artist"]
  end

  let(:rows) do
    [
      ["41", "Dave Matthews Band"],
      ["Hurt", "Johnny Cash"]
    ]
  end

  subject do
    described_class.send(:new, headings: headings, rows: rows)
  end

  describe "#call" do
    it "calls the terminal presentation service" do
      expect(Terminal::Table).to receive(:new).with(headings: headings, rows: rows)
      subject.call
    end
  end
end
