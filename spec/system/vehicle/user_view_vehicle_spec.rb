require 'rails_helper'

describe 'Usuario vê a lista de veículos' do
    it 'com sucesso' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                                                        max_weight: 8, min_weight: 0, flat_rate: 5, status: :ativo)
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password')
        vehicle_1 = Vehicle.create!(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5', 
                                    manufacture_year: '2015', transportation_modal:transportation_modal, status: :ativo)
        vehicle_2 = Vehicle.create!(license_plate: 'HHDU-8946', model: 'GTS', brand: 'Shimano', max_weight: '7', 
            manufacture_year: '2017', transportation_modal:transportation_modal, status: :operando)

        # Act
        login_as user 
        visit root_path
        click_on 'Veículos'

        #Assert
        expect(current_path).to eq vehicles_path
        expect(page).to have_content 'Bicicleta'
        expect(page).to have_content 'HUIK-5232'
        expect(page).to have_content 'HHDU-8946'
        expect(page).to have_content 'City Tour'
        expect(page).to have_content 'Caloi'
        expect(page).to have_content '2015'
        expect(page).to have_content 'ATIVO'
        expect(page).to have_content 'OPERANDO'
        expect(page).to have_content '5kg'
    end
end
