# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário cria um veículo' do
  context 'new' do
    it 'e é regular' do
      # Arrange
      user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :regular)

      # Act
      login_as(user)
      get(new_transportation_modal_path)

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
      get(new_transportation_modal_path)

      # Assert
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end

    it 'e é visitante' do
      # Arrange

      # Act
      get(new_transportation_modal_path)

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

      # Act
      login_as(user)
      post(transportation_modals_path, params: { transportation_modal: { name: 'Bicicleta', max_distance: 10,
                                                                         min_distance: 1, max_weight: 8,
                                                                         min_weight: 0, flat_rate: 5,
                                                                         status: :active } })

      # Assert
      expect(response).to redirect_to root_path
    end

    it 'e é administrador' do
      # Arrange
      user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)

      # Act
      login_as(user)
      post(transportation_modals_path, params: { transportation_modal: { name: 'Bicicleta', max_distance: 10,
                                                                         min_distance: 1, max_weight: 8,
                                                                         min_weight: 0, flat_rate: 5,
                                                                         status: :active } })

      # Assert
      expect(response).not_to redirect_to root_path
      expect(response).to redirect_to transportation_modals_path
    end

    it 'e é visitante' do
      # Arrange

      # Act
      post(transportation_modals_path, params: { transportation_modal: { name: 'Bicicleta', max_distance: 10,
                                                                         min_distance: 1, max_weight: 8,
                                                                         min_weight: 0, flat_rate: 5,
                                                                         status: :active } })

      # Assert
      expect(response).to redirect_to user_session_path
    end
  end
end
