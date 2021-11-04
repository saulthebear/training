require 'rspec'
require 'pick_stocks'


describe '#pick_stocks' do
  it 'finds a pair of profitable days' do
    expect(pick_stocks([7, 2, 5, 3, 2])).to eq([1, 2])
    expect(pick_stocks([3, 1, 0, 4, 6, 9])).to eq([2, 5])
  end

  it 'finds a better pair of days' do
    expect(pick_stocks([8, 7, 6, 8, 10, 0])).to eq([2, 4])
    expect(pick_stocks([3, 2, 5, 0, 6])).to eq([3, 4])
  end

  it 'doesn\'t pick any if there are no profitable pairs' do
    expect(pick_stocks([10, 9, 8, 5, 1])).to be_empty
    expect(pick_stocks([5, 4, 3, 2, 1])).to be_empty
  end

end
