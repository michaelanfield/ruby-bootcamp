require './lib/exercise-9/module/speech'
require './lib/exercise-9/module/moveable'

module Exercise9
  class Robot
    include Speech, Moveable

    attr_reader :position

    def initialize(name)
      @name = name

      @greetings = ['hello', 'good day', "what's up", 'yo', 'hi', 'sup', 'hey']
      @goodbyes = ['goodbye', 'see you later', 'in a while crocodile', 'l8rs', 'bye for now']
      @position  = {logitude: 0, lattitude: 0 }
    end

    def greeting
      @greetings.sample
    end

    def farewell
      @goodbyes.sample
    end

    def tell_me_the_time
      say "#{greeting}, the time is #{Time.now}"
    end

    def fire_laser
      shout 'firing laser'
    end
  end
end