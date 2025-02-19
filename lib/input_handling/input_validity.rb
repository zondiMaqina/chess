# frozn_string_literal: true

# module for handling players' input
class InputValidity
  def initialize
    @columns = %w[0 1 2 3 4 5 6 7]
    @rows = %w[A B C D E F G H]
  end

  def input_valid?(input)
    # emoves whitespace and capitalizes
    input = input.gsub(/\s+/, '').upcase
    input_size(input) == true && input_appearance(input) == true
  end

  def input_size(input)
    input.size == 2
  end

  def input_appearance(input)
    @rows.include?(input[0]) && @columns.include?(input[1])
  end
end
