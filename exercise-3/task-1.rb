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

	while !numbers.empty?
		total += numbers.pop()
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

def loop_recursion(numbers, total = 0)
	return total if numbers.empty?
	loop_recursion(numbers, total += numbers.pop())
end

puts "The total of the recursive loop is #{loop_recursion([1, 2, 3, 4, 5])}"