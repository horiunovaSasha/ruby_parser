require 'nokogiri'
require 'open-uri'
require 'json'
require "./entities/product.rb"
require "./entities/attribute.rb"
require "./entities/product_attribute.rb"
require "./data_providers/attribute_provider.rb"
require "./data_providers/category_provider.rb"
require "./data_providers/product_provider.rb"
require "./data_providers/value_provider.rb"

class ProductParser
    CSS_SELECTOR = '.wf-container-main #content>div'
    CSS_TITLE_SELECTOR = '.entry-summary>h1'
    CSS_DESC_SELECTOR = '.entry-summary div[itemprop=description]>p:first-child'
    CSS_PRICE_SELECTOR = '.entry-summary div[itemprop=offers]>meta[itemprop=price]'
    CSS_AVAILABILITY_SELECTOR = '.entry-summary div[itemprop=offers]>link[itemprop=availability]'
    CSS_CATEGORIES_CODE_SELECTOR = '.entry-summary .product_meta span.posted_in a'
    CSS_VENDOR_CODE_SELECTOR = '.entry-summary .product_meta span.sku'
    IN_STOCK = 'https://schema.org/InStock'
    
    def initialize(url)
        @url = url
    end

    def parse()
        html = open(@url)
        doc = Nokogiri::HTML(html).css(CSS_SELECTOR).first()

        if (!doc.nil?) then
            product = Product.new()
            product.id = doc['id'].split('-')[1]
            product.title = doc.css(CSS_TITLE_SELECTOR).text
            product.description = doc.css(CSS_DESC_SELECTOR).text
            product.price = doc.css(CSS_PRICE_SELECTOR).first()['content']
            product.availability = doc.css(CSS_AVAILABILITY_SELECTOR).first()['href'] == IN_STOCK
            product.vendor_code = doc.css(CSS_VENDOR_CODE_SELECTOR).text

            doc.css('div.images a').each do |img|
                product.images.push(img['href'])
            end

            doc.css(CSS_CATEGORIES_CODE_SELECTOR).each do |link|
                product.categories.push(CategoryProvider.get_by_name(link.text))
            end

            parse_attributes(product, doc,'div#tab-description table tr')
            parse_attributes(product, doc,'div#tab-additional_information table tr')
            
            #product.attributes.each do |item|
            #    puts item.attribute.id.to_s + ' ' + item.attribute.title + ' | ' + item.value.id.to_s + ' ' + item.value.value
            #end

            ProductProvider.push(product)
        end
    end

    def parse_attributes(product, doc, selector)
        doc.css(selector).each do |item|
            tds = item.css('td')
            title = ''
            value = ''

            if tds.count() == 2 then
                title = tds.first().text
                value = tds.last().text     
            else
                title = item.css('th').first().text
                value = tds.first().text
            end

            unless title == '' && value == '' then
                attribute = AttributeProvider.get_by_title(title)
                #value.split(',').each do |val|
                product.attributes.push(ProductAttribute.new(attribute, ValueProvider.get_by_value(value)))
                #end
            end
        end
    end
end