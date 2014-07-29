module Playcards
# extend ActiveSupport::Concern

  def play_copper
    self.buying_power +=1
  end

end