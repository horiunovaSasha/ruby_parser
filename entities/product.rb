class Product
    attr_accessor :id, :title, :description, :price, :availability, :vendor_code, :images, :attributes, :categories

    def initialize()
        @images = []
        @attributes = []
        @categories = []
    end

end