# frozen_string_literal: true

puts "\n[welcome] Player 1: Larry!"
name1 = 'larry'
health1 = 60
puts "\t#{name1.capitalize} has a health of #{health1}."

puts "\n[welcome] Player 2: Curly!"
name2 = 'curly'
health2 = 125
puts "\t#{name2.upcase} has a health of #{health2}."

puts "\n[caution] ⚠️ effects of passing by \"object reference\""
health2 = health1
puts "\t#{name2.upcase} has a health of #{health2} now."

puts "\n[caution] ⚠️ effects of passing by \"object reference\""
health1 = 30
puts "\t#{name1.capitalize} has a health of #{health1} now."
puts "\t#{name2.upcase} has a health of #{health2} still."

puts "\n[welcome] Player 3: Moe!"
name3 = 'moe'
health3 = 100
status = "#{name3.capitalize} has a health of #{health3}."
puts "\t" + status.center(50, '*')

puts "\n[welcome] Player 4: Shemp!"
name4 = 'shemp'
health4 = 90
formatted_name = name4.capitalize.ljust(30, '.')
puts "\t#{formatted_name} #{health4} health"

puts "\n[welcome] Are we ready to start the Game?"
current_time = Time.new
formatted_time = current_time.strftime('%A %m/%d/%Y at %I:%M%p')
puts "\tThe game started on #{formatted_time}.\n\n"
