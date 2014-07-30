class GamePlayer < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  has_many :deckcards
  has_many :cards, through: :deckcards
  has_many :turns
   #lib, hand, discard, play, duration, inplay

  def draw_card
    #change for chapel if no card to draw
    if ! (top_card = deckcards.find_by(library_position: 1))
      shuffle
      top_card = deckcards.find_by(library_position: 1)
    end
    top_card.status = "hand"
    top_card.library_position = nil
    top_card.save
    library.each do |library_member|
      library_member.library_position -=1
      library_member.save
    end
    top_card
  end

  def reveal_top_card
  end

  def draw_5
    5.times {draw_card}
  end

  def draw(n)
    n.times {draw_card}
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

  def discarded_cards
    Card.joins(:deckcards).where(:"deckcards.status" => "discard").where(:"deckcards.game_player_id" => id)
  end

  def hand
    deckcards.where(status: "hand")
  end

  def deck_cards_for_discard
    deckcards.where(status: ["hand", "inplay"])
  end

  def hand_cards
    Card.joins(:deckcards).where(:"deckcards.status" => "hand").where(:"deckcards.player_id" => id)
  end

  def playable_actions
    deckcards.joins(:card).where(:"cards.kind" => "action", :"deckcards.status" => "hand")
    #and whatever other logic prince
  end

  def playable_treasures
    deckcards.joins(:card).where(:"cards.kind" => "treasure", :"deckcards.status" => "hand")
  end

end