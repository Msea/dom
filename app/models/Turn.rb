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
    while phase == "buy"
      play_buy_phase
    end
    cleanup
  end

  def cleanup
    game_player.deck_cards_for_discard.each {|deck_card|deck_card.discard}
    game_player.draw_5 #or however many if tactiton
  end

  #user input must be isolated for web
  def play_action_phase
    #don't assume any
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
    puts "type end to end"
      answer = gets.chomp
      phase_not_over = false if answer == "end"
    while (game_player.playable_treasures.length >0 && phase_not_over)
      st =""
      game_player.playable_treasures.each {|pt|st+="#{pt.id}, "}
      puts "choose id of card to play from #{st}"
      id_of_deck_card = gets.chomp.to_i
      treasure_card = game_player.playable_treasures.find(id_of_deck_card)
      play_treasure_card(treasure_card)
      puts "type end to end"
      answer = gets.chomp
      phase_not_over = false if answer == "end"
    end
    self.phase = "buy"
  end

  def play_buy_phase
    phase_not_over = true
    puts "type end to end"
      answer = gets.chomp
      phase_not_over = false if answer == "end"#check before and after
    while (buys_left>0 && phase_not_over)
      st =""
      game_player.game.game_cards.each do|pt|
        if pt.card.cost <=buying_power
          st+="#{pt.id} = #{pt.card.name}, "
        end
      end
      puts "choose id of card to buy from #{st}"
      id_of_game_card = gets.chomp.to_i
      game_card = game_player.game.game_cards.find(id_of_game_card)
      buy_game_card(game_card)
      puts "type end to end"
      answer = gets.chomp
      phase_not_over = false if answer == "end"#check before and after
    end
    self.phase = "ended"
  end
     
  def play_treasure_card(dc)
    dc.status = "inplay"
    dc.save
    name = dc.card.name
    self.send("play_#{name}")
  end

  def buy_game_card(gc)
    #specilaized logic (ex mint, grandmarket) may be here or seperated
    if ((! gc.depleted?) && (gc.card.cost<=self.buying_power))#put this in prev method?
      gc.decrement
      self.buys_left -= 1
      self.buying_power -= gc.card.cost
      self.save
      dc = Deckcard.create(game_player_id: game_player_id, card_id: gc.card_id, status: "gaining")
      dc.gain
    end
  end

end