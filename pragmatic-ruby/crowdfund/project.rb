class Project
  def initialize(name, funding, goal)
    @name = "Project #{name.upcase}"
    @funding = funding
    @goal = goal
  end

  def to_s
    "#{@name} has $#{@funding} in funding towards a goal of $#{@goal}."
  end

  def add_funds
    @funding += 25
    puts "#{@name} got more funds!"
  end

  def remove_funds
    @funding -= 15
    puts "#{@name} lost some funds!"
  end
end
