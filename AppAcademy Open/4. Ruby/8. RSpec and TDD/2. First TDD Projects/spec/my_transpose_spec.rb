require 'rspec'
require 'my_transpose'

describe '#my_transpose' do
  it 'receives an array' do
    cols = [
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8]
    ]
    expect { my_transpose(cols) }.to_not raise_error
  end

  it 'raises an error for non-arrays' do
    expect { my_transpose('Array') }.to raise_error(ArgumentError, 'Must be an array!')
  end

  it 'raises an error for non-square arrays' do
    not_square = [
      [1, 2],
      [1, 2],
      [1, 2]
    ]
    expect { my_transpose(not_square) }.to raise_error(ArgumentError, 'Array must be square!')
  end

  it 'transposes an array' do
    arr1 = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ]
    arr1_transposed = [
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8]
    ]
    expect(my_transpose(arr1)).to eq(arr1_transposed)

    arr2 = [%w[a b], %w[c d]]
    arr2_transposed = [%w[a c], %w[b d]]
    expect(my_transpose(arr2)).to eq(arr2_transposed)
  end
end
