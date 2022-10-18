require 'rails_helper'

describe 'Usuário cria uma configuração de preço' do
    context 'new' do
        it 'e é regular' do
            # Arrange
            user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :regular)
            transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)

            # Act
            login_as(user)
            get(new_transportation_modal_cost_path(transportation_modal.id))

            # Assert
            expect(response).not_to be_successful
            expect(response).to redirect_to root_path
            expect(response).not_to render_template(:new)
        end

        it 'e é admin' do
            # Arrange
            user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)
            transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)

            # Act
            login_as(user)
            get(new_transportation_modal_cost_path(transportation_modal.id))

            # Assert
            expect(response).to be_successful
            expect(response).to render_template(:new)
        end

        it 'e é visitante' do
            # Arrange
            transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)

            # Act
            get(new_transportation_modal_cost_path(transportation_modal.id))

            # Assert
            expect(response).not_to be_successful
            expect(response).to redirect_to user_session_path
            expect(response).not_to render_template(:new)
        end

    end

    context 'create' do
        it 'e é regular' do
            # Arrange
            user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :regular)
            transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)


            # Act
            login_as(user)
            post(transportation_modal_costs_path(transportation_modal.id), params: { cost: { category: :distance, minimum:5, maximum:10,unit_price:30, 
                transportation_modal:transportation_modal}})

            # Assert
            expect(response).to redirect_to root_path
        end

        it 'e é administrador' do
            # Arrange
            user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)
            transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)

            # Act
            login_as(user)
            post(transportation_modal_costs_path(transportation_modal.id), params: { cost: { category: :distance, minimum:5, maximum:10,unit_price:30, 
                transportation_modal:transportation_modal}})

            # Assert
            expect(response).not_to redirect_to root_path
            expect(response).to redirect_to transportation_modal
        end

        it 'e é visitante' do
            # Arrange
            transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)

            # Act
            post(transportation_modal_costs_path(transportation_modal.id), params: { cost: { category: :distance, minimum:5, maximum:10,unit_price:30, 
                transportation_modal:transportation_modal}})

            # Assert
            expect(response).to redirect_to user_session_path
        end
    end
end