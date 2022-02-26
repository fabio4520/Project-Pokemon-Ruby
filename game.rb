# require_relative "player"
require_relative "pokemon"
require_relative "pokedex/pokemons.rb"
require_relative "get_inputs_and_prompts"
class Game

  def get_pokemon_name(pokemon_specie)
    puts "Give your pokemon a name?"
    print "> "
    pokemon_name = gets.chomp
    pokemon_name = pokemon_specie if pokemon_name.empty?
    pokemon_name
  end

  def get_pokemon_specie
    pokemon_specie = ""
    options = Pokedex::POKEMONS.keys[0..2]
    until options.include?(pokemon_specie)
      options.each_with_index { |element, index| print "#{index + 1}. #{element}    " } 
      puts ""
      print "> "
      pokemon_specie = gets.chomp
    end
    pokemon_specie
  end

  def start
    # Create a welcome method(s) to get the name, pokemon and pokemon_name from the user
    puts $welcome_prompt_1
    name = get_input("First, what is your name?")
    puts $welcome_prompt_2
    pokemon_specie = get_pokemon_specie
    puts ""
    puts "You selected #{pokemon_specie.upcase}. Great choice!"
    pokemon_name = get_pokemon_name(pokemon_specie)

    pok = Pokemon.new(pokemon_specie, pokemon_name, 1)
    
    puts "#{name.upcase}, raise your young #{pokemon_name.upcase} by making it fight!"
    puts "When you feel ready you can challenge BROCK, the PEWTER's GYM LEADER"
    puts "-----------------------Menu-----------------------\n\n"
    puts "1. Stats        2. Train        3. Leader       4. Exit"
    print "> "
    action = gets.chomp
    puts ""
    
    # Then create a Player with that information and store it in @player


    # Suggested game flow
    action = menu
    # until action == "Exit"
    #   case action
    #   when "Train"
    #     train
    #     action = menu
    #   when "Leader"
    #     challenge_leader
    #     action = menu
    #   when "Stats"
    #     show_stats
    #     action = menu
    #   end
    # end

    goodbye
  end

  def train
    # Complete this
  end

  def challenge_leader
    # Complete this
  end

  def show_stats
    # Complete this



  end

  def goodbye
    # Complete this
  end

  def menu
    # Complete this
  end
end

game = Game.new
game.start
