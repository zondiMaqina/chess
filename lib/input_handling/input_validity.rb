# frozn_string_literal: true

# module for handling players' input
class InputValidity
  def initialize
    @columns = %w[0 1 2 3 4 5 6 7]
    @rows = %w[a b c d e f g h]
  end

  def input_valid?(input)
    # removes whitespace and capitalizes
    input = input.gsub(/\s+/, '').downcase
    input_size(input) == true && input_appearance(input) == true
  end

  def input_size(input)
    input.size == 2
  end

  def input_appearance(input)
    @rows.include?(input[0]) && @columns.include?(input[1])
  end
end
