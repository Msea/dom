class Game < ActiveRecord::Base
  has_many :game_players
  has_many :players, through: :game_players
  has_many :turns, through: :game_players
  has_many :game_cards
  has_many :cards, through: :game_cards

  def choose_cards
    copper = Card.find_by(name: "copper")
    silver = Card.find_by(name: "silver")
    gold = Card.find_by(name: "gold")
    estate = Card.find_by(name: "estate")
    duchy = Card.find_by(name: "duchy")
    provence = Card.find_by(name: "provence")
    curse = Card.find_by(name: "curse")
    [copper, silver, gold, estate, duchy, provence, curse].each { |card| GameCard.create(game_id: id, card_id: card.id, stock: card.stock)}
    Card.randomize.each {|card| GameCard.create(game_id: id, card_id: card.id, stock: card.stock)}
    #further dev:
    #take optional blockof prefrences
    #include the following logic here: bane, black market, ruins, colonys
    #include number of players
  end

  def decrement(card)
    GameCard.where(game_id: id, card_id: card.id).first.decrement
  end

  def piles?
    game_cards.where(depleted?: true).length >=3 ? true : false
  end

  def provences?
    #if colonies put in here too
    provence_id = Card.find_by(name: "provence").id
    GameCard.find_by(game_id: id, card_id: provence_id).depleted?
  end

  def game_over?
    piles? || provences?
  end

  def determine_play_order
    ordered_players = game_players.shuffle
    game_players.each {|gp|gp.turn_order = ordered_players.index(gp); gp.save}
  end

  def next_player(gp=nil)
    if gp
      if gp.turn_order == game_players.length-1
        next_order = 0
      else
        next_order = gp.turn_order+1
      end
      game_players.find_by(turn_order: next_order)
    else
      if turns.last
        next_player(turns.last.game_player) # make sure returns last turn at all and not last turn of last plaer
      else
        game_players.find_by(turn_order: 0)
      end
    end
  end

  def deal
    game_players.each {|player| player.be_dealt}
  end

  def setup
    choose_cards
    deal
    determine_play_order
    game_players.each{|gp|gp.draw_5}
  end

  def play
    #eventually this can't all be in one method to maintain state
    setup
    while (! game_over?)
      turn = Turn.create(game_player_id: next_player.id)
      turn.play
    end
  end

end