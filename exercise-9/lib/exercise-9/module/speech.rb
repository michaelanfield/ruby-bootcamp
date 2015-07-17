module Exercise9
  module Speech
  	SHOUT_MSG = '%s!!!'

  	def say (message)
      puts message.downcase
    end

    def shout(message)
      puts "#{SHOUT_MSG % message.upcase}"
    end
  end
end