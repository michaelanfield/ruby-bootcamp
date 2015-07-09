# Write a function that computes the list of the first 100 Fibonacci numbers. By definition, 
# the first two numbers in the Fibonacci sequence are 0 and 1, and each subsequent number is 
# the sum of the previous two. As an example, here are the first 10 Fibonnaci numbers: 
# 0, 1, 1, 2, 3, 5, 8, 13, 21, and 34.

def fibonacci(sequence_up_to)
	fibonacci_sequence = [0, 1]

	(0...(sequence_up_to - 2)).each {
		fibonacci_sequence << fibonacci_sequence.last(2).reduce(0, :+)
	}

	fibonacci_sequence
end

p fibonacci(10)

# This was taken off the tinternet. Calculates the fibonacci number at that position
# rather than creating an array of fibonacci numbers up to the size supplied.

# def fib(n)
#   return n if (0..1).include? n
#   fib(n-1) + fib(n-2) if n > 1
# end

# puts fib(10)