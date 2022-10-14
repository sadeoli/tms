require 'rails_helper'

describe 'Usuário vê detalhes de uma modalidade de transporte' do
    it 'e é usuário regular' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password')
        vehicle = Vehicle.create!(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5', 
        manufacture_year: '2015', transportation_modal:transportation_modal, status: :active)


        # Act
        login_as user 
        visit root_path
        click_on 'Veículos'

        # Assert
        expect(page).not_to have_content 'Editar'
        expect(page).not_to have_content 'Cadastrar'
    end

    it 'e é usuário administrador' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                    max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        vehicle = Vehicle.create!(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5', 
                        manufacture_year: '2015', transportation_modal:transportation_modal, status: :active)
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)

        # Act
        login_as user 
        visit root_path
        click_on 'Veículos'

        # Assert
        expect(page).to have_content 'Editar'
        expect(page).to have_content 'Cadastrar'
    end
end

