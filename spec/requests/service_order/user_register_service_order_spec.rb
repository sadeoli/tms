# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário cria uma ordem de serviço' do
  context 'new' do
    it 'e é regular' do
      # Arrange
      user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :regular)

      # Act
      login_as(user)
      get(new_service_order_path)

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
      get(new_service_order_path)

      # Assert
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end

    it 'e é visitante' do
      # Arrange

      # Act
      get(new_service_order_path)

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
      post(service_orders_path, params: { service_order: { pickup_address: 'Rua das Amoras, 52 - Campinas/SP',
                                                           product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50,
                                                           recipient_name: 'Maria Carvalho', recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP',
                                                           recipient_phone: '019985463251', distance: 7 } })

      # Assert
      expect(response).to redirect_to root_path
    end

    it 'e é administrador' do
      # Arrange
      user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)

      # Act
      login_as(user)
      post(service_orders_path, params: { service_order: { pickup_address: 'Rua das Amoras, 52 - Campinas/SP',
                                                           product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50,
                                                           recipient_name: 'Maria Carvalho', recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP',
                                                           recipient_phone: '019985463251', distance: 7 } })

      # Assert
      expect(response).not_to redirect_to root_path
      expect(response).to redirect_to service_orders_path
    end

    it 'e é visitante' do
      # Arrange

      # Act
      post(service_orders_path, params: { service_order: { pickup_address: 'Rua das Amoras, 52 - Campinas/SP',
                                                           product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50,
                                                           recipient_name: 'Maria Carvalho', recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP',
                                                           recipient_phone: '019985463251', distance: 7 } })

      # Assert
      expect(response).to redirect_to user_session_path
    end
  end
end
