# Define dynamic setter/getter mixin functionality
module Exercise14
  module DynamicAttributes

    def define_attribute(*names)
      names.each do |name|
        
        define_method name do |*args|
          attribute = "@#{name}"

          if args.empty?
            self.instance_variable_get(attribute)
          else
            self.instance_variable_set(attribute, args.first)
          end
        end
      end
    end
  end
end