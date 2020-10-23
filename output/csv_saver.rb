require "./data_providers/product_provider.rb"

class CsvSaver
    def self.save()
        path = 'products_full_info.csv'
        products = ProductProvider.get_all()
        
        File.new(path, "w")
        CSV.open(path, 'w', headers: ['Id', 'Title', 'Description', 'Price', 'Vendor Code', 'Availability', 'Categories', 'Images', 'Attributes'], write_headers: true) do |csv|
            products.each do |product|
                csv << [
                    product.id, 
                    product.title, 
                    product.description, 
                    product.price, 
                    product.vendor_code, 
                    product.availability, 
                    product.categories.map{|c| c.name}.join('|'),
                    product.images.join('|'),
                    product.attributes.map{|a| a.attribute.title + '|' + a.value.value}.join('#')
                ]
            end
        end
    end
end 