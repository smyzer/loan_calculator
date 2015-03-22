shared_examples "calculator" do
  let(:params_for_calculator) { { interest_rate: 12, period: 12, amount: 12 } }
  let(:calculator) { described_class.new params_for_calculator }

  describe "#initialize" do
    context 'invalid params' do
      it "raises Calculator::Base::ValidationError" do
        expect {
          described_class.new({ interest_rate: nil, period: nil, amount: nil})
        }.to raise_error(Calculator::Base::ValidationError)
      end
    end

    context 'valid params' do
      subject { described_class.new(params_for_calculator) }

      it "should calculate interest rate" do
        expect(subject.interest_rate).to be == 0.01
      end
    end
  end

  describe "#read_attribute_for_validation" do
    subject { calculator.read_attribute_for_validation(:period) }

    it "returns value of attriute" do
      expect(subject).to be == 12
    end
  end

  describe ".lookup_ancestors" do
    subject { described_class.lookup_ancestors }

    it "wpars #{ described_class } into array" do
      expect(subject).to be == [described_class]
    end
  end
end