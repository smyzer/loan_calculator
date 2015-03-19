module Calculator
  class Builder
    UndefinedCalculatorType = Class.new(StandardError)

    class << self
      def build(options)
        type = options.delete(:type).try(:to_sym)
        case type
          when :standard
            Calculator::Standard.new(options)
          when :annuity
            Calculator::Annuity.new(options)
          else
            raise UndefinedCalculatorType, "Undefined type of calculator `#{ type }`"
        end
      end
    end
  end
end