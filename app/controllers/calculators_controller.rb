class CalculatorsController < ApplicationController
  def new
  end

  def calculate
    @calculator = Calculator::Builder.build(parms_for_calculator)
    @calculator.calculate
  rescue Calculator::Base::ValidationError => e
  	flash.now[:alert] = e.message
  	render :new
  end

  private

  def parms_for_calculator
  	_params = params.require(:calculator).permit(:interest_rate, :amount, :period, :type)
  	_params.each do |key, value|
  		_params[key] = value.gsub(',', '.')
  	end
  	_params
  end
end
