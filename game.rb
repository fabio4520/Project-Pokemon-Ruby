# require_relative "player"
require_relative "pokemon"
require_relative "player"
require_relative "pokedex/pokemons"
require_relative "get_inputs_and_prompts"
require_relative "battle"
class Game
  def get_pokemon_name(pokemon_specie)
    puts "Give your pokemon a name?"
    print "> "
    pokemon_name = gets.chomp
    pokemon_name = pokemon_specie if pokemon_name.empty?
    pokemon_name
  end

  def start
    # Create a welcome method(s) to get the name, pokemon and pokemon_name from the user
    puts $welcome_prompt_1
    name = get_input("First, what is your name?")
    puts "Right! So your name is #{name.upcase}!"
    puts "Your very own POKEMON legend is about to unfold! A world of"
    puts "dreams and adventures with POKEMON awaits! Let's go!"
    puts "Here, #{name.upcase}! There are 3 POKEMON here! Haha!"
    puts "When I was young, I was a serious POKEMON trainer."
    puts "In my old age, I have only 3 left, but you can have one! Choose!\n\n"
    pokemon_specie = ""
    options = Pokedex::POKEMONS.keys[0..2] # ["Bulbasaur", "Charmander", "Squirtle"]

    pokemon_specie = input_validation(pokemon_specie, options)
    puts ""
    puts "You selected #{pokemon_specie.upcase}. Great choice!"
    pokemon_name = get_pokemon_name(pokemon_specie)

    # Then create a Player with that information and store it in @player
    player = Player.new(name, pokemon_specie, pokemon_name)

    # Suggested game flow
    def train(name, player)
      # Complete this
      level_pok_player = player.pokemon.level
      bot = Bot.new(level_pok_player + rand(1..2))
      puts "#{name} challenge #{bot.name} for training"
      puts "Random Person has a #{bot.pokemon.species} level #{bot.pokemon.level}"
      puts "What do you want to do now?"
      puts ""
      options = ["Fight", "Leave"]
      player_action = ""
      player_action = input_validation(player_action, options)
      return if player_action == "Leave"

      battle = Battle.new(player, bot)
      battle.start
    end

    def challenge_leader(name, player)
      # Complete this
      # level_pok_player = player.pokemon.level
      leader = Leader.new
      puts "#{name} challenge #{leader.name} for training"
      puts "#{leader.name} has a #{leader.pokemon.species} level #{leader.pokemon.level}"
      puts "What do you want to do now?"
      puts ""
      options = ["Fight", "Leave"]
      player_action = ""
      player_action = input_validation(player_action, options)
      return if player_action == "Leave"

      battle = Battle.new(player, leader)
      battle.start
    end

    def show_stats(player)
      # Complete this
      pokemon_stats = player.pokemon.stats
      pokemon = player.pokemon
      puts "#{pokemon.name}:"
      puts "Kind: #{pokemon.species}"
      puts "Level: #{pokemon.level}"
      puts "Type: #{pokemon.type.join(', ')}"
      puts "Stats:"
      pokemon_stats.each do |stat, data|
        stat = stat.to_s.split("_")
        puts "#{stat[0].capitalize}: #{data}" if stat.length == 1
        puts "#{stat[0].capitalize} #{stat[1].capitalize}: #{data}" if stat.length == 2
      end
      puts "Experience Points: #{player.pokemon.experience_points}"
    end

    def goodbye
      # Complete this
      puts "Thanks for playing Pokemon Ruby"
      puts "This game was created with love by: Kevin L., Ariana A., Fabio F., Gustavo Ghost"
    end

    def menu
      puts "-----------------------Menu-----------------------\n\n"
      puts "1. Stats        2. Train        3. Leader       4. Exit"
      print "> "
      action = gets.chomp
      puts ""
      action
    end

    puts "#{name.upcase}, raise your young #{pokemon_name.upcase} by making it fight!"
    puts "When you feel ready you can challenge BROCK, the PEWTER's GYM LEADER"

    action = menu

    until action == "Exit"
      case action
      when "Train"
        train(name, player)
      when "Leader"
        challenge_leader(name, player)
      when "Stats"
        show_stats(player)
      end
      action = menu
    end

    goodbye
  end
end

game = Game.new
game.start
