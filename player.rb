require_relative "pokemon"
require_relative "pokedex/pokemons.rb"
class Player
  attr_reader :pokemon
  # (Complete parameters)
  def initialize(name, pokemon_specie, pokemon_name = "")
    @name = name
    @pokemon = Pokemon.new(pokemon_specie, pokemon_name)
    # Complete this
  end

  def select_move
    # Complete this
  end
end

# Create a class Bot that inherits from Player and override the select_move method
class Bot < Player
  # solo se sobreescribe el select_move method
  attr_reader :pokemon_specie, :pokemon, :name
  def initialize(name, pokemon_specie, pokemon_name = "", level = 1)
    @name = "Random person"
    @pokemon_options = Pokedex::POKEMONS
    @pokemon_specie = @pokemon_options.keys.sample
    @pokemon = Pokemon.new(@pokemon_specie, pokemon_name, level = level)
  end
end

# bot = Bot.new("","","")
# p bot.pokemon_specie
# p "##########"
# p bot.pokemon