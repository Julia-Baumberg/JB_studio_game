require_relative "playable"

module StudioGame
  class Player
    include Playable
    
    attr_accessor :name, :health
    attr_reader :found_treasures

    def initialize(name, health = 100)
      @name = name.capitalize
      @health = health
      @found_treasures = Hash.new(0)
    end

    def to_s
      "My name is #{name} and my health is #{health} with a score of #{score} and I have #{points} points!"
    end

    def score
      @health + @name.length + points
    end

    def found_treasure (name, points)
      @found_treasures[name] += points
    end

    def points
      @found_treasures.values.sum
    end

    class << self
      def from_csv(line)
        name, health = line.split(',')
        Player.new(name, Integer(health))
      rescue ArgumentError
        puts "Ignored invalid health: #{health}"
        Player.new(name)
      end
    end
  end
end
