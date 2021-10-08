# Used in printing to center justify a word
# @return [String] 
def center_justify(string, col_width, padding_str = ' ')
  left_padding_width = (col_width / 2) - (string.length / 2)
  right_padding_width = col_width - (string.length + left_padding_width)
  return (padding_str * left_padding_width) + string + (padding_str * right_padding_width)
end

def add_border(string, border_char = '*')
  "#{border_char}#{string}#{border_char}"
end
