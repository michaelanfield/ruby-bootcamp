require './lib/exercise-9/module/speech'
require './lib/exercise-9/module/moveable'

module Exercise9
  class Person
    include Speech, Moveable

    GREETINGS = ['hello', 'good day', "what's up", 'yo', 'hi', 'sup', 'hey']
    GOODBYES = ['goodbye', 'see you later', 'in a while crocodile', 'l8rs', 'bye for now']
    GREETING_MSG = "%s, sorry I'm not a Robot and I don't have a watch"

    attr_reader :position

    def initialize(name)
      @name = name

      @greetings = GREETINGS
      @goodbyes = GOODBYES
      @position  = {logitude: 0, lattitude: 0 }
    end

    def greeting
      @greetings.sample
    end

    def farewell
      @goodbyes.sample
    end

    def tell_me_the_time 
      say "#{greeting}, sorry I'm not a Robot and I don't have a watch"
    end
  end
end
