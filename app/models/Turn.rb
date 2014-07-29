class Turn < ActiveRecord::Base
  belongs_to :game_player
  #has one gameplayer has many deckcards through gameplayer ?

include Playcards

  def play
    # while phase == "action"
    #   play_action_phase
    # end
    if phase == "treasure" #by rules seems to not exist, however seems like should play treasures before buy because grandmarket
      play_treasure_phase
    end
    # while phase == "buy"
    #   play_buy_phase
    # end
    cleanup
  end

  def cleanup
    game_player.deck_cards_for_discard.each {|deck_card|deck_card.discard}
    game_player.draw_5 #or however many if tactiton
  end

  #user input must be isolated for web
  def play_action_phase
    phase_not_over = true
    while ((actions_left > 0 && playable_actions.length >0) && phase_not_over)
     id_of_deck_card = gets.chomp.to_i
     action_card = playable_actions.find(id_of_deck_card)
     actions_left -= 1
     action_card.play
     answer = gets.chomp
     phase_not_over = false if answer != "yes"
    end
  end

  def play_treasure_phase
    phase_not_over = true
    while (game_player.playable_treasures.length >0 && phase_not_over)
     id_of_deck_card = gets.chomp.to_i
     treasure_card = game_player.playable_treasures.find(id_of_deck_card)
     play_treasure_card(treasure_card)
     answer = gets.chomp
     phase_not_over = false if answer != "yes"
    end
    self.phase = "buy"
  end

  def play_buy_phase
  end
      #gameplayer can buy until he runs out of buys or finishes buy phase
   
  def play_treasure_card(dc)
    dc.status = "inplay"
    dc.save
    name = dc.card.name
    self.send("play_#{name}")
  end

end