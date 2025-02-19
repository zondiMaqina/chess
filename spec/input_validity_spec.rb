# frozen_string_literal: true

require_relative '../lib/input_handling/input_validity'
require_relative 'spec_helper'

class InputCheck
  include InputValidity
end


RSpec.describe InputCheck do
  # initialze => assigns objects
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

  describe '#input_appearance' do
    context 'when input is only letters' do
      it 'will return falase' do
        invalid_input = 'add'
        result = player_input.input_appearance(invalid_input)
        expect(result).to be false
      end
    end

    context 'when input is only integers' do
      it 'will return false' do
        invalid_input = '12'
        result = player_input.input_appearance(invalid_input)
        expect(result).to be false
      end
    end

    context 'when input has 1 letter and 1 integer' do
      it 'will return true' do
        vald_input = 'A1'
        result = player_input.input_appearance(vald_input)
        expect(result).to be true
      end
    end
  end
end
