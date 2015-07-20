module Exercise9
  module Moveable

    def position
      @position ||= {longitude: 0, lattitude: 0}
    end

    def move_left
      move :left
    end

    def move_right
      move :right
    end

    def move_forwards
      move :forwards
    end

    def move_backwards
      move :backwards
    end

    private    
    def move(direction) 
      plane, amount = nil, nil

      if  %i{left right}.include?(direction)
        plane, amount = :lattitude, (direction == :left ? 1 : -1)
      elsif %i{forwards backwards}.include?(direction)
        plane, amount = :longitude, (direction == :forwards ? 1 : -1)
      else
        raise InvalidDirectionException, "I just don't move like that"
      end

      position[plane]+= amount
      self
    end

    class InvalidDirectionException < StandardError; end
  end
end