# frozen_string_literal: true

projects = [
  { title: 'ABC', funding: 1000 },
  { title: 'LMN' },
  { title: 'XYZ' }
]

def project_info(title, funding = 0)
  # If `nil` is passed in, this seems to be a value on its own.
  #   …so the default parameter value does not work here!
  funding = 0 if funding.nil?
  "Project #{title} has $#{funding} in funding."
end

projects.each do |p|
  puts project_info(p[:title], p[:funding])
end
