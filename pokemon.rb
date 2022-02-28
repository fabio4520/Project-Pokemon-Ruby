require_relative "pokedex/pokemons.rb"
require_relative "player"

class Pokemon
  # include neccesary modules
  attr_reader :species, :name, :experience_points, :level, :type, :moves
  attr_accessor :current_move, :stats

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
    # increase_stats(bot)

  end

  def receive_damage(damage, target)
    target.pokemon.stats[:hp] -= damage
  end

  def fainted?
    !@stats[:hp].positive?
  end

  def calculate_damage(level, current_move, target)
    if Pokedex::SPECIAL_MOVE_TYPE.include?(current_move[:type]) 
      offensive_stat = @stats[:special_attack]
      target_defensive_stat = target.pokemon.stats[:special_defense]
    else
      offensive_stat = @stats[:attack]
      target_defensive_stat = target.pokemon.stats[:defense]
    end
    move_power = current_move [:power]
    base_damage = (((2 * level / 5.0 + 2).floor * offensive_stat * move_power / target_defensive_stat).floor / 50.0).floor + 2
    base_damage
  end

  def critical(base_damage)
    critical_hit = 16 <= rand(1..16) # true or false    
  end

  def type_effectiveness(base_damage, target)
    #### TYPE MULIPLIER
    # multiplier: array para almacenar los valores de multiplier, vamos a forzar a que tengan dos elementos
    # Se fuerza porque no todos los MOVES types tienen un valor para cada tipo de pokemon. Ej. fire vs Normal
    # En ese caso el multiplicador == 1 para no afectar el calculate_damage
    multiplier = []
    # para iterar cada hash del TYPE_MULTIPLIER --> Ej. { user: :normal, target: :rock, multiplier: 0.5 }
    Pokedex::TYPE_MULTIPLIER.each do |hash|
      # @current_move[:type] --> es el hash que contiene el movimiento de nuestro pokemon. 
      # target.pokemon.type --> array de symbols que contiene los tipos de pokemon. Ej. para Bulbasaur --> type: %i[grass poison]
      # hash[:target] --> symbol del hash que estamos iterando para target
      if hash[:user] == @current_move[:type] && target.pokemon.type.include?(hash[:target])
        multiplier.append(hash[:multiplier])
      end
    end
    until multiplier.length == 2
      multiplier.append(1)
    end
    multiplier.inject(:*) # multiplico los elementos del array
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
      multiplier = type_effectiveness(base_damage, target)
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
  end

  def increase_stats(target)
    @experience_points += (@base_exp * target.pokemon.level / 7.0).floor
    puts "#{@name} gained #{@experience_points} experience points"
    index_plus_one = Pokedex::LEVEL_TABLES[@growth_rate].bsearch_index {|element| element > @experience_points} # devuelve el index inmediato mayor
    new_level = index_plus_one #index actualizado
    if new_level > @level
      @level = new_level 
      puts "#{@name} reached level #{@level}!"
    end
  end

  # private methods:
  # Create here auxiliary methods
end

