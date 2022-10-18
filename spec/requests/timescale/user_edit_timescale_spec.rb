require 'rails_helper'

describe 'Usuário edita um prazo' do
    it 'e é regular' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        timescale = Timescale.create!(min_distance:1,max_distance:10,deadline:24,transportation_modal:transportation_modal)
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :regular)
        
        # Act
        login_as(user)
        patch(transportation_modal_timescale_path(transportation_modal.id, timescale.id), params: { timescale: { deadline: 48}})

        # Assert
        expect(response).to redirect_to root_path
    end

    it 'e é administrador' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        timescale = Timescale.create!(min_distance:1,max_distance:10,deadline:24,transportation_modal:transportation_modal)
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)
        
        # Act
        login_as(user)
        patch(transportation_modal_timescale_path(transportation_modal.id, timescale.id), params: { timescale: { deadline: 48}})

        # Assert
        expect(response).not_to redirect_to root_path
        expect(response).to redirect_to transportation_modal
    end

    it 'e é visitante' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        timescale = Timescale.create!(min_distance:1,max_distance:10,deadline:24,transportation_modal:transportation_modal)
        
        # Act
        patch(transportation_modal_timescale_path(transportation_modal.id, timescale.id), params: { timescale: { deadline: 48}})

        # Assert
        expect(response).to redirect_to user_session_path
    end
end