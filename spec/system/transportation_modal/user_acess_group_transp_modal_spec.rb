require 'rails_helper'

describe 'Usuário vê detalhes de uma modalidade de transporte' do
    it 'e é usuário regular' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                    max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :regular)

        # Act
        login_as user 
        visit root_path
        click_on 'Modalidade de Transporte'
        click_on 'Bicicleta'

        # Assert
        expect(page).not_to have_content 'Configurar preço'
        expect(page).not_to have_content 'Configurar prazo'
        expect(page).not_to have_content 'Editar'
        expect(page).not_to have_content 'Desativar'
    end

    it 'e é usuário administrador' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                    max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)

        # Act
        login_as user 
        visit root_path
        click_on 'Modalidade de Transporte'
        click_on 'Bicicleta'

        # Assert
        expect(page).to have_content 'Configurar preço'
        expect(page).to have_content 'Configurar prazo'
        expect(page).to have_content 'Editar'
        expect(page).to have_content 'Desativar'
    end
end

