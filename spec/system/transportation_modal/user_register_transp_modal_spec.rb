require 'rails_helper'

describe 'Usuario cadastra uma modalidade de transporte' do
    it 'a partir do menu' do
        # Arrange
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)

        # Act
        login_as user 
        visit root_path
        click_on 'Modalidade de Transporte'
        click_on 'Cadastrar'

        # Assert
        expect(page).to have_field('Nome')
        expect(page).to have_field('Distância Máxima')
        expect(page).to have_field('Distância Mínima')
        expect(page).to have_field('Peso Máximo da Carga')
        expect(page).to have_field('Peso Mínimo da Carga')
        expect(page).to have_field('Taxa Fixa')
    end

    it 'com sucesso' do
        # Arrange
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)

        # Act
        login_as user 
        visit root_path
        click_on 'Modalidade de Transporte'
        click_on 'Cadastrar'
        fill_in 'Nome', with: 'Bicicleta'
        fill_in 'Distância Máxima', with: '10'
        fill_in 'Distância Mínima', with: '1'
        fill_in 'Peso Máximo da Carga', with: '8'
        fill_in 'Peso Mínimo da Carga', with: '0'
        fill_in 'Taxa Fixa', with: '5'
        click_on 'Cadastrar'

        # Assert
        expect(current_path).to eq transportation_modals_path
        expect(page).to have_content 'Bicicleta'
        expect(page).to have_content 'Distância Máxima 10km'
        expect(page).to have_content 'Distância Mínima 1km'
        expect(page).to have_content 'Peso Máximo da Carga 8kg'
        expect(page).to have_content 'Peso Mínimo da Carga 0kg'
        expect(page).to have_content 'Taxa Fixa R$ 5,00'
        expect(page).to have_content 'Modalidade de transporte cadastrada com sucesso.'
    end
end
