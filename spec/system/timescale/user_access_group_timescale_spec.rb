require 'rails_helper'

describe 'Usuário vê detalhes de prazo' do
    it 'e é usuário regular' do
        # Arrange
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :regular)
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        Timescale.create!(min_distance:1,max_distance:10,deadline:24,transportation_modal:transportation_modal)

        # Act
        login_as user 
        visit root_path
        click_on 'Modalidade de Transporte'
        click_on 'Bicicleta'

        # Assert
        expect(page).to have_content 'Bicicleta'
        expect(page).to have_content '1km'
        expect(page).to have_content '10km'
        expect(page).to have_content '24h' 
        expect(page).not_to have_content 'Editar'
        expect(page).not_to have_content 'Configurar prazo'
    end

    it 'e é usuário administrador' do
        # Arrange
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        Timescale.create!(min_distance:1,max_distance:10,deadline:24,transportation_modal:transportation_modal)

        # Act
        login_as user 
        visit root_path
        click_on 'Modalidade de Transporte'
        click_on 'Bicicleta'

        # Assert
        expect(page).to have_content 'Bicicleta'
        expect(page).to have_content 'Editar'
        expect(page).to have_content 'Configurar prazo'
    end

end