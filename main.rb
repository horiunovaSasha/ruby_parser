require 'csv'
require "./parsers/list_parser.rb"
require "./parsers/category_parser.rb"
require "./output/csv_saver.rb"

SHOP_URL = 'https://clutches.com.ua/shop'

categoryParse = CategoryParser.new(SHOP_URL)
categoryParse.parse()


mainParser = ListParser.new(SHOP_URL)
mainParser.parse()

CsvSaver.save()
