# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário cria um veículo' do
  context 'new' do
    it 'e é regular' do
      # Arrange
      user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :regular)

      # Act
      login_as(user)
      get(new_vehicle_path)

      # Assert
      expect(response).not_to be_successful
      expect(response).to redirect_to root_path
      expect(response).not_to render_template(:new)
    end

    it 'e é admin' do
      # Arrange
      user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)

      # Act
      login_as(user)
      get(new_vehicle_path)

      # Assert
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end

    it 'e é visitante' do
      # Arrange

      # Act
      get(new_vehicle_path)

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
      transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                         max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)

      # Act
      login_as(user)
      post(vehicles_path, params: { vehicle: { license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5',
                                               manufacture_year: '2015', transportation_modal:, status: :active } })

      # Assert
      expect(response).to redirect_to root_path
    end

    it 'e é administrador' do
      # Arrange
      user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)
      transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                         max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)

      # Act
      login_as(user)
      post(vehicles_path, params: { vehicle: { license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: 5,
                                               manufacture_year: 2015, transportation_modal_id: transportation_modal[:id], status: :active } })

      # Assert
      expect(response).not_to redirect_to root_path
      expect(response).to redirect_to vehicles_path
    end

    it 'e é visitante' do
      # Arrange
      transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                         max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)

      # Act
      post(vehicles_path, params: { vehicle: { license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5',
                                               manufacture_year: '2015', transportation_modal:, status: :active } })

      # Assert
      expect(response).to redirect_to user_session_path
    end
  end
end
