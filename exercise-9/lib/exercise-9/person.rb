require './lib/exercise-9/module/speech'
require './lib/exercise-9/module/moveable'

module Exercise9
  class Person
    include Speech, Moveable

    GREETING_MSG = "%s, sorry I'm not a Robot and I don't have a watch"

    def initialize(name)
      @name = name
    end

    def tell_me_the_time 
      say GREETING_MSG % greeting
    end
  end
end
