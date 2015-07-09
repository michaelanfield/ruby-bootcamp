require 'pry'

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