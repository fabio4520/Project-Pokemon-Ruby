def get_input(prompt)
  input = ""
  while input.empty?
    puts prompt
    print "> "
    input = gets.chomp
  end
  input
end

$welcome_prompt_1 ="
#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#
#$#$#$#$#$#$#$                               $#$#$#$#$#$#$#
#$##$##$##$ ---        Pokemon Ruby         --- #$##$##$#$#
#$#$#$#$#$#$#$                               $#$#$#$#$#$#$#
#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#

Hello there! Welcome to the world of POKEMON! My name is OAK!
People call me the POKEMON PROF!

This world is inhabited by creatures called POKEMON! For some
people, POKEMON are pets. Others use them for fights. Myself...
I study POKEMON as a profession."

# name = ""
# $welcome_prompt_2 ="
# Right! So your name is #{name}!
# Your very own POKEMON legend is about to unfold! A world of
# dreams and adventures with POKEMON awaits! Let's go!
# Here, #{name}! There are 3 POKEMON here! Haha!
# When I was young, I was a serious POKEMON trainer.
# In my old age, I have only 3 left, but you can have one! Choose!\n\n"

# pokemon_name = ""
# $welcome_prompt_3 = "
# #{name}, raise your young #{pokemon_name.upcase} by making it fight!
# When you feel ready you can challenge BROCK, the PEWTER's GYM LEADER
# -----------------------Menu-----------------------

# 1. Stats        2. Train        3. Leader       4. Exit         "