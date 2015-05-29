# psudo code

# draw board
# player 1 draws X
# player 2 draws O
# repeat until someone wins or there are no more spaces.
require 'pry'

WINNING_COMBOS = [
  [1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7],
  [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

def draw_board(play_state)
  puts " #{play_state[1]} | #{play_state[2]} | #{play_state[3]} "
  puts '---|---|---'
  puts " #{play_state[4]} | #{play_state[5]} | #{play_state[6]} "
  puts '---|---|---'
  puts " #{play_state[7]} | #{play_state[8]} | #{play_state[9]} "
end

def players_turn(play_state)
  puts 'Your turn, what position 1 - 9 would you like to go?'
  players_position = gets.chomp.to_i
  until is_empty?(play_state, players_position) == true do
    puts 'Place taken, choose a free space?'
    players_position = gets.chomp.to_i
  end
  play_state[players_position] = 'X'
  system 'clear'
  draw_board(play_state)
end

def get_empty_spaces(play_state)
  play_state.select { |k, v| v == ' ' }
end

def is_empty?(play_state, space)
  empties = get_empty_spaces(play_state)
  empties.include?(space)
end

def block(play_state)
  WINNING_COMBOS.each do |combo|
    if play_state[combo[0]] == 'X' &&
       play_state[combo[1]] == 'X' &&
       play_state[combo[2]] == ' '
      return combo[2]
    elsif play_state[combo[0]] == 'X' &&
          play_state[combo[1]] == ' ' &&
          play_state[combo[2]] == 'X'
      return combo[1]
    elsif play_state[combo[0]] == ' ' &&
          play_state[combo[1]] == 'X' &&
          play_state[combo[2]] == 'X'
      return combo[0]
    end
  end
  return false
end

def computers_turn(play_state)
  if block(play_state) != false
    computers_position = block(play_state)
  elsif is_empty?(play_state, 5)
    computers_position = 5
  else
    empty_spaces = get_empty_spaces(play_state)
    computers_position = empty_spaces.keys.sample
  end
  play_state[computers_position] = 'O'
  system 'clear'
  draw_board(play_state)
end

def winner?(play_state, symbol)
  WINNING_COMBOS.each do |combo|
    if play_state[combo[0]] == symbol &&
       play_state[combo[1]] == symbol &&
       play_state[combo[2]] == symbol
      return true                       # I thought I didn't need to say return
    end
  end
  return false
end

def game
  play_state = Hash[(1..9).collect { |num| [num, ' '] }] # Don't fully understand
  draw_board(play_state)

  loop do
    players_turn(play_state)
    if winner?(play_state, 'X') == true
      puts "Player won!"
      break
    end

    computers_turn(play_state)
    if winner?(play_state, 'O') == true
      puts 'Computer won!'
      break
    end

    if get_empty_spaces(play_state) == {}
      puts "It's a draw"
      break
    end
  end
end

loop do
  system 'clear'
  game
  puts 'Try again? (y/n)'
  break if gets.chomp.downcase == 'n'
end
