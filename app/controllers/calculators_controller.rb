class CalculatorsController < ApplicationController
  def new
    render text: 'new'
  end

  def calculate
    render text: 'calculate'
  end
end
