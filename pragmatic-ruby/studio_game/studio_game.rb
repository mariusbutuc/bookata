# frozen_string_literal: true

require_relative('player')

# Larry
player2 = Player.new('larry', 60)
puts player2.name

# Lawrence
player2.name = 'lawrence'
puts player2.name

# 60
puts player2.health

# 68
puts player2.score

# I'm Lawrence with a health of 60 and a score of 68.
puts player2
