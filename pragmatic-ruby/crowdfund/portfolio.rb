# frozen_string_literal: true

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
