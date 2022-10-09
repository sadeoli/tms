require 'rails_helper'

describe 'Usuario edita uma modalidade de transporte' do
    it 'e desativa' do
        # Arrange
        transportation_modal1 = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :ativo)
        transportation_modal2 = TransportationModal.create!(name: 'Motocicleta', max_distance: 100 , min_distance: 11,
                max_weight: 20, min_weight: 0, flat_rate: 15, status: :ativo)
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)

        # Act
        login_as user 
        visit root_path
        click_on 'Modalidade de Transporte'
        click_on 'Bicicleta'
        click_on 'Desativar'


        # Assert
        expect(page).to have_content 'Status INATIVO'
        expect(page).to have_content 'Bicicleta'
    end
end