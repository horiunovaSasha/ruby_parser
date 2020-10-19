require 'nokogiri'
require 'open-uri'
require './parsers/product_parser.rb'
require "./data_providers/product_provider.rb"

class ListParser
    CSS_SELECTOR = '.wf-container div.wf-cell article figure.woocom-project figcaption.woocom-list-content h4.entry-title a'
    
    def initialize(url)
        @url = url
    end

    def parse()
        html = open(@url)
        doc = Nokogiri::HTML(html)

        doc.css(CSS_SELECTOR).each do |link|
            ProductParser
                .new(link['href'])
                .parse()
        end

        next_link = nil#doc.css('div.paginator a.nav-next').first()

        unless next_link.nil? then
            puts ProductProvider.get_all().count()
            @url = next_link['href']
            parse()
        end
        
    end
end