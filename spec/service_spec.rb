require_relative "../app/service"

describe Service do
  example do
    expect_any_instance_of(described_class).to receive(:call).and_return(:service_interface_successful)
    expect(described_class.call).to eq(:service_interface_successful)

    expect {
      described_class.new
    }.to raise_exception(NoMethodError)
  end
end
