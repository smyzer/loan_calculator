module Calculator
	class Standard < Base

		def calculate
			@period.times do
				@payments << calculate_payment(@payments.last)
			end
			total_calculation
			payments
		end

		private

		def calculate_payment(last_payment = nil)
			last_payment ||= Payment.new(0, nil, nil, nil, amount)
			_repayment_credit = (@amount.to_f / @period)
			_month = last_payment.month + 1
			_repayment_percent = (last_payment.rest * @interest_rate )
			_rest = last_payment.rest - _repayment_credit
			_total = _repayment_percent + _repayment_credit
			Payment.new(_month, _repayment_credit, _repayment_percent, _total, _rest)
		end
	end
end
