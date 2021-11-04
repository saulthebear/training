require 'rspec'
require 'hanoi'

describe Hanoi do
  subject { Hanoi.new }
  describe '#initialize' do
    it 'starts with 5 disks on one peg, and two empty pegs' do
      expect(subject.pegs).to contain_exactly([], [], [5, 4, 3, 2, 1])
    end
  end

  describe '#move' do
    it 'moves the top peg from one stack to another' do
      subject.move(0, 1)
      expect(subject.pegs).to eq([[5, 4, 3, 2], [1], []]) 
      subject.move(0, 2)
      expect(subject.pegs).to eq([[5, 4, 3], [1], [2]]) 

    end

    it 'allows moving a small disk onto a larger one' do
      subject.move(0, 1)
      subject.move(0, 2)
      subject.move(1, 2)
      expect(subject.pegs).to eq([[5, 4, 3], [], [2, 1]]) 
    end

    it 'doesn\'t allow moving a larger disk onto a smaller disk' do
      subject.move(0, 1)
      expect { subject.move(0, 1) }.to raise_error(MoveError, '2 cannot fit ontop of 1')
    end

    it 'raises an error when trying to move from an empty peg' do
      err_msg = 'That peg is empty! Nothing to move'
      expect { subject.move(1, 2) }.to raise_error(MoveError, err_msg)
    end
  end

  describe '#won?' do
    before(:each) do
      subject.move(0, 2)
      subject.move(0, 1)
      subject.move(2, 1)
      subject.move(0, 2)
      subject.move(1, 0)

      subject.move(1, 2)
      subject.move(0, 2)
      subject.move(0, 1)
      subject.move(2, 1)
      subject.move(2, 0)

      subject.move(1, 0)
      subject.move(2, 1)
      subject.move(0, 2)
      subject.move(0, 1)
      subject.move(2, 1)

      subject.move(0, 2)
      subject.move(1, 0)
      subject.move(1, 2)
      subject.move(0, 1)
      subject.move(1, 2)

      subject.move(1, 0)
      subject.move(2, 1)
      subject.move(2, 0)
      subject.move(1, 0)
      subject.move(1, 2)

      subject.move(0, 2)
      subject.move(0, 1)
      subject.move(2, 1)
      subject.move(0, 2)
      subject.move(1, 0)

      subject.move(1, 2)
    end

    context 'In starting position' do
      in_start_position = Hanoi.new
      it 'doesn\'t return true' do
        expect(in_start_position.pegs).to eq([[5, 4, 3, 2, 1], [], []])
        expect(in_start_position).to_not be_won
      end
    end

    it 'returns false unless all disks are on one peg' do
      expect(subject).to_not be_won
    end

    it 'returns true if all disks are on one peg' do
      subject.move(0, 2)
      expect(subject).to be_won
    end
  end
end
