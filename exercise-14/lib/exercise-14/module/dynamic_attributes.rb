# Wraps up required modules for exercise 14
module Exercise14
  # Define dynamic setter/getter mixin functionality
  module DynamicAttributes
    def define_attribute(*names)
      names.each do |name|
        define_method name do |*args|
          attribute = "@#{name}"

          if args.empty?
            instance_variable_get(attribute)
          else
            instance_variable_set(attribute, args.first)
          end
        end
      end
    end
  end
end
