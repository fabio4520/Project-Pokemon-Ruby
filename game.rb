# require_relative "player"
require_relative "pokemon"

class Game

  def start
    # Create a welcome method(s) to get the name, pokemon and pokemon_name from the user
    
    puts "#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#"
    puts "#$#$#$#$#$#$#$                               $#$#$#$#$#$#$#"
    puts "#$##$##$##$ ---        Pokemon Ruby         --- #$##$##$#$#"
    puts "#$#$#$#$#$#$#$                               $#$#$#$#$#$#$#"
    puts "#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#"
    puts ""
    puts  "Hello there! Welcome to the world of POKEMON! My name is OAK!"
    puts  "People call me the POKEMON PROF!"
    puts ""
    puts  "This world is inhabited by creatures called POKEMON! For some"
    puts  "people, POKEMON are pets. Others use them for fights. Myself..."
    puts  "I study POKEMON as a profession."
    name = ""
    while name.empty?
      puts "First, what is your name?"
      print "> "
      name = gets.chomp
    end

    puts  "Right! So your name is #{name}"
    puts  "Your very own POKEMON legend is about to unfold! A world of"
    puts  "dreams and adventures with POKEMON awaits! Let's go!"
    puts  "Here, #{name}! There are 3 POKEMON here! Haha!"
    puts  "When I was young, I was a serious POKEMON trainer."
    puts  "In my old age, I have only 3 left, but you can have one! Choose!"
    puts ""
    validation = true
    pokemon = ""
    while validation
      puts "1. Bulbasaur    2. Charmander   3. Squirtle"
      print "> "
      pokemon = gets.chomp
      validation = false if pokemon == "Bulbasaur" || pokemon == "Charmander" || pokemon == "Squirtle"
    end
    puts ""
    puts "You selected #{pokemon.upcase}. Great choice!"
    puts "Give your pokemon a name?"
    print "> "
    pokemon_name = gets.chomp

    pokemon_name = pokemon if pokemon_name.empty? || pokemon_name.nil?    

    pok = Pokemon.new(pokemon, pokemon_name, 1)
    # p pok.name
    # p pok.species

    puts "#{name}, raise your young #{pokemon_name.upcase} by making it fight!"
    puts "When you feel ready you can challenge BROCK, the PEWTER's GYM LEADER"
    puts "-----------------------Menu-----------------------"
    puts ""
    print "> "
    puts "1. Stats        2. Train        3. Leader       4. Exit"
    print "> "
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
