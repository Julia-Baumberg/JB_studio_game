require_relative "auditable"
require_relative "treasure_trove"

module StudioGame
  class Game
    include Auditable

    attr_reader :title, :players

    
    def initialize(title = "Winner Winner Chicken Dinner!")
      @title = title
      @players = []
    end
    
    def add_player(player)
      @players << player
    end
    
    def roll_dice
      roll = rand(1..6)
      audit(roll)
      roll
    end
    
    def print_stats
      puts "\n Game Stats:"
      puts "-" * 30
      puts sorted_players_by_score
      sorted_players_by_treasure_points.each do |player|
        puts "\n#{player.name}'s treasure point totals:"
        player.found_treasures.each do |name, points|
          puts "#{name}: #{points}"
        end
        puts "total: #{player.points}"
      end
      puts "\nHigh Scores:"
      sorted_players_by_score.each do |player|
        puts high_score_entry(player)
      end
    end
    
    def sorted_players_by_score
      @players.sort_by {|p| p.score}.reverse
    end
    
    def sorted_players_by_treasure_points
      @players.sort_by {|p| p.points}.reverse
    end
    
    def play(rounds = 1)
      puts "\nLet's play #{@title}!"
      
      puts "\nThe following treasures can be found:"
      puts TreasureTrove.treasure_items
      
      puts "\nBefore playing:"
      puts @players
      
      1.upto(rounds) do |round|
        puts "\nRound #{round}:"

        @players.each do |player| 
          
          number_rolled = roll_dice
          case number_rolled
          when 1..3
            player.drain
            puts "#{player.name} got drained 😩"
          when 4..5
            puts "#{player.name} got skipped 🤡"
          else
            player.boost
            puts "#{player.name} got boosted 😁"
          end
          treasure = TreasureTrove.random_treasure
          
          player.found_treasure(treasure.name, treasure.points)
          
          puts "#{player.name} found a #{treasure.name} worth #{treasure.points} points"
        end
        
        puts "\nAfter playing:"
        puts @players
      end
    end
    
    def load_players(filename)
      File.readlines(filename, chomp: true).each do |line|
        player = Player.from_csv(line)
        add_player(player)
      end
    rescue Errno::ENOENT
      puts "Whoops, #{filename} not found!"
      exit 1
    end

    def save_high_scores(to_file = "high_scores.txt")
      File.open(to_file, "w") do |file|
        file.puts "#{@title} High Scores:"
        sorted_players_by_treasure_points.each do |player|
          file.puts high_score_entry(player)
        end
      end
    end

    def high_score_entry(player)
      name = player.name.ljust(20, ".")
      score = player.score.round.to_s.rjust(5)
      "#{name}#{score}"
    end
  end
end