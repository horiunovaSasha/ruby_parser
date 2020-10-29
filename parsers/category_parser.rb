require 'nokogiri'
require 'open-uri'
require "./entities/category.rb"
require "./data_providers/category_provider.rb"

class CategoryParser
    CSS_SELECTOR = '#woocommerce_product_categories-8 > ul.product-categories > li'
    
    def initialize(url)
        @url = url
    end

    def parse()
       begin
        html = open(@url)
        doc = Nokogiri::HTML(html)

        doc.css(CSS_SELECTOR).each do |item|
            category = Category.new()
            category.id  = item['class'].split(' ')[1].split('-')[2].to_s
            category.name  = item.css('>a').text           
            CategoryProvider.get_by_name(category)
            if item.css('.children').length >0  then
                item.css('li').each do |sub_item|
                    sub_category = Category.new()
                    sub_category.id = sub_item['class'].split(' ')[1].split('-')[2].to_s
                    sub_category.name = sub_item.css('>a').text 
                    sub_category.parent = category.id
                    CategoryProvider.get_by_name(sub_category)
                end
            end
        end
        rescue OpenURI::HTTPError => e
            puts e.message  
            puts "Site is not reachable!"
            abort
        end
    end

end