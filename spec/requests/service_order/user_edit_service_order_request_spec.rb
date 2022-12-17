# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário edita uma ordem de serviço' do
  it 'e é regular' do
    # Arrange
    service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP',
                                         product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50,
                                         recipient_name: 'Maria Carvalho',
                                         recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP',
                                         recipient_phone: '019985463251', distance: 7)
    user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :regular)

    # Act
    login_as(user)
    patch(service_order_path(service_order.id), params: { service_order: { product_code: 'PLL85469' } })

    # Assert
    expect(response).to redirect_to root_path
  end

  it 'e é administrador' do
    # Arrange
    service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP',
                                         product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50,
                                         recipient_name: 'Maria Carvalho',
                                         recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP',
                                         recipient_phone: '019985463251', distance: 7)
    user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)

    # Act
    login_as(user)
    patch(service_order_path(service_order.id), params: { service_order: { product_code: 'PLL85469' } })

    # Assert
    expect(response).not_to redirect_to root_path
    expect(response).to redirect_to service_order
  end

  it 'e é visitante' do
    # Arrange
    service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP',
                                         product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50,
                                         recipient_name: 'Maria Carvalho',
                                         recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP',
                                         recipient_phone: '019985463251', distance: 7)

    # Act
    patch(service_order_path(service_order.id), params: { service_order: { product_code: 'PLL85469' } })

    # Assert
    expect(response).to redirect_to user_session_path
  end
end
