class Player
# Classe player

  attr_accessor :name, :life_points

  def initialize(name)
    # Initialisation de la classe Player
    @name = name
    @life_points = 10
  end

  def show_state()
    # Affiche un état des lieux de la santé des joueurs
    puts  "INFO : #{@name} a #{@life_points} points de vie" 
  end

  def gets_damage(damage_points)
    # Applique les dommages causés
    @life_points -= damage_points
    if @life_points <= 0 then
      @life_points =0
      puts "RIP : le joueur #{@name} a été tué !"
      puts
    end
  end

  def attacks(player)
    # Calcules les dommages 
    puts "ATTAQUE : #{@name} attaque #{player.name}"
    damage_points = compute_damage()
    puts "ATTAQUE : il lui inflige #{damage_points} points de dommages"
    player.gets_damage(damage_points)
  end

  def compute_damage()
    # Tirage de dé aléatoire
    return rand(1..6)
  end

end

class HumanPlayer < Player
# Classe spécifique aux joueurs humains 

  attr_accessor :weapon_level

  def initialize(name)
    # Initialisation de la classe
    @life_points = 100      # j'ai rajouté cette ligne
    @weapon_level = 1       # Initialisation Niveau armes
    @name = name            # super(name) #fait appel au initialize de la classe Player
  end

  def show_state()
    # Affiche un état des lieu du joueur humain 
    puts  "INFO : #{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}" 
  end

  def compute_damage()
    # Affiche un état des lieux de la santé des joueurs humains
    rand(1..6) * @weapon_level
  end

  def search_weapon()
    # Trouve une nouvelle arme
    dice = rand(1..6)
    puts "ARME : Tu as trouvé une arme de niveau #{dice}"
    if dice > @weapon_level then
      puts "ARME : Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
      puts
      @weapon_level = dice
    else
      puts "ARME : M@*#$... elle n'est pas mieux que ton arme actuelle..."
      puts
    end
  
  end

  def search_health_pack()
    # Cherche un pack santé
    dice = rand(1..6)     # Lancé de dé 
    case dice             # Analyse du lancé
    when 1
       puts  "SANTE : Tu n'as rien trouvé... "
    when 2,3,3,5
      puts "SANTE : Bravo, tu as trouvé un pack de +50 points de vie !"
      @life_points += 50
      (@life_points > 100)? @life_points = 100 : ""
    when 6
      puts "SANTE : Waow, tu as trouvé un pack de +80 points de vie !"
      @life_points += 80
      (@life_points > 100)? @life_points = 100 : ""
    end
  end


end