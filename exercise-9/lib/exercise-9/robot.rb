require './lib/exercise-9/module/speech'
require './lib/exercise-9/module/moveable'

module Exercise9
  class Robot
    include Speech, Moveable

    GREETING_MSG = "%s, the time is %s"
    FIRE_LASER_MSG = 'firing laser'

    def initialize(name)
      @name = name
    end

    def tell_me_the_time
      say GREETING_MSG % [greeting, Time.now]
    end

    def fire_laser
      shout FIRE_LASER_MSG
    end
  end
end