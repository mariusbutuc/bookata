# frozen_string_literal: true

require_relative 'project'

# rubocop:disable Metrics/BlockLength
describe Project do
  context 'created with a funding amount' do
    before do
      $stdout = StringIO.new

      @goal = 1000
      @initial_funding = 650
      @project = Project.new('asdf', @goal, @initial_funding)
    end

    it('has an initial target funding amount') do
      expect(@project.goal).to eq(@goal)
    end

    it('computes the total funding outstanding as the target funding amount minus the funding amount') do
      total_funding_outstanding = @project.goal - @project.funding

      expect(@project.outstanding).to eq(total_funding_outstanding)
    end

    it('increases funds by 25 when funds are added') do
      @project.add_funds

      expect(@project.funding).to eq(@initial_funding + 25)
    end

    it('decreases funds by 15 when funds are removed') do
      @project.remove_funds

      expect(@project.funding).to eq(@initial_funding - 15)
    end
  end

  context 'created without a funding amount' do
    it('has a default value of 0 for funding amount') do
      project = Project.new('ghjk', 10_000)

      expect(project.funding).to eq(0)
    end
  end
end
# rubocop:enable Metrics/BlockLength
