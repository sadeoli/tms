require 'rails_helper'

describe 'Usuário edita um veículo' do
    it 'e é regular' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        vehicle = Vehicle.create!(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5', 
                manufacture_year: '2015', transportation_modal:transportation_modal, status: :active)
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :regular)
        
        # Act
        login_as(user)
        patch(vehicle_path(vehicle.id), params: { vehicle: { status: :maintenance}})

        # Assert
        expect(response).to redirect_to root_path
    end

    it 'e é administrador' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        vehicle = Vehicle.create!(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5', 
                manufacture_year: '2015', transportation_modal:transportation_modal, status: :active)
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)
        
        # Act
        login_as(user)
        patch(vehicle_path(vehicle.id), params: {vehicle: {status: :maintenance}})

        # Assert
        expect(response).not_to redirect_to root_path
        expect(response).to redirect_to vehicles_path
    end

    it 'e é visitante' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        vehicle = Vehicle.create!(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5', 
                manufacture_year: '2015', transportation_modal:transportation_modal, status: :active)
        
        # Act
        patch(vehicle_path(vehicle.id), params: { vehicle: { status: :maintenance}})

        # Assert
        expect(response).to redirect_to user_session_path
    end
end