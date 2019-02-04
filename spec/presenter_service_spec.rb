require_relative "../app/service"
require_relative "../app/presenter_service"

describe PresenterService do
  let(:headings) { [:heading1, :heading2] }
  let(:rows) { [:row1, :row2] }

  subject { described_class.send(:new, headings: headings, rows: rows) }

  it_behaves_like "a service"

  describe "accessors" do
    example do
      expect(subject.headings).to eq headings
      expect(subject.rows).to eq rows
    end
  end
end
