require 'pry'

def loop_for(numbers)
	total = 0

	for number in numbers
		#binding.pry
		total += number
	end

	total
end	

puts "The total of the for loop example is #{loop_for([1, 2, 3])}"


def loop_while(numbers)
	total = 0
	i = 0

	while i < numbers.length
		total += numbers.fetch(i)
		i += 1
	end

	total
end

puts "The total of the while loop example is #{loop_while([1, 2, 3, 4])}"


def loop_each(numbers)
	total = 0

	numbers.each do |i|
		total += i
	end

	total
end

puts "The total of the each loop example is #{loop_each([1, 2, 3, 4, 5])}"


total = 0

[1, 2, 3, 4, 5].each { |i| total += i }

puts "Inline each total is #{total}"