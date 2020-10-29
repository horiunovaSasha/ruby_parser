require "./entities/category.rb"

class CategoryProvider
    @@categories = []

    def self.get_by_name(item)
       category = @@categories.detect{|e| e.name == item.name }

       if category.nil? then
            if item.id.nil? then 
                item.id = @@categories.count() + 1
            end 
            @@categories.push(item)
            return @@categories.last()
       end
            
       category
    end

    def self.get_all()
        @@categories
    end
end