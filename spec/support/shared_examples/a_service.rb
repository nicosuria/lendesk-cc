shared_examples "a service" do
  example do
    expect(described_class).to respond_to(:call)
    expect(subject).to respond_to(:call)

    expect(described_class < Service).to be_truthy
  end
end
