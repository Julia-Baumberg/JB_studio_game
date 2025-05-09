require_relative "player"

module StudioGame
  class ClumsyPlayer < Player
    def found_treasure(name, points)
      points = points / 2.0
      super(name, points.to_i)
    end
  end
end