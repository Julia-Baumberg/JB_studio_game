require "minitest/autorun"

require_relative "../../lib/studio_game/treasure_trove"

module StudioGame
  class TreasureTroveTest < Minitest::Test
    def test_treasure_has_a_name_and_points
      treasure = TreasureTrove::Treasure.new("pie", 10)

      assert_equal "pie", treasure.name
      assert_equal 10, treasure.points
    end

    def test_treasure_trove_has_treasures
      refute_empty TreasureTrove::TREASURES
      assert_equal 7, TreasureTrove::TREASURES.size
    end

    def test_treasure_trove_returns_a_random_treasure
      treasure = TreasureTrove.random_treasure

      assert_includes TreasureTrove::TREASURES, treasure
    end

    def test_treasure_trove_has_treasure_items
      items = TreasureTrove.treasure_items

      expected = [
        "A pie is worth 10 points",
        "A coin is worth 25 points",
        "A flute is worth 50 points",
        "A compass is worth 65 points",
        "A key is worth 80 points",
        "A crown is worth 90 points",
        "A star is worth 100 points"
      ]
      assert_equal expected, items
    end
  end
end
