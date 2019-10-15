require 'pry'   
require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

def perform 
  puts "-------------------------------------------------"
  puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
  puts "|Le but du jeu est d'être le dernier survivant !|"
  puts "-------------------------------------------------"

  # Init du joueur humain 
  puts "Bienvenu humain, quel est ton prénom ?"
  human_player_name = gets.chomp
  user = HumanPlayer.new(human_player_name)

  # Init des bots 
  ennemies = []
  player1 = Player.new("Josiane")
  ennemies += [player1]
  player2 = Player.new("José")
  ennemies += [player2]

  # Début du Jeu 
  while (user.life_points > 0) && (player1.life_points >0 || player2.life_points >0)
    user.show_state

    # Menu :
    puts("Quelle action veux-tu effectuer ?")
    puts("  Se déplacer")
    puts("    a - chercher une meilleure arme")
    puts("    s - chercher à se soigner ")
    puts("  Attaquer un joueur en vue :")
    puts("    0 - #{player1.name} a #{player1.life_points} points de vie")
    puts("    1 - #{player2.name} a #{player2.life_points} points de vie")

    # Demande d'action du Joueur
    action = gets.chomp
    puts

    # Analyse de l'action du Joueur : 
    case action
    when "a"
      user.search_weapon
    when "s"
      user.search_health_pack
    when "0"
      user.attacks(player1)
    when "1"
      user.attacks(player2)
    end

    # Au tour des joueurs 
    puts "Les autres joueurs t'attaquent !"
    puts

    # Vérification du niveau de vie des ennemies
    ennemies.each do |ennemy|
      ennemy.life_points>0? ennemy.attacks(user) :""
    end

    # pause
    gets
    
  end 

  the_end(user.life_points)

end

def the_end(user_life_points)
  # Renvoie le message de fin de parti
  if user_life_points > 0 then 
    puts "Bravo tu as gagné !"
    puts "Fin de la partie"
    puts
  else
    puts "Oh noooo tu as perdu !"
    puts "Fin de la partie "
    puts
  end
end

perform
  