require_relative "../../app/service"
require_relative "../../app/presenter_service"
require_relative "../../app/services/csv_presenter"
require 'csv'

describe CsvPresenter do
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
    let(:random_timestamp) do
      Time.at(rand * Time.now.to_i)
    end

    before do
      allow(Time).to receive(:now).and_return(random_timestamp)
    end

    let(:expected_filename) do
      Dir.pwd + "/tmp/output/#{random_timestamp.strftime('%Y%m%d%H%M%S')}-image-analysis.csv"
    end


    it "builds a CSV" do
      subject.call
      csv_results = CSV.read(expected_filename)

      expect(csv_results[0]).to eq headings
      expect(csv_results[1]).to eq rows[0]
      expect(csv_results[2]).to eq rows[1]
    end
  end
end
