# Write a function that computes the list of the first 100 Fibonacci numbers. By definition, 
# the first two numbers in the Fibonacci sequence are 0 and 1, and each subsequent number is 
# the sum of the previous two. As an example, here are the first 10 Fibonnaci numbers: 
# 0, 1, 1, 2, 3, 5, 8, 13, 21, and 34.

def fibonacci(max_to)
	fibonacci_sequence = [0, 1]

	index = 2
	while index < max_to
		next_numbers = fibonacci_sequence.last(2)

		fibonacci_sequence << next_numbers.first + next_numbers.last
		index += 1
	end

	fibonacci_sequence
end

puts fibonacci(10).to_s