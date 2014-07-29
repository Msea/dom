class GamePlayer < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  has_many :deckcards
  has_many :cards, through: :deckcards
  has_many :turns
   #lib, hand, discard, play, duration, inplay

  def draw_card
    #if no top card, then shuffle
    top_card = deckcards.find_by(library_position: 1)
    top_card.status = "hand"
    top_card.library_position = nil
    top_card.save
    library.each do |library_member|
      library_member.library_position -=1
      library_member.save
    end
    top_card
  end

  def draw_5
    5.times {draw_card}
  end

  def shuffle
    library.last ? (starting_from = library.last.library_position+1) : (starting_from = 1)
    ending_at = (discards.length)+starting_from
    order = ((starting_from...ending_at).to_a).shuffle 
    discards.each_with_index do |discarded_card, i|
      discarded_card.status = "library"
      discarded_card.library_position = order[i]
      discarded_card.save
    end
  end

  def be_dealt
    copper_id = Card.find_by(name: "copper").id
    estate_id = Card.find_by(name: "estate").id
    7.times {Deckcard.create({game_player_id: id, card_id: copper_id, status: "discard"})}
    3.times {Deckcard.create({game_player_id: id, card_id: estate_id, status: "discard"})}
    shuffle
  end

  def library_cards
    Card.joins(:deckcards).where(:"deckcards.status" => "library").where(:"deckcards.player_id" => id)
  end

  def library
    deckcards.where(status: "library")
  end

  def orderd_library
    Card.joins(:deckcards).where(:"deckcards.status" => "library").where(:"deckcards.player_id" => id).order("deckcards.library_position")
  end

  def discards
    deckcards.where(status: "discard")
  end

  def discard_cards
    Card.joins(:deckcards).where(:"deckcards.status" => "discard").where(:"deckcards.player_id" => id)
  end

  def hand
    Card.joins(:deckcards).where(:"deckcards.status" => "hand").where(:"deckcards.player_id" => id)
  end

  # def self.deal
  #   #Player.where("id>2").each {|player| player.be_dealt}
  #   each {|player| player.be_dealt}
  # end

end