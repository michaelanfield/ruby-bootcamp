require 'pry'
require 'money'

price_list = "orange = 10p apple = 20p bread = £1.10 tomato = 25p cereal = £2.34" 

shopping_list=<<LIST
 list
 orange
 apple
 apple
 orange
 tomato
 cereal
 bread
 orange
 tomato
LIST

=begin
Given the following price list and shopping list print out the total cost of 
the shopping list in pounds and pence
=end 

price_list = price_list.gsub(' = ', '=').gsub('p','').gsub('£','').gsub('.', '').split.map { |item| item.split('=') }.to_h
total = shopping_list.split.map { |item| price_list[item].to_i || 0 }.reduce(:+)

p "The price of the shopping list is: #{Money.new(total, 'GBP').format}"