class Player < ActiveRecord::Base
  has_many :deckcards
  has_many :cards, through: :deckcards
   #lib, hand, discard, play, duration, inplay

  def shuffle
  end

  def be_dealt
    7.times {cards<<Card.find_by(name: "copper")}
    3.times {cards<<Card.find_by(name: "estate")}
  end

  def library
    Card.joins(:deckcards).where(:"deckcards.status" => "library").where(:"deckcards.player_id" => id)
  end

  def discard
    Card.joins(:deckcards).where(:"deckcards.status" => "discard").where(:"deckcards.player_id" => id)
  end

  def hand
    Card.joins(:deckcards).where(:"deckcards.status" => "hand").where(:"deckcards.player_id" => id)
  end

end