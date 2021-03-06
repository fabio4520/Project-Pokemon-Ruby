require_relative "pokemon"
require_relative "pokedex/moves"
require_relative "pokedex/pokemons"
require_relative "get_inputs_and_prompts"
class Player
  attr_reader :pokemon, :name

  def initialize(name, pokemon_specie, pokemon_name = "")
    @name = name
    @pokemon = Pokemon.new(pokemon_specie, pokemon_name)
  end

  # llamar al hash
  def select_move
    puts ""
    move_selection = ""
    puts "#{pokemon.name}, select your move:"
    moves = pokemon.moves # array
    move_selection = input_validation(move_selection, moves)
    @pokemon.current_move = Pokedex::MOVES[move_selection] # Hash. Ej. { user: :normal, target: :rock, multiplier: 0.5 }
  end
end

# Create a class Bot that inherits from Player and override the select_move method
class Bot < Player
  attr_reader :pokemon_specie, :pokemon, :name

  def initialize(level = 1)
    @name = "Random person"
    @pokemon_options = Pokedex::POKEMONS
    @pokemon_specie = @pokemon_options.keys.sample # string
    @pokemon = Pokemon.new(@pokemon_specie, @pokemon_specie, level)
  end

  def select_move
    selected_move = pokemon.moves.sample # aleatorio del hash
    @pokemon.current_move = Pokedex::MOVES[selected_move]
  end
end

class Leader < Player
  attr_reader :pokemon_specie, :pokemon, :name

  def initialize
    @name = "Gym Leader Brock"
    @pokemon_specie = "Onix"
    @pokemon = Pokemon.new(@pokemon_specie, @pokemon_specie, 10)
  end

  def select_move
    selected_move = pokemon.moves.sample # aleatorio del hash
    @pokemon.current_move = Pokedex::MOVES[selected_move]
  end
end
