module Playcards
# extend ActiveSupport::Concern

  def play_copper
    self.buying_power +=1
  end

  def play_silver
    self.buying_power +=2
  end

  def play_gold
    self.buying_power +=3
  end

end