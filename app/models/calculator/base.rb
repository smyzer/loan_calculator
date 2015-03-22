module Calculator
  class Base
    # TODO add check that attributes changed to do recalculate of payments
    extend ActiveModel::Naming
    extend ActiveModel::Translation
    include ActiveModel::Validations

    # TODO implement ability store object with errors into object's ValidationError
    ValidationError = Class.new(StandardError)
    Payment = Struct.new(:month, :repayment_credit, :repayment_percent, :total, :rest)

    attr_accessor :interest_rate, :period, :amount
    attr_reader :payments, :total_repayment_credit, :total_repayment_percent, :total_repayment

    validates :interest_rate, 
              presence: true, 
              numericality: { greater_than: 0 }
    validates :amount, 
              presence: true, 
              numericality: { greater_than: 0 }
    validates :period, 
              presence: true, 
              numericality: { greater_than: 0, only_integer: true }

    def initialize(options)
      @errors = ActiveModel::Errors.new(self)
      options.each do |k, v|
        public_send("#{ k }=", v)
      end
      raise ValidationError, self.errors.full_messages.join(', ') unless valid?
      @interest_rate = @interest_rate.to_d
      @period = @period.to_i
      @amount = @amount.to_d
      @interest_rate /= 12 * 100.0
      @payments = []
    end

    def calculate
      @period.times do
        @payments << calculate_payment(@payments.last)
      end
      total_calculation
      payments
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

    def calculate_payment(*args)
      raise 'need to implement'
    end
  end
end