# frozen_string_literal: true

require_relative('project')

# Collection of projects (state) and interactions (behaviour) over them.
class Portfolio
  attr_reader :title

  def initialize(title)
    @title = title.capitalize
    @projects = []
  end

  def add_project(project)
    @projects.push(project)
  end

  def showcase
    puts self
    @projects.each { |project| puts "\t#{project}" }
    puts
  end

  # This method smells of :reek:NestedIterators
  def simulate
    @projects.each do |project|
      3.times { |_index| project.send(%i[add_funds remove_funds].sample) }
    end
  end

  def to_s
    "\n#{title} contains #{@projects.size} projects looking to raise money."
  end
end

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
