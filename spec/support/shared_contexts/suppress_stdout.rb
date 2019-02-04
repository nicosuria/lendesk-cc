shared_context "Suppress STDOUT" do
  before do
    allow_any_instance_of(described_class).to receive(:puts)
    allow_any_instance_of(described_class).to receive(:print)
  end
end
