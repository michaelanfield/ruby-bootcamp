require 'pry'
require 'money'

# Represents a shopping item with a name and a value in pence.
class ShoppingItem
	def self.available_items
		{
			orange: 10,
			apple: 20,
			bread: 110,
			tomato: 25,
			cereal: 234
		}
	end

	def self.fetch_item_by_name(shopping_item_name)
		self.available_items.assoc(shopping_item_name)
	end
end	

# Represents a shopping list containing an Array of shopping item
# names. It provides the functionality for interaction with the 
# shopping list including;
# * Adding an item to the list.
# * Calculating the total value of the list.
class ShoppingList
	attr_reader :shopping_items

	def initialize
		@shopping_items = []
	end

	def add_item(shopping_item_name)
		shopping_item = ShoppingItem.fetch_item_by_name(shopping_item_name)

		if shopping_item
			self.shopping_items << shopping_item
		else
			puts "Well we can't find an item for '#{shopping_item_name}' so I guess you can have it on us!"
		end
	end

	def calculate_total
		self.shopping_items.collect { |shopping_item| shopping_item[1] }.reduce(:+)
	end
end

# Represents a physical till, which scans items and adds them to a
# shopping list providing functionality to display the total cost.
class Till
	attr_reader :shopping_list

	def initialize
		@shopping_list = ShoppingList.new
	end

	def scan_item(shopping_item)
		self.shopping_list.add_item(shopping_item)
	end

	def total
		puts "The price of the shopping list is: #{Money.new(self.shopping_list.calculate_total, 'GBP').format}"
	end
end

till = Till.new
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

=begin
Given the following price list and shopping list print out the total cost of 
the shopping list in pounds and pence


gsub_price_list = price_list.gsub(' = ', '=').gsub('p','').gsub('£','').gsub('.', '').split.map { |item| item.split('=') }.to_h
total = shopping_list.split.map { |item| gsub_price_list[item].to_i || 0 }.reduce(:+)

p "The price of the shopping list is: #{Money.new(total, 'GBP').format}"

gsub_price_list = price_list.gsub(/ = /, '=').gsub(/[£.p]/,'').split.map { |item| item.split('=') }.to_h
total = shopping_list.split.map { |item| gsub_price_list[item].to_i || 0 }.reduce(:+)

p "The price of the shopping list is: #{Money.new(total, 'GBP').format}"
=end 