# class Table

# #need something to maintain state. global, class variables, or database
#   attr_accessor :cards

#   def initialize
#     copper = Card.find_by(name: "copper")
#     silver = Card.find_by(name: "silver")
#     gold = Card.find_by(name: "gold")
#     estate = Card.find_by(name: "estate")
#     duchy = Card.find_by(name: "duchy")
#     provence = Card.find_by(name: "provence")
#     curse = Card.find_by(name: "curse")
#     @cards = {}
#     [copper, silver, gold, estate, duchy, provence, curse].each {|card| @cards[card] = card.stock}
#   end


#   def self.choose_cards
#     Card.randomize.each {|card| cards[card] = card.stock}
#     #take optional blockof prefrences
#     #include the following logic here: bane, black market, ruins, colonys
#     #include number of players
#   end

#   def self.decrement(card)
#     @cards[card] -=1
#   end

#   def self.piles?
#     done = 0
#     cards.each {|card, stock| done +=1 if stock <= 0}
#     done>=3 ? true : false
#   end

# end