require 'rails_helper'

RSpec.describe Calculator::Builder, type: :model do
  let(:params_for_calculator) { { interest_rate: 12, period: 12, amount: 12000 } }

  describe ".build" do
    let(:invalid_params_for_calculator) { params_for_calculator.merge({ type: :undefined }) }
    let(:params_for_standard_calculator) { params_for_calculator.merge({ type: :standard }) }
    let(:params_for_annuity_calculator) { params_for_calculator.merge({ type: :annuity }) }

    context "invalid type of calculator" do
      subject { described_class.build(invalid_params_for_calculator) }

      it "raise UndefinedCalculatorType" do
        expect { subject }.to raise_error(Calculator::Builder::UndefinedCalculatorType)
      end
    end

    context "valid type of calculator" do
      context "type is standard" do
        subject { described_class.build(params_for_standard_calculator) }

        it "returns standard calculator" do
          expect(subject).to be_a Calculator::Standard
        end
      end

      context "type is annuity" do
        subject { described_class.build(params_for_annuity_calculator) }

        it "returns annuity calculator" do
          expect(subject).to be_a Calculator::Annuity
        end
      end
    end
  end
end
