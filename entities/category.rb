class Category
    attr_accessor :id, :name, :parent

    def initialize(id = 0, name = '')
        @id = id
        @name = name
        @parent = 0
    end
end