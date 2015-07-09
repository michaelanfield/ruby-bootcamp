require 'pry'
require 'money'

prices = {
      'orange' => 10,
      'apple' => 20,
      'bread' => 100,
      'tomato' => 25,
      'cereal' => 234
}

shopping_list = [:orange, :apple, :apple, :cereal, :bread]


#TODO - print out in pounds and pence the total for the shopping list
# Msg:: The price of the shopping list is: £pounds.pence

total = shopping_list.map { |item| prices[item.to_s]  }.reduce(:+)

# binding.pry
p "The price of the shopping list is: £#{sprintf('%03d', total).insert(-3, '.')}"

# Example using the string formatter, converting the total to a float so
# we can convert it to pounds and pence.
p "The price of the shopping list is: £#{'%.2f' % (total.to_f / 100)}"

# Example using the money gem
p "The price of the shopping list is: #{Money.new(total, "GBP").format}"