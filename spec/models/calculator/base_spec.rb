require 'rails_helper'
require 'shared_examples/calculator'

RSpec.describe Calculator::Base, type: :model do
	it_behaves_like 'calculator'
end
