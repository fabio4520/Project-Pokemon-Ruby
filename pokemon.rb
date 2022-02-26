require_relative "pokedex/pokemons.rb"

class Pokemon
  # include neccesary modules
  attr_reader :species, :name, :stats, :experience_points, :level, :type
  
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
    # @stats[experience_points] = experience_points
    # Retrieve pokemon info from Pokedex and set instance variables
    # Calculate Individual Values and store them in instance variable
    # Create instance variable with effort values. All set to 0
    # Store the level in instance variable
    # If level is 1, set experience points to 0 in instance variable.
    # If level is not 1, calculate the minimum experience point for that level and store it in instance variable.
    # Calculate pokemon stats and store them in instance variable
  end

  def prepare_for_battle
    # Complete this
  end

  def receive_damage
    # Complete this
  end

  def set_current_move
    # Complete this
  end

  def fainted?
    # Complete this
  end

  def attack(target)
    # Print attack message 'Tortuguita used MOVE!'
    # Accuracy check
    # If the movement is not missed
    # -- Calculate base damage
    # -- Critical Hit check
    # -- If critical, multiply base damage and print message 'It was CRITICAL hit!'
    # -- Effectiveness check
    # -- Mutltiply damage by effectiveness multiplier and round down. Print message if neccesary
    # ---- "It's not very effective..." when effectivenes is less than or equal to 0.5
    # ---- "It's super effective!" when effectivenes is greater than or equal to 1.5
    # ---- "It doesn't affect [target name]!" when effectivenes is 0
    # -- Inflict damage to target and print message "And it hit [target name] with [damage] damage""
    # Else, print "But it MISSED!"
  end

  def increase_stats(target)
    # Increase stats base on the defeated pokemon and print message "#[pokemon name] gained [amount] experience points"

    # If the new experience point are enough to level up, do it and print
    # message "#[pokemon name] reached level [level]!" # -- Re-calculate the stat
  end

  # private methods:
  # Create here auxiliary methods
end


# a = Pokemon.new("Bulbasaur")
# p a.species
# puts ""
# p a.type
