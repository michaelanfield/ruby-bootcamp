module Exercise9
  module Speech
  	SHOUT_MSG = '%s!!!'

  	def say (message)
      puts message.downcase
    end

    def shout(message)
      puts "#{SHOUT_MSG % message}".upcase
    end

    def greeting
      greetings.sample
    end

    def farewell
      goodbyes.sample
    end

    private
    def greetings
    	@greetings ||= ['hello', 'good day', "what's up", 'yo', 'hi', 'sup', 'hey']
    end

    def goodbyes
    	@goodbyes ||= ['goodbye', 'see you later', 'in a while crocodile', 'l8rs', 'bye for now']
    end
  end
end