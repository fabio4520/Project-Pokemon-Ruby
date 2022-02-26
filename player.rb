require_relative "pokemon"
require_relative "pokedex/moves.rb"
require_relative "pokedex/pokemons.rb"
class Player
  attr_reader :pokemon, :name
  # (Complete parameters)
  def initialize(name, pokemon_specie, pokemon_name = "")
    @name = name
    @pokemon = Pokemon.new(pokemon_specie, pokemon_name)
    # Complete this
  end

  def select_move(move) # llamar al hash
    # Complete this
    return Pokedex::MOVES[move]
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
end

# player1 = Player.new("Fabio", "Charmander", "Bulbi")
# player1.select_move
