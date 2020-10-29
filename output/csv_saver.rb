require "./data_providers/product_provider.rb"
require "./data_providers/category_provider.rb"
require "./data_providers/category_provider.rb"

class CsvSaver
    def self.save()
        path = './output/categories.csv'
        categories = CategoryProvider.get_all()
        begin 
            File.new(path, "w")
            CSV.open(path, 'w', headers: ['Id', 'Name', 'Parent'], write_headers: true) do |csv|
                categories.each do |product|
                    csv << [
                        product.id, 
                        product.name, 
                        product.parent
                    ]
                end
            end
        rescue StandardError => e  
            puts e.message  
            puts "Can not open the file for writing categories" 
        end


        path = './output/products_full_info.csv'
        products = ProductProvider.get_all()
        begin
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
        
        rescue StandardError => e  
            puts e.message  
            puts "Can not open the file for writing products" 
        end
        
    end
end 