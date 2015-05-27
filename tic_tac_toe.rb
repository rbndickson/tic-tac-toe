# psudo code

# draw board
# player 1 draws X
# player 2 draws O
# repeat until someone wins or there are no more spaces.
# require 'pry'

system 'clear'

def draw_board(play_state)
  puts " #{play_state[1]} | #{play_state[2]} | #{play_state[3]} "
  puts "---|---|---"
  puts " #{play_state[4]} | #{play_state[5]} | #{play_state[6]} "
  puts "---|---|---"
  puts " #{play_state[7]} | #{play_state[8]} | #{play_state[9]} "

end

play_state = Hash[(1..9).collect { |num| [num, " "] }]  # does not work with each!! Ask peeps

draw_board(play_state)

def players_turn(play_state)
  puts "Your turn, what position 1 - 9 would you like to go?"
  players_position = gets.chomp.to_i
  play_state[players_position] = 'X'
  system 'clear'
  draw_board(play_state)
end

def get_empty_spaces(play_state)
  empty_spaces = play_state.select { |k,v| v == ' '}
end

def computers_turn(play_state)
  empty_spaces = get_empty_spaces(play_state)
  computers_position = empty_spaces.keys.sample
  play_state[computers_position] = 'O'
  system 'clear'
  draw_board(play_state)
end

loop do
  players_turn(play_state)
  computers_turn(play_state)
end
