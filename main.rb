require 'csv'
require "./parsers/list_parser.rb"

mainParser = ListParser.new('https://clutches.com.ua/shop')
mainParser.parse()

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

path = 'products.csv'
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
            product.categories.map{|c| c.id.to_s}.join('|'),
            product.images.join('|'),
            product.attributes.map{|a| a.attribute.id.to_s + '|' + a.value.id.to_s}.join('#')
        ]
    end
end