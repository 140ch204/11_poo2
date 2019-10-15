require 'pry'   
require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

def perform()
  # Lance le jeu 
  acceuil()                                   # Bannière d'arrivée
  
  puts "Bienvenu humain, quel est ton prénom ?"
  print "Mon prénom > "
  human_player_name = gets.chomp              # Demande au prénom au Joueur
  my_game = Game.new(human_player_name)       # Lancement du Jeu

  # Début du Jeu 
  while my_game.is_still_ongoing?             # Boucle du Jeu
    
    my_game.show_players()                    # Affiche l'état de santé des participants
    my_game.new_players_in_sight()            # Arrivée de nouveaux joueurs ?
    my_game.display()                         # Restitution graphique du jeu
    my_game.menu()                            # Affiche le menu
    my_game.menu_choice()                     # Analyse de l'action du Joueur : 
    my_game.enemies_attack()                  # Au tour des joueurs d'attaquer

  end 
  
  my_game.the_end()                           # Message de fin 
  my_game.display_end()                       # Affichage graphique de fin de partie

end

def acceuil()
  # Affichage graphique de début de partie
  puts
  puts "       ____   ____ _______ ______   __  "
  puts "      |  _ \\ / __ \\__   __/ __ \\ \\ / /  "
  puts "      | |_) | |  | | | | | |  | \\ V /   "
  puts "      |  _ <| |  | | | | | |  | |> <    "
  puts "      | |_) | |__| | | | | |__| / . \\   "
  puts "      |____/ \\____/  |_|  \\____/_/ \\_\\  "
  puts
  puts "-------------------------------------------------"
  puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO V3      |"
  puts "|Le but du jeu est d'être le dernier survivant !|"
  puts "|Codé avec <3 par Julien Besombes le 15/10/2019 |"
  puts "-------------------------------------------------"

end

perform()