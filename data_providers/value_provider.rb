require "./entities/value.rb"

class ValueProvider
    @@values = []

    def self.get_by_value(val)
        value = @@values.detect{|e| e.value == val }

       if value.nil? then
            @@values.push(Value.new(@@values.count() + 1, val))
            return @@values.last()
       end
            
       value
    end

    def self.get_all()
        @@values
    end
end