require "./entities/attribute.rb"

class AttributeProvider
    @@attributes = []

    def self.get_by_title(title)
       attribute = @@attributes.detect{|e| e.title == title }

       if attribute.nil? then
            @@attributes.push(Atrribute.new(@@attributes.count() + 1, title))
            return @@attributes.last()
       end
            
       attribute
    end

    def self.get_all()
        @@attributes
    end
end