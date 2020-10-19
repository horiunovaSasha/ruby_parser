class ProductProvider
    @@products = []

    def self.push(product)
       @@products.push(product)
    end

    def self.get_all()
        @@products
    end
end