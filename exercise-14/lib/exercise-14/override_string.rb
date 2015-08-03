class String

	# Takes a snake style string and converts it to camel case e.g. my_string => myString
  def camel_case_lower
    self.split('_').inject([]){ |buffer,e| buffer.push(buffer.empty? ? e : e.capitalize) }.join
  end
end