require "minitest/autorun"

require_relative "../../lib/studio_game/player"

module StudioGame
  class PlayerTest < Minitest::Test

    def test_has_a_capitalized_name
      player = Player.new("finn", 60)

      assert_equal "Finn", player.name
    end

    def test_has_an_initial_health
      player = Player.new("finn", 60)

      assert_equal 60, player.health
    end

    def test_has_a_string_representation
      player = Player.new("finn", 60)

      expected = "My name is Finn and my health is 60 with a score of 64 and I have 0 points!"
      assert_equal expected, player.to_s
    end

    def test_boost_increases_health_by_15
      player = Player.new("finn", 60)

      player.boost

      assert_equal 75, player.health
    end

    def test_drain_decreases_health_by_10
      player = Player.new("finn", 60)

      player.drain

      assert_equal 50, player.health
    end

    def test_found_treasure
      player = Player.new("finn", 60)

      assert_empty player.found_treasures

      player.found_treasure("pie", 10)

      expected = {"pie" => 10}
      assert_equal expected, player.found_treasures

      player.found_treasure("crown", 90)

      expected = {"pie" => 10, "crown" => 90}
      assert_equal expected, player.found_treasures

      player.found_treasure("crown", 90)

      expected = {"pie" => 10, "crown" => 180}
      assert_equal expected, player.found_treasures
    end

    def test_has_points_as_the_sum_of_all_treasure_points
      player = Player.new("finn", 60)

      player.found_treasure("compass", 65)

      assert_equal 65, player.points
    end

    def test_computes_score_as_sum_of_health_and_points
      player = Player.new("finn", 60)

        player.found_treasure("compass", 65)

        assert_equal 129, player.score
    end

    def test_from_csv
      player = Player.from_csv("finn,60")

      assert_equal "Finn", player.name
      assert_equal 60, player.health
    end
  end
end
