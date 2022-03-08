# frozen_string_literal: true

require_relative('project')

projects = [
  Project.new('lmn', 500, 3000),
  Project.new('xyz', 25, 75)
]

puts "\n#{projects.size} projects currently looking to raise money."
projects.push(Project.new('abc', 17, 42))

puts "\n#{projects.size} projects currently looking to raise money."
projects.each do |project|
  puts "\t#{project}"
end
