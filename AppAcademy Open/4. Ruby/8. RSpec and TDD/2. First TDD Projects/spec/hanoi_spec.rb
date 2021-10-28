require 'rspec'
require 'hanoi'

describe Hanoi do

  describe '#initialize' do
    it 'starts with 3 empty pegs'
  end

  describe '#move' do
    it 'allows moving a small disk onto a larger one'

    it 'doesn\'t allow moving a larger disk onto a smaller disk'

    it 'allows moving any disk onto an empty peg'
  end

  describe '#won?' do
    it 'returns false unless all disks are on one peg'

    it 'returns true if all disks are on one peg'

  end
end
