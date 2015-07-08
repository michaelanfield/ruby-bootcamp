require 'pry'

def loopFor(numbers)
	total = 0

	for i in numbers
		#binding.pry
		total += i
	end

	total
end	

puts "The total of the for loop example is #{loopFor(1..3)}"


def loopWhile(maxNumber)
	total = 0
	i = 1

	while i <= maxNumber
		total += i
		i += 1
	end

	total
end

puts "The total of the while loop example is #{loopWhile(4)}"


def loopEach(numbers)
	total = 0

	numbers.each do |i|
		total += i
	end

	total
end

puts "The total of the each loop example is #{loopEach(1..5)}"


total = 0

(1..5).each { |i| total += i }

puts "Inline each total is #{total}"