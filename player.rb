require_relative "pokemon"
require_relative "pokedex/moves.rb"
require_relative "pokedex/pokemons.rb"
require_relative "get_inputs_and_prompts"
class Player
  attr_reader :pokemon, :name 
  # (Complete parameters)
  def initialize(name, pokemon_specie, pokemon_name = "")
    @name = name
    @pokemon = Pokemon.new(pokemon_specie, pokemon_name)
    # Complete this
  end

  def select_move # llamar al hash
    # Complete this
    #Pokedex::MOVES[move]
    move_selection = ""
    puts "#{pokemon.name}, select your move:"
    moves = pokemon.moves # array
    move_selection = input_validation(move_selection, moves)
    @pokemon.current_move = Pokedex::MOVES[move_selection]
  end
end
              
# Create a class Bot that inherits from Player and override the select_move method
class Bot < Player
  # solo se sobreescribe el select_move method
  attr_reader :pokemon_specie, :pokemon, :name
  def initialize(level = 1)
    @name = "Random person"
    @pokemon_options = Pokedex::POKEMONS
    @pokemon_specie = @pokemon_options.keys.sample
    @pokemon = Pokemon.new(@pokemon_specie, "", level = level)
  end

  def select_move
    selected_move = pokemon.moves.sample
    @pokemon.current_move = Pokedex::MOVES[selected_move]
  end

end

# player1 = Player.new("Fabio", "Charmander", "Bulbi")
# player1.select_move
