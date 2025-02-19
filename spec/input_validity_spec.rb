# frozen_string_literal: true

require_relative '../lib/input_handling/input_validity'
require_relative 'spec_helper'


RSpec.describe InputValidity do
  subject(:player_input) { described_class.new }

  describe 'input_valid?' do
    context 'when player input has more than 2 char' do
      it 'will return false' do
        invalid_input = 'a#'
        expect(player_input).not_to be_input_valid(invalid_input)
      end
    end

    context 'when input is less than 2 chars long' do
      it 'will return false' do
        invalid_input = '2'
        expect(player_input).not_to be_input_valid(invalid_input)
      end
    end

    context 'when input is valid' do
      it 'will return true' do
        valid_input = 'a2'
        expect(player_input).to be_input_valid(valid_input)
      end
    end
  end
end


# takes input wiht no whitespaces
# if input length != 2
  # return false
# if input has only letters
  # return false
# if input has only numbers
  # return false
# return true if input is valid