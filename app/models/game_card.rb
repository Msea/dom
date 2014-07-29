class GameCard < ActiveRecord::Base
  belongs_to :game
  belongs_to :card

  def decrement
    self.stock -=1
    update_attribute(:depleted?, true) if stock <=0
    save
  end

 end