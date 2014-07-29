class Turn < ActiveRecord::Base
  belongs_to :game_player

  def play
  #a gameplayer can play an action, reaction, or treasure card
      #gameplayer can continue to play until he runs out of playable cards or enters buy phase
      #gameplayer can buy until he runs out of buys or finishes buy phase
      #cards "in play" or unplayed get discarded
      #gameplayer draws 5 cards (shuffleing if needed)
  end

end