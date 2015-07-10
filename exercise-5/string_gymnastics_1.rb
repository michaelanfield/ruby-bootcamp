require 'pry'
require 'money'

prices = {
      'orange' => 10,
      'apple' => 20,
      'bread' => 100,
      'tomato' => 25,
      'cereal' => 234
} 

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

The price of the shopping list is: £pounds.pence
=end 

# Items that are not in the prices hash are evaluated as 0 using .map
total = shopping_list.split.map { |item| prices[item] || 0 }.reduce(:+)

p "The price of the shopping list is: £#{'%.2f' % (total.to_f / 100)}"

# Firstly removes items from the shopping list that are not in the prices hash and then derives the total
total = shopping_list.split.reject { |item| !prices.key?(item) }.map { |item| prices[item] }.reduce(:+)

p "The price of the shopping list is: #{Money.new(total, 'GBP').format}"

# Items that are not in the prices hash are evaluated as 0 using .collect
total = shopping_list.split.collect { |item| prices.key?(item) ? prices[item] : 0 }.reduce(:+)

p "The price of the shopping list is: #{Money.new(total, 'GBP').format}"