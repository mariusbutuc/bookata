# frozen_string_literal: true

name = 'larry'
health = 60
# player_info = name + '\'s health is ' + health.to_s
player_info = "#{name}'s health is #{health}"

puts player_info

curly = 'curly'
moe = 'moe'
players = "Players:\n\t#{name}\n\t#{curly}\n\t#{moe}"

puts players

puts "\n\nSome \"tests\":"

PASS = '✔️✔️'
FAIL = '💥'

{
  list_of_players: players == "Players:\n\tlarry\n\tcurly\n\tmoe" ? PASS : FAIL,
  player_info: player_info == "larry's health is 60" ? PASS : FAIL
}.each do |assertion, status|
  puts "\t#{status} #{assertion}"
end
