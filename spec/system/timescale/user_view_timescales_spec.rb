require 'rails_helper'

describe 'Usuário vê configuração de prazos' do
    it 'a partir do menu' do
        # Arrange
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password')
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        Timescale.create!(min_distance:1,max_distance:10,deadline:24,transportation_modal:transportation_modal)


        # Act
        login_as user 
        visit root_path
        click_on 'Tarifas'

        # Assert
        expect(current_path).to eq costs_path
        expect(page).to have_content 'Bicicleta'
        expect(page).to have_content '1km'
        expect(page).to have_content '10km'
        expect(page).to have_content '24h'
    end

    it 'a partir de uma modalidade de transporte' do
        # Arrange
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password')
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        Timescale.create!(min_distance:1,max_distance:10,deadline:24,transportation_modal:transportation_modal)


        # Act
        login_as user 
        visit root_path
        click_on 'Modalidade de Transporte'
        click_on 'Bicicleta'

        # Assert
        expect(page).to have_content 'Configuração de Prazos'
        expect(page).to have_content '1km'
        expect(page).to have_content '10km'
        expect(page).to have_content '24h'
    end

end