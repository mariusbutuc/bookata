# frozen_string_literal: true

projects = [
  { title: 'ABC', funding: 1000 },
  { title: 'LMN' },
  { title: 'XYZ' }
]

project = projects.first
puts "Project #{project[:title]} has $#{project[:funding]} in funding."

puts 'Projects:'
projects.each { |p| puts "\tProject #{p[:title]}" }
