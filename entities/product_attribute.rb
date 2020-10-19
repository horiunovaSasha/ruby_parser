class ProductAttribute
    attr_accessor :attribute, :value

    def initialize(attribute, value)
        @attribute = attribute
        @value = value
    end
end