require 'rails_helper'

describe 'Usuário vê detalhes de preço' do
    it 'e é usuário regular' do
        # Arrange
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :regular)
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        Cost.create!(category: :weight, minimum:0,maximum:8,unit_price:50, transportation_modal:transportation_modal)
        Cost.create!(category: :distance, minimum:5, maximum:10,unit_price:30, transportation_modal:transportation_modal)

        # Act
        login_as user 
        visit root_path
        click_on 'Modalidade de Transporte'
        click_on 'Bicicleta'

        # Assert
        expect(page).to have_content 'Bicicleta'
        expect(page).to have_content 'Distância'
        expect(page).to have_content 'Peso'
        expect(page).to have_content '8kg'
        expect(page).to have_content '0kg'
        expect(page).to have_content ' R$ 50,00' 
        expect(page).not_to have_content 'Editar'
        expect(page).not_to have_content 'Configurar preço'
    end

    it 'e é usuário administrador' do
        # Arrange
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        Cost.create!(category: :weight, minimum:0,maximum:8,unit_price:50, transportation_modal:transportation_modal)
        Cost.create!(category: :distance, minimum:5, maximum:10,unit_price:30, transportation_modal:transportation_modal)

        # Act
        login_as user 
        visit root_path
        click_on 'Modalidade de Transporte'
        click_on 'Bicicleta'

        # Assert
        expect(page).to have_content 'Bicicleta'
        expect(page).to have_content 'Distância'
        expect(page).to have_content 'Peso'
        expect(page).to have_content 'Editar'
        expect(page).to have_content 'Configurar preço'
    end

end