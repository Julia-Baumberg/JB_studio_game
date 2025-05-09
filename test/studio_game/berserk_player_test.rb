require "minitest/autorun"

require_relative "../../lib/studio_game/berserk_player"

module StudioGame
  class BerserkPlayerTest < Minitest::Test
    def setup
      $stdout = StringIO.new
    end

    def test_does_not_go_berserk_when_boosted_up_to_5_times
      player = BerserkPlayer.new("berserker", 50)

      1.upto(5) { player.boost }

      refute player.berserk?
    end

    def test_goes_berserk_when_boosted_more_than_5_times
      player = BerserkPlayer.new("berserker", 50)

      1.upto(6) { player.boost }

      assert player.berserk?
    end

    def test_gets_boosted_instead_of_drained_when_it_has_gone_berserk
      player = BerserkPlayer.new("berserker", 50)

      1.upto(6) { player.boost }
      1.upto(2) { player.drain }

      assert_equal 50 + (8 * 15), player.health
    end
  end
end
