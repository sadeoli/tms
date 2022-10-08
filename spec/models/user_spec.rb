require 'rails_helper'

RSpec.describe User, type: :model do
    describe '#valid?' do 
        context 'format' do
            it 'false quando o e-mail do domínio não é @sistemadefrete.com.br' do
                # Arrange
                user = User.new(email:'usuario@yahoo.com.br',password:'password')

                # Act
                result = user.valid?

                # Assert
                expect(result).to eq false
            end
        end
        
    end
end
