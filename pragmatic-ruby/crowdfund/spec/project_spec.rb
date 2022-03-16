# frozen_string_literal: true

require_relative '../lib/project'

# rubocop:disable Metrics/BlockLength
describe Project do
  before do
    $stdout = StringIO.new
  end

  context 'created with a funding amount' do
    before do
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

  context 'about to get funded' do
    before do
      @goal = 10_000
      @initial_funding = @goal - 17
      @project = Project.new('asdf', @goal, @initial_funding)
    end

    it 'knows when it is not fully funded yet' do
      expect(@project).not_to be_fully_funded
    end

    it 'knows when it is fully funded' do
      @project.add_funds

      expect(@project).to be_fully_funded
    end
  end
end
# rubocop:enable Metrics/BlockLength
