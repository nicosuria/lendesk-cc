require_relative '../../app/service'
require_relative '../../app/presenter_service'
require_relative '../../app/services/html_presenter'
require 'hpricot'

describe HtmlPresenter do
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
    before do
      allow(Time).to receive(:now).and_return(Time.new(1986,4,28,14,6))
    end

    let(:expected_filename) do
      Dir.pwd + "/tmp/output/19860428140600-image-analysis.html"
    end

    it "builds an HTML page" do
      subject.call

      open(expected_filename) do |file|
        html = Hpricot(file)

        html_table_headers = html.search("//table//thead//tr//th").map { |element| element.inner_html.strip }
        html_body_rows = html.search("//table//tbody//tr//td").map { |element| element.inner_html.strip }

        expect(html_table_headers).to eq headings
        expect(html_body_rows).to eq rows.flatten
      end
    end
  end
end
