# frozen_string_literal: true

require_relative 'lib/project'
require_relative 'lib/fundraising_program'

smb = FundraisingProgram.new('smb')

[
  Project.new('abc', 42, 17),
  Project.new('lmn', 3000, 500),
  Project.new('xyz', 75, 25)
].each do |project|
  smb.add_project(project)
end

smb.brief
smb.simulate
smb.debrief
