require 'rails_helper'

describe 'Usuário edita uma modalidade de transporte' do
    it 'e é regular' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :regular)
        
        # Act
        login_as(user)
        patch(transportation_modal_path(transportation_modal.id), params: { transportation_modal: { flat_rate: 2}})

        # Assert
        expect(response).to redirect_to root_path
    end

    it 'e é administrador' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)
        
        # Act
        login_as(user)
        patch(transportation_modal_path(transportation_modal.id), params: { transportation_modal: { flat_rate: 2}})

        # Assert
        expect(response).not_to redirect_to root_path
    end

    it 'e é visitante' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        
        # Act
        patch(transportation_modal_path(transportation_modal.id), params: { transportation_modal: { flat_rate: 2}})

        # Assert
        expect(response).to redirect_to user_session_path
    end
end