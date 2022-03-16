# frozen_string_literal: true

require_relative '../lib/fundraising_program'
require_relative '../lib/project'

describe FundraisingProgram do
  before do
    $stdout = StringIO.new
  end

  before do
    @fundraising = FundraisingProgram.new('fundraising program')

    @initial_funding = 1750
    @project = Project.new('xyz', 10_000, @initial_funding)
    @fundraising.add_project(@project)
  end

  context 'when an even number is rolled' do
    fit 'adds funds to the project' do
      allow_any_instance_of(Die).to receive(:roll).and_return(2)

      @fundraising.simulate

      expect(@project.funding).to eq(@initial_funding + 25)
    end
  end

  context 'when an odd number is rolled' do
    it 'removes funds from the project' do
      allow_any_instance_of(Die).to receive(:roll).and_return(3)

      @fundraising.simulate

      expect(@project.funding).to eq(@initial_funding - 15)
    end
  end
end
