require 'rspec'
require 'two_sum'

describe '#two_sum' do
  it 'returns an array' do
    expect([].two_sum).to be_an(Array)
  end

  it 'finds pairs that sum to zero' do
    expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
  end

  it 'returns in dictionary order' do
    expect([3, 3, -3, 4, 5].two_sum).to eq([[0, 2], [1, 2]])

    expect([3, -3, -3, 4, 5].two_sum).to eq([[0, 1], [0, 2]])
    expect([-3, 3, 3, 4, 5].two_sum).to eq([[0, 1], [0, 2]])
  end
end
