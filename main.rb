require 'csv'
require "./parsers/list_parser.rb"
require "./output/csv_saver.rb"

mainParser = ListParser.new('https://clutches.com.ua/shop')
mainParser.parse()

path = 'products_full_info.csv'
CsvSaver.save()
