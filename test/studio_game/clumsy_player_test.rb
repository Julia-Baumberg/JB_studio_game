require "minitest/autorun"

require_relative "../../lib/studio_game/clumsy_player"

module StudioGame
  class ClumsyPlayerTest < Minitest::Test
    def test_only_gets_half_the_point_value_for_each_treasure
      player = ClumsyPlayer.new("klutz")

      assert_equal 0, player.points

      player.found_treasure("flute", 50)
      player.found_treasure("flute", 50)
      player.found_treasure("flute", 50)

      assert_equal 75, player.points

      player.found_treasure("star", 100)

      assert_equal 125, player.points

      expected = {
        "flute" => 75,
        "star" => 50
      }

      assert_equal expected, player.found_treasures
    end
  end
end
