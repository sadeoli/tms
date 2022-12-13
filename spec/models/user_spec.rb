# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe '#valid?' do
    context 'format' do
      it 'false quando o e-mail do domínio não é @sistemadefrete.com.br' do
        # Arrange
        user = described_class.new(email: 'usuario@yahoo.com.br', password: 'password')

        # Act
        result = user.valid?

        # Assert
        expect(result).to be false
      end
    end
  end
end
