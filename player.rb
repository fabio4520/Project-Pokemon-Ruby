# require neccesary files
require_relative "pokemon"
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
end