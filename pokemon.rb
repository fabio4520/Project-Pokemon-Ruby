require_relative "pokedex/pokemons.rb"
require_relative "player"

class Pokemon
  # include neccesary modules
  attr_reader :species, :name, :experience_points, :level, :type, :moves
  attr_accessor :current_move, :stats

  # (complete parameters)

  def stats_calculation(base_stats, individual_stats, effort_values, level)
    stats = {}
    base_stats.each_key do |key|
      stat_effort = (effort_values[key] / 4.0).floor
      if key == :hp
        stat = ((2 * base_stats[key] + individual_stats[key] + stat_effort) * level / 100 + level + 10).floor 
      else
        stat = ((2 * base_stats[key] + individual_stats[key] + stat_effort) * level / 100 + 5).floor
      end
      stats[key] = stat
    end
    stats
  end

  def initialize(species, name = "", level = 1)
    # TODO VIENE DEL HASH POKEMONS
    @species = species
    @type = Pokedex::POKEMONS[species][:type]
    @base_exp = Pokedex::POKEMONS[species][:base_exp]
    @growth_rate = Pokedex::POKEMONS[species][:growth_rate]
    @base_stats = Pokedex::POKEMONS[species][:base_stats]
    @effort_points = Pokedex::POKEMONS[species][:effort_points]
    @moves = Pokedex::POKEMONS[species][:moves]

    #################################
    # LO QUE ESTAMOS DEFINIENDO
    @name = name
    @level = level
    @experience_points = 0
    @individual_stats = { hp: rand(0..31), attack: rand(0..31), defense: rand(0..31), special_attack: rand(0..31), special_defense: rand(0..31), speed: rand(0..31) }
    @effort_values = { hp: 0, attack: 0, defense: 0, special_attack: 0, special_defense: 0, speed: 0 }
    @experience_points = 0
    @stats = stats_calculation(@base_stats, @individual_stats, @effort_values, @level)
    @current_move = nil
    # Retrieve pokemon info from Pokedex and set instance variables
    # Calculate Individual Values and store them in instance variable
    # Create instance variable with effort values. All set to 0
    # Store the level in instance variable
    # If level is 1, set experience points to 0 in instance variable.
    # If level is not 1, calculate the minimum experience point for that level and store it in instance variable.
    # Calculate pokemon stats and store them in instance variable
  end

  def prepare_for_battle(bot, player)
    # Complete this
    puts ""
    puts "#{bot.name} sent out #{bot.pokemon_specie.upcase}!"
    puts "#{player.name} sent out #{player.pokemon.name.upcase}!"
    puts "-------------------Battle Start!-------------------\n\n"

    puts "#{player.name}'s #{player.pokemon.name} - Level #{player.pokemon.level}"
    puts "HP: #{player.pokemon.stats[:hp]}"
    puts "#{bot.name}'s #{bot.pokemon_specie} - Level #{bot.pokemon.level}"
    puts "HP: #{bot.pokemon.stats[:hp]}"

    player.select_move
    puts "-" * 50
    attack(player, bot)

  end

  def receive_damage(damage, target)
    # Complete this
    target.pokemon.stats[:hp] -= damage
  end

  # def set_current_move
  #   @current_move
  # end

  def fainted?
    # Complete this
    !@stats[:hp].positive?
  end

  def calculate_damage(level, current_move, target)
    # puts "level: #{level}"
    # puts "current_move: #{current_move}"
    # puts "target: #{target}"
    if Pokedex::SPECIAL_MOVE_TYPE.include?(current_move[:type]) 
      offensive_stat = @stats[:special_attack]
      target_defensive_stat = target.pokemon.stats[:special_defense]
    else
      offensive_stat = @stats[:attack]
      target_defensive_stat = target.pokemon.stats[:defense]
    end
    move_power = current_move [:power]
    # puts ""
    # p "offensive_stat: #{offensive_stat}"
    # p "level: #{level}"
    # p "move_power: #{move_power}"
    # p "target_defensive_stat: #{target_defensive_stat}"
    base_damage = (((2 * level / 5.0 + 2).floor * offensive_stat * move_power / target_defensive_stat).floor / 50.0).floor + 2
    base_damage
  end

  def critical(base_damage)
    ##### CRITICAL
    critical_hit = 16 <= rand(1..16) # true or false    
  end

  def type_effectiveness(base_damage)
    #### TYPE MULIPLIER
    multiplier = 0
    Pokedex::TYPE_MULTIPLIER.each do |hash|
      multiplier = hash[:multiplier] if hash[:user] == :fire && hash[:target] == :steel
    end
    multiplier
  end

  def attack(player,target)
    puts "#{player.pokemon.name} used #{player.pokemon.current_move[:name].upcase}!"
    hit = @current_move[:accuracy] > rand(1..100)
    if hit
      base_damage = calculate_damage(@level, @current_move, target)
      if critical(base_damage)
        base_damage *= 1.5
        puts "It was CRITICAL hit!"
      end
      multiplier = type_effectiveness(base_damage)
      damage = (base_damage *= multiplier).floor
      case
      when multiplier <= 0.5 then puts "It's not very effective..."
      when multiplier >= 1.5 then puts "It's super effective!"
      when multiplier == 0 then puts "It doesn't affect #{target.name}!"
      end
      puts "And it hit #{target.pokemon.name} with #{damage} damage"
      receive_damage(damage, target)

    else
      puts "But it MISSED!" 
    end

    # Print attack message 'Tortuguita used MOVE!'  CHECK
    # Accuracy check CHECK
    # If the movement is not missed
    # -- Calculate base damage  CHECK
    # -- Critical Hit check
    # -- If critical, multiply base damage and print message 'It was CRITICAL hit!' # CHECK
    # -- Effectiveness check # CHECK
    # -- Mutltiply damage by effectiveness multiplier and round down. Print message if neccesary
    # ---- "It's not very effective..." when effectivenes is less than or equal to 0.5
    # ---- "It's super effective!" when effectivenes is greater than or equal to 1.5
    # ---- "It doesn't affect [target name]!" when effectivenes is 0
    # -- Inflict damage to target and print message "And it hit [target name] with [damage] damage""
    # Else, print "But it MISSED!"  CHECK
  end

  def increase_stats(target)
    # Increase stats base on the defeated pokemon and print message "#[pokemon name] gained [amount] experience points"

    # If the new experience point are enough to level up, do it and print
    # message "#[pokemon name] reached level [level]!" # -- Re-calculate the stat
  end

  # private methods:
  # Create here auxiliary methods
end

# player = Player.new("Fabio","Charmander", "Char")
# bot = Bot.new(1 + rand(1..2))
# pok = Pokemon.new("Charmander")
# pok.prepare_for_battle(bot, player)
