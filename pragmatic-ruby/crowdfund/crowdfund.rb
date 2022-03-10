# frozen_string_literal: true

require_relative 'lib/project'
require_relative 'lib/portfolio'

smb = Portfolio.new('smb')

[
  Project.new('abc', 17, 42),
  Project.new('lmn', 500, 3000),
  Project.new('xyz', 25, 75)
].each do |project|
  smb.add_project(project)
end

smb.showcase
smb.simulate
smb.showcase
