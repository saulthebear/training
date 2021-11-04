require 'rspec'
require 'remove_dups'

describe '#my_uniq' do

  it 'returns a new array' do
    arr = [1, 2, 3]
    expect(my_uniq(arr)).to_not be(arr)
  end

  context 'when the array is empty' do
    it 'returns an empty array' do
      expect(my_uniq([])).to be_empty
    end
  end

  context 'when there are no duplicates' do
    it 'returns an equal array' do
      expect(my_uniq([1, 2, 3])).to eq([1, 2, 3])
    end
  end

  context 'when the array has duplicates' do
    it 'removes duplicates' do
      expect(my_uniq([1, 2, 1, 3, 3])).to eq([1, 2, 3])
    end

    it 'doesn\'t change the order' do
      expect(my_uniq([3, 3, 1, 5, 2, 6, 5])).to eq([3, 1, 5, 2, 6])
    end
  end
end
