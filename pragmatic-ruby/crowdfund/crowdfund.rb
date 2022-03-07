# frozen_string_literal: true

require_relative('project')

# Project LMN has $500 in funding towards a goal of $3000.
lmn = Project.new('lmn', 500, 3000)
puts lmn

# Project XYZ has $25 in funding towards a goal of $75.
xyz = Project.new('xyz', 25, 75)
puts xyz

# Project LMN lost some funds!
lmn.remove_funds

# Project XYZ got more funds!
xyz.add_funds

# Project LMN has $485 in funding towards a goal of $3000.
puts lmn

# Project XYZ has $50 in funding towards a goal of $75.
puts xyz
