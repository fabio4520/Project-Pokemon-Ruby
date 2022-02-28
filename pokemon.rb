require_relative "pokedex/pokemons"
require_relative "player"

class Pokemon
  # include neccesary modules
  attr_reader :species, :name, :experience_points, :level, :type, :moves, :effort_points
  attr_accessor :current_move, :stats, :current_hp

  def stats_calculation(base_stats, individual_stats, effort_values, level)
    stats = {}
    base_stats.each_key do |key|
      stat_effort = (effort_values[key] / 4.0).floor
      stat = if key == :hp
               ((((2 * base_stats[key]) + individual_stats[key] + stat_effort) * level / 100) + level + 10).floor
             else
               ((((2 * base_stats[key]) + individual_stats[key] + stat_effort) * level / 100) + 5).floor
             end
      stats[key] = stat
    end
    stats
  end

  def initialize(species, name = "", level = 1)
    # TODO: VIENE DEL HASH POKEMONS
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
    @individual_stats = { hp: rand(0..31), attack: rand(0..31), defense: rand(0..31), special_attack: rand(0..31),
                          special_defense: rand(0..31), speed: rand(0..31) }
    @effort_values = { hp: 0, attack: 0, defense: 0, special_attack: 0, special_defense: 0, speed: 0 }
    @stats = stats_calculation(@base_stats, @individual_stats, @effort_values, @level)
    @current_move = nil
    @current_hp = nil
  end

  def prepare_for_battle
    # Complete this
    @current_hp = @stats[:hp]
    @current_move = nil
  end

  def receive_damage(damage, _target)
    @current_hp -= damage
  end

  def fainted?
    !@current_hp.positive?
  end

  def calculate_damage(level, current_move, target)
    if Pokedex::SPECIAL_MOVE_TYPE.include?(current_move[:type])
      offensive_stat = @stats[:special_attack]
      target_defensive_stat = target.pokemon.stats[:special_defense]
    else
      offensive_stat = @stats[:attack]
      target_defensive_stat = target.pokemon.stats[:defense]
    end
    move_power = current_move[:power]
    ((((2 * level / 5.0) + 2).floor * offensive_stat * move_power / target_defensive_stat).floor / 50.0).floor + 2
  end

  def critical(_base_damage)
    rand(1..16) >= 16 # true or false
  end

  def type_effectiveness(_base_damage, target)
    #### TYPE MULIPLIER
    # multiplier: array para almacenar los valores de multiplier, vamos a forzar a que tengan dos elementos
    # Se fuerza porque no todos los MOVES types tienen un valor para cada tipo de pokemon. Ej. fire vs Normal
    # En ese caso el multiplicador == 1 para no afectar el calculate_damage
    multiplier = []
    # para iterar cada hash del TYPE_MULTIPLIER --> Ej. { user: :normal, target: :rock, multiplier: 0.5 }
    Pokedex::TYPE_MULTIPLIER.each do |hash|
      # @current_move[:type] --> es el hash que contiene el movimiento de nuestro pokemon.
      # target.pokemon.type --> array de symbols que contiene los tipos de pokemon.
      # hash[:target] --> symbol del hash que estamos iterando para target
      if hash[:user] == @current_move[:type] && target.pokemon.type.include?(hash[:target])
        multiplier.append(hash[:multiplier])
      end
    end
    multiplier.append(1) until multiplier.length == 2
    multiplier.inject(:*) # multiplico los elementos del array
  end

  def attack(player, target)
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
      if multiplier <= 0.5 then puts "It's not very effective..."
      elsif multiplier >= 1.5 then puts "It's super effective!"
      elsif multiplier.zero? then puts "It doesn't affect #{target.name}!"
      end
      puts "And it hit #{target.pokemon.name} with #{damage} damage"
      receive_damage(damage, target)

    else
      puts "But it MISSED!"
    end
  end

  def increase_stats(target)
    # target = Object type pokemon
    @experience_points += (@base_exp * target.level / 7.0).floor
    puts "#{@name} gained #{@experience_points} experience points"
    index_plus_one = # devuelve el index inmediato mayor
      Pokedex::LEVEL_TABLES[@growth_rate].bsearch_index do |element|
        element > @experience_points
      end
    new_level = index_plus_one # index actualizado
    if new_level > @level
      @level = new_level
      puts "#{@name} reached level #{@level}!"
    end
    type_target = target.effort_points[:type]
    amount_target = target.effort_points[:amount]
    @effort_values[type_target] += amount_target
    @stats = stats_calculation(@base_stats, @individual_stats, @effort_values, @level)
  end

  # private methods:
  # Create here auxiliary methods
end
