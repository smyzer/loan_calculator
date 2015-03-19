module Calculator
  class Base
    extend ActiveModel::Naming
    extend ActiveModel::Translation
    include ActiveModel::Validations

    ValidationError = Class.new(StandardError)
    Payment = Struct.new(:month, :repayment_credit, :repayment_percent, :total, :rest)

    attr_accessor :interest_rate, :period, :amount
    attr_reader :payments, :total_repayment_credit, :total_repayment_percent, :total_repayment

    validates_presence_of :interest_rate, :period, :amount
    validates_numericality_of :interest_rate, :period, :amount

    def initialize(options)
      @errors = ActiveModel::Errors.new(self)
      options.each do |k, v|
        public_send("#{ k }=", v)
      end
      raise ValidationError, self.errors unless valid?
      @interest_rate /= 12 * 100.0
      @payments = []
    end

    def calculate
      raise 'Not implemented'
    end

    def read_attribute_for_validation(attr)
      send(attr)
    end

    def self.lookup_ancestors
      [self]
    end

    private

    def total_calculation
      @total_repayment_credit = payments.map(&:repayment_credit).sum
      @total_repayment_percent = payments.map(&:repayment_percent).sum
      @total_repayment = payments.map(&:total).sum
    end
  end
end