require_relative "../../app/service"
require_relative "../../app/presenter_service"
require_relative "../../app/services/csv_presenter"

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
    let(:expected_filename) do
      allow(Time).to receive(:now).and_return(Time.new(1986,4,28,14,6))
      "tmp/output/19860428140600-image-analysis.csv"
    end

    let(:csv_proxy) do
      double :csv
    end

    it "builds a CSV" do
      expect(CSV).to receive(:open).with(expected_filename, "wb").and_yield(csv_proxy)
      expect(csv_proxy).to receive(:"<<").with(["Song", "Artist"])
      expect(csv_proxy).to receive(:"<<").with(["41", "Dave Matthews Band"])
      expect(csv_proxy).to receive(:"<<").with(["Hurt", "Johnny Cash"])

      subject.call
    end
  end
end
