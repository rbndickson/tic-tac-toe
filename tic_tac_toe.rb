# tic_tac_toe.rb

WINNING_COMBOS = [
  [1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7],
  [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

def draw_board(play_s)
  puts " #{play_s[1]} | #{play_s[2]} | #{play_s[3]}          1 | 2 | 3 "
  puts '---|---|---        ---|---|---'
  puts " #{play_s[4]} | #{play_s[5]} | #{play_s[6]}          4 | 5 | 6 "
  puts '---|---|---        ---|---|---'
  puts " #{play_s[7]} | #{play_s[8]} | #{play_s[9]}          7 | 8 | 9 \n "
end

def players_turn(play_state)
  puts 'Your turn, what position 1 - 9 would you like to go?'
  players_position = gets.chomp.to_i
  until empty?(play_state, players_position) == true
    puts 'Place taken, choose a free space?'
    players_position = gets.chomp.to_i
  end
  play_state[players_position] = 'X'
  system 'clear'
  draw_board(play_state)
end

def get_empty_spaces(play_state)
  play_state.select { |_k, v| v == ' ' }
end

def empty?(play_state, space)
  empties = get_empty_spaces(play_state)
  empties.include?(space)
end

def two_in_a_row(play_state)
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
  false
end

def computers_turn(play_state)
  if two_in_a_row(play_state) != false
    computers_position = two_in_a_row(play_state)
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
      return true
    end
  end
  false
end

def play_one_game
  play_state = Hash[(1..9).collect { |num| [num, ' '] }]
  draw_board(play_state)

  loop do
    players_turn(play_state)
    if winner?(play_state, 'X') == true
      puts 'You won!'
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
  play_one_game
  puts 'Try again? (y/n)'
  break if gets.chomp.downcase == 'n'
end
