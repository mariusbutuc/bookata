# frozen_string_literal: true

require_relative('player')

# I'm Moe with a health of 100.
player1 = Player.new('moe')
puts player1

# I'm Larry with a health of 60.
player2 = Player.new('larry', 60)
puts player2

# I'm Curly with a health of 125.
player3 = Player.new('curly', 125)
puts player3

# Curly got blammed!
player3.blam

# I'm Curly with a health of 115.
puts player3

# Curly got w00ted!
player3.w00t

# I'm Curly with a health of 130.
puts player3
