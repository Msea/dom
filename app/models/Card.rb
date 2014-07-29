class Card < ActiveRecord::Base
  has_many :deckcards

  def self.randomize
    cards = where(in_randomizer?: true)
    cards.shuffle[0...10]
  end

  def play
  end

end