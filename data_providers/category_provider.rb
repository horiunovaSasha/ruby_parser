require "./entities/category.rb"

class CategoryProvider
    @@categories = []

    def self.get_by_name(name)
       category = @@categories.detect{|e| e.name == name }

       if category.nil? then
            @@categories.push(Category.new(@@categories.count() + 1, name))
            return @@categories.last()
       end
            
       category
    end

    def self.get_all()
        @@categories
    end
end