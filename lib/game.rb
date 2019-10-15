class Game
# Classe Game 

  attr_accessor :human_player, :enemies, :players_left, :enemies_in_sight, :player_id

  def initialize(human_player_name)
    # Méthode d'initialisation de la classe Game
    
    # Init des bots
    @players_left = 10
    @enemies_in_sight = []
    @player_id = 0

    # Init du player humain
    @human_player =  HumanPlayer.new(human_player_name)

  end

  def kill_player(player)
    # Supprime un bot du array @enemies
    @enemies_in_sight.delete(player)
  end

  def is_still_ongoing?()
    # Renvoie True si la partie est en cours et False si elle est arrêtée
    ((@human_player.life_points >0) && (@players_left + @enemies_in_sight.length > 0))
  end

  def show_players()
    puts "INFO : #{@human_player.name} : #{@human_player.life_points} points restants"
    puts "INFO : il reste #{@enemies_in_sight.length} bots en vue"
  end

  def menu()
    # Affiche le menu du jeu
    puts
    puts("ACTION : Quelle action veux-tu effectuer ?")
    puts("  Se déplacer : ")
    puts("    a - chercher une meilleure arme")
    puts("    s - chercher à se soigner ")
    puts("  Attaquer un joueur en vue :")
    # Liste des ennemis à attaquer 
    for enemy_index in (0..(@enemies_in_sight.length-1))
      enemy = @enemies_in_sight[enemy_index]
      puts("    #{enemy_index} - #{enemy.name} a #{enemy.life_points} points de vie")
    end
    puts

  end

  def menu_choice()#choix)
    
    print("Mon choix > ")
    choix = ""
    choix = gets.chomp                       # Demande au joueur son choix
    puts
    # Méthode pour traiter le choix du menu
    choix = choix.to_s.downcase
    case choix
    when "a"                                                  # Chercher une nouvelle Arme
      @human_player.search_weapon
    when "s"                                                  # Chercher de quoi se Soigner
      @human_player.search_health_pack
    else                                                      # attaquer les bots
      if ((choix.to_i >=0) && (choix.to_i < @enemies_in_sight.length) ) == true  then
        player = @enemies_in_sight[choix.to_i]
        @human_player.attacks(player)                         # Attaque de l'humain sur le bot
        (player.life_points <= 0)? kill_player(player) : ""   # Elimination d'un bot tué
      else                                                    # Mauvaise selection
        puts "ATTAQUE : Vous avez raté les Bots !"
      end      
    end

  end

  def enemies_attack()
    # Au tour des bots d'attaquer
    (@enemies_in_sight.length.to_i !=0)? (puts "ATTAQUE : Les autres joueurs t'attaquent !") : ""
    puts

    # Vérification du niveau de vie des ennemies
    @enemies_in_sight.each do |enemy|
      enemy.life_points>0? enemy.attacks(@human_player) :""
    end

  end

  def the_end()
    # Renvoie le message de fin de partie
    if @human_player.life_points > 0 then 
      puts "Bravo tu as gagné !"
    else
      puts "Oh noooo tu as perdu !"
    end
    #puts "____ GAME OVER ____"
    #puts
  end

  def new_players_in_sight()
    # Tire le dés et ajoute les nouveaux joueurs
    dice = rand(1..6)
    case dice
    when 1
      puts "ENNEMI : pas de nouvel ennemi rajouté"
    when 2, 3, 4
      add_new_player_in_sight()
    when 5, 6
      add_new_player_in_sight()
      add_new_player_in_sight()
    end

  end

  def add_new_player_in_sight()
    # Créé un nouveau joueur
    if @players_left > 0 then 
      @enemies_in_sight += [Player.new("Bot#{@player_id}")]
      @players_left += -1
      @player_id+= 1
      puts "ENNEMI : Nouvel ennemi en vue : Bot#{@player_id} !"
    else
      puts "ENNEMI : Tous les joueurs sont déjà en vue"
    end

  end

  def display()
    # Affichage graphique du jeu en cours de partie
    puts
    nb = 0
    print "N°   :"
    @enemies_in_sight.each do |player|
      print "    #{nb} ".ljust(7)
      nb += 1
    end
    puts
    print "Life : "
    @enemies_in_sight.each do |player|
      print "   #{player.life_points} ".ljust(7)
    end
    puts
    puts
    print "Bots :  "
    puts ("  o_o  " * @enemies_in_sight.length)
    puts
    puts
    puts "          O  "
    puts "         /|\\ "
    puts "         / \\ "
    puts
    puts "     Name : #{@human_player.name}"
    puts "     Life : #{@human_player.life_points}"
    puts "Weapon L. : #{@human_player.weapon_level}"
    puts

  end

  def display_end()
    # Affichage graphique de fin de partie
    if @human_player.life_points > 0 then 
      puts
      puts "         \\O/  "
      puts "          |  "
      puts "         / \\ "
      puts
      puts "     Name : #{@human_player.name}"
      puts
    else 
      puts
      puts "          X  "
      puts "         /|\\ "
      puts "         / \\ "
      puts
      puts "     Name : #{@human_player.name}"
      puts 
    end
    puts "______ Game Over ______"
  end

end