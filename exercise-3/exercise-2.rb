# Write a function that combines two lists by alternatingly taking elements. 
# For example: given the two lists [a, b, c] and [1, 2, 3], the function should 
# return [a, 1, b, 2, c, 3].

def combine(list1, list2)
	[list1, list2].transpose.flatten
end

puts combine(["a", "b", "c"], [1, 2, 3]).to_s

def zipcombine(list1, list2)
	list1.zip(list2).flatten
end

puts zipcombine(["a", "b", "c"], [1, 2, 3]).to_s