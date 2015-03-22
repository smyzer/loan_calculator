require 'rails_helper'
require 'shared_examples/calculator'

RSpec.describe Calculator::Standard, type: :model do
  it_behaves_like 'calculator'

  let(:params_for_calculator) { { interest_rate: 12, period: 12, amount: 12000 } }
  let(:calculator) { described_class.new params_for_calculator }

  describe "#calculate" do
    subject { calculator.calculate }

    it "returns array of payemnts" do
      expect(subject.size).to be == params_for_calculator[:period]
      expect(subject.all? { |e| e.is_a? described_class::Payment}).to be true
    end

    it "calculate total values" do
      subject
      expect(calculator.total_repayment_credit).to be == 12000.0.to_d
      expect(calculator.total_repayment_percent).to be == 780.0.to_d
      expect(calculator.total_repayment).to be == 12780.0.to_d
    end
  end
end
