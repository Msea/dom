class Deckcard < ActiveRecord::Base
  belongs_to :game_player
  belongs_to :card

  def discard
    self.status = "discard"
    self.library_position = nil
    self.save
  end

end