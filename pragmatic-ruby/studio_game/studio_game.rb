# frozen_string_literal: true

greeting = 'Welcome!'

# greeting << 'World'
# studio_game/studio_game.rb:5:in `<main>': can't modify frozen String: "Welcome!" (FrozenError)

3.times do
  puts greeting.upcase
end

puts Time.now
