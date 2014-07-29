class Game < ActiveRecord::Base
  has_many :game_players
  has_many :players, through: :game_players
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

  def play
    #eventually this can't all be in one method to maintain state

    #choose cards
    #gameplayers draw opening hands
    # a gameplayer goes first
    #gameplayers take turns
      #a gameplayer can play an action, reaction, or treasure card
      #gameplayer can continue to play until he runs out of playable cards or enters buy phase
      #gameplayer can buy until he runs out of buys or finishes buy phase
      #cards "in play" or unplayed get discarded
      #gameplayer draws 5 cards (shuffleing if needed)
      #end of turn
    #until someone wins
  end

end