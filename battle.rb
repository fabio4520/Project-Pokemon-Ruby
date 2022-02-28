require_relative "player"
require_relative "pokemon"

class Battle
  # (complete parameters)

  def initialize(player, bot)
    @player = player
    @bot = bot
    @player_poke = player.pokemon
    @bot_poke = bot.pokemon
    @player_speed = player.pokemon.stats[:speed]
    @bot_speed = bot.pokemon.stats[:speed]
  end

  def start
    # Prepare the Battle (print messages and prepare pokemons)
    @player_poke.prepare_for_battle
    @bot_poke.prepare_for_battle

    puts ""
    puts "#{@bot.name} sent out #{@bot_poke.species.upcase}!"
    puts "#{@player.name} sent out #{@player_poke.name.upcase}!"

    # Until one pokemon faints
    battle_loop
    # --Print Battle Status
    # --Both players select their moves

    # --Calculate which go first and which second

    # --First attack second
    # --If second is fainted, print fainted message
    # --If second not fainted, second attack first
    # --If first is fainted, print fainted message

    # Check which player won and print messages
    winner = @player_poke.fainted? ? @bot_poke : @player_poke
    loser = (winner == @player_poke) ? @bot_poke : @player_poke
    # If the winner is the Player increase pokemon stats
    winner.increase_stats(loser)
  end

  def battle_loop
    puts "-------------------Battle Start!-------------------\n\n"

    until @player_poke.fainted? || @bot_poke.fainted?

      puts "#{@player.name}'s #{@player_poke.name} - Level #{@player_poke.level}"
      puts "HP: #{@player_poke.current_hp}"
      puts "#{@bot.name}'s #{@bot_poke.species} - Level #{@bot_poke.level}"
      puts "HP: #{@bot_poke.current_hp}"

      @player.select_move
      @bot.select_move

      first = select_first(@player_poke, @bot_poke)
      second = (first == @player_poke) ? @bot_poke : @player_poke
      # p first
      # p second
      first.attack(@player, @bot)
      puts "-" * 50
      second.attack(@bot, @player) unless second.fainted? 
      puts "-" * 50       
    end

  end

  def select_first(player_poke, bot_poke)
    player_move = @player_poke.current_move
    bot_move = @bot_poke.current_move
  
    return @player_poke if player_move[:priority] > bot_move[:priority]
    return @bot_poke if player_move[:priority] < bot_move[:priority]

    if @player_speed > @bot_speed
      @player_poke
    elsif @player_speed < @bot_speed
      @bot_poke
    else
      [@player_poke, @bot_poke].sample
    end
  
  end

end
