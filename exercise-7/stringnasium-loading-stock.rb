require 'pry'
require 'money'

# Represents a shopping item with a name and a value in pence.
class Stock
	attr_reader :price_list, :stock_items

	def initialize(price_list)
		@price_list = price_list
		@stock_items = parse_stock_items
	end

	def fetch_item_by_name(stock_item_name)
		stock_items.assoc(stock_item_name)
	end

	private

	def parse_stock_items
		raise ArgumentError, 'The price list must be a String in the format item = £1.28 or item = 20p' unless price_list.is_a? String

		price_list.scan(/(\w+) = £?([\d+\.]+)p?/).collect { |stock_item| [stock_item[0].to_sym, stock_item[1].gsub(/\./, '').to_i] }.to_h
	end
end	

# Represents a shopping list containing an Array of shopping items. It provides 
# the functionality for interaction with the shopping list including;
# * Adding an item to the list.
# * Calculating the total value of the list.
class ShoppingList
	attr_reader :shopping_items

	def initialize
		@shopping_items = []
	end

	def add_item(stock_item)
		shopping_items << stock_item
	end

	def calculate_total
		shopping_items.collect { |shopping_item| shopping_item.last }.reduce(:+)
	end
end

# Represents a physical till, which scans items and adds them to a
# shopping list providing functionality to display the total cost.
class Till
	attr_reader :stock, :shopping_list

	def initialize(stock)
		@stock = stock
		@shopping_list = ShoppingList.new
	end

	def scan_item(shopping_item)
		stock_item = stock.fetch_item_by_name(shopping_item)

		if stock_item
			shopping_list.add_item(stock_item)
		end
	end

	def total
		puts "The price of the shopping list is: #{Money.new(shopping_list.calculate_total, 'GBP').format}"
	end
end

stock = Stock.new("orange = 10p apple = 20p bread = £1.10 tomato = 25p cereal = £2.34")

till = Till.new(stock)

till.scan_item(:list)
till.scan_item(:orange)
till.scan_item(:apple)
till.scan_item(:apple)
till.scan_item(:orange)
till.scan_item(:tomato)
till.scan_item(:cereal)
till.scan_item(:bread)
till.scan_item(:orange)
till.scan_item(:tomato)
till.total
