require_relative '../override_string'

module Exercise14
	module DSLBuilder

		attr_reader :method_name_overrides, 
								:method_data_types,
								:body

		def method_missing(method, *args, &block)
			debug_method_call(method, *args)

			method_name = clean_method_name(method)

			if block_given?
				if !args.empty?
					method_value = Call.build(args, &block).body
				else
					method_value = Statement.build(@debug, *args, &block).body
				end

				register_method_value(method_name, method_value)
			else
				register_method_value(method_name, args.first)
			end
		end

		private 
		def clean_method_name(method_name)
			debug_method_call('clean_method_name', method_name) if method_name.to_s.include? '_'

			method_name.to_s.camel_case_lower.to_sym
		end

		def register_method_value(method_name, method_value)
			debug_method_call('register_method_value', method_name, method_value)

			resolved_method_name = method_name_overrides[method_name] || method_name
			resolved_method_data_type = method_data_types[method_name] || {}

			if resolved_method_name.is_a?(Array)

				resolved_method_name.each_with_index do |override, index|
					body[override] = body[override] || resolved_method_data_type

					body[override][method_name] = method_value
				end
			else
				if resolved_method_data_type.is_a?(Array)
					body[resolved_method_name] = (body[resolved_method_name] || resolved_method_data_type) << method_value
				else
					body[resolved_method_name] = method_value
				end
			end
		end

		def debug_method_call(method, *args)
			if @debug
				p "Calling method #{method}"
				args.each_with_index do |arg, index|
					p "#{index} - #{arg}:#{arg.class}"
				end
			end
		end
	end
end