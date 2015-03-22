require 'rails_helper'
require 'shared_examples/calculator'

RSpec.describe Calculator::Annuity, type: :model do
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
      expect(calculator.total_repayment_credit.to_f).to be == 12000.0
      expect(calculator.total_repayment_percent.to_f.round(2)).to be == 794.23
      expect(calculator.total_repayment.to_f.round(2)).to be == 12794.23
    end
  end
end
