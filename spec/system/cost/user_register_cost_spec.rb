require 'rails_helper'

describe 'Usuário cadastra uma configuração de preço' do
    it 'por peso' do
        # Arrange
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)

        # Act
        login_as user 
        visit root_path
        click_on 'Tarifas'
        click_on 'Cadastrar'
        select 'Peso (kg)', from: 'Categoria'
        fill_in 'Máximo', with: '10'
        fill_in 'Mínimo', with: '0'
        fill_in 'Preço', with: '50'
        click_on 'Cadastrar'

        # Assert
        expect(current_path).to eq costs_path
        expect(page).to have_content 'Peso'
        expect(page).to have_content '10kg'
        expect(page).to have_content '0kg'
        expect(page).to have_content 'R$50' 
    end
end