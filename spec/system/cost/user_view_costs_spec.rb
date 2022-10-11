require 'rails_helper'

describe 'Usuário vê configuração de preço' do
    it 'por peso' do
        # Arrange
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password')
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        Cost.create!(category: :weight, minimum:0,maximum:10,unit_price:50, transportation_modal:transportation_modal)


        # Act
        login_as user 
        visit root_path
        click_on 'Tarifas'

        # Assert
        expect(current_path).to eq costs_path
        expect(page).to have_content 'Peso'
        expect(page).to have_content '10kg'
        expect(page).to have_content '0kg'
        expect(page).to have_content 'R$50' 
    end

    it 'por distância' do
        # Arrange
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password')
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        Cost.create!(category: :distance, minimum:5, maximum:40,unit_price:30, transportation_modal:transportation_modal)


        # Act
        login_as user 
        visit root_path
        click_on 'Tarifas'

        # Assert
        expect(current_path).to eq costs_path
        expect(page).to have_content 'Distância'
        expect(page).to have_content '5km'
        expect(page).to have_content '40km'
        expect(page).to have_content 'R$30' 
    end
end