# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário vê o resultado da calculadora' do
  it 'e vê custos dentro de uma ordem de serviço' do
    # Arrange
    transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                       max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
    user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password')
    service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP',
                                         product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50,
                                         recipient_name: 'Maria Carvalho',
                                         recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP',
                                         recipient_phone: '019985463251', distance: 7, delivery_time: nil,
                                         status: :pending, total_cost: nil)
    Cost.create!(category: :distance, minimum: 5, maximum: 10, unit_price: 3,
                 transportation_modal:)
    Cost.create!(category: :weight, minimum: 0, maximum: 8, unit_price: 5, transportation_modal:)
    Timescale.create!(min_distance: 1, max_distance: 10, deadline: 24, transportation_modal:)

    # Act
    login_as user
    visit root_path
    click_on 'Ordens de Serviço'
    click_on service_order.code

    # Assert
    expect(page).to have_content 'Bicicleta'
    expect(page).to have_content 'R$ 43,00'
  end

  it 'e não há modalidade que atende' do
    # Arrange
    transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                       max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
    user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password')
    service_order = ServiceOrder.create!(pickup_address: 'Rua Senado, 52 - Vitória/ES', product_code: 'PPS524060',
                                         weight: 25, width: 20, height: 40, depth: 50,
                                         recipient_name: 'Jose Almeida',
                                         recipient_address: 'Rua das Araras, 15 - Serra/ES',
                                         recipient_phone: '019985463251', distance: 40, delivery_time: nil,
                                         status: :pending, total_cost: nil)
    Cost.create!(category: :distance, minimum: 5, maximum: 10, unit_price: 3,
                 transportation_modal:)
    Cost.create!(category: :weight, minimum: 0, maximum: 8, unit_price: 5,
                 transportation_modal:)

    # Act
    login_as user
    visit root_path
    click_on 'Ordens de Serviço'
    click_on service_order.code

    # Assert
    expect(page).not_to have_content 'Bicicleta'
    expect(page).not_to have_content 'R$ 43,00'
  end

  it 'e vê prazos dentro de uma ordem de serviço' do
    # Arrange
    transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                       max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
    user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password')
    service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP',
                                         product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50,
                                         recipient_name: 'Maria Carvalho',
                                         recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP',
                                         recipient_phone: '019985463251', distance: 7, delivery_time: nil,
                                         status: :pending, total_cost: nil)
    Cost.create!(category: :distance, minimum: 5, maximum: 10, unit_price: 3,
                 transportation_modal:)
    Cost.create!(category: :weight, minimum: 0, maximum: 8, unit_price: 5,
                 transportation_modal:)
    Timescale.create!(min_distance: 1, max_distance: 10, deadline: 24, transportation_modal:)

    # Act
    login_as user
    visit root_path
    click_on 'Ordens de Serviço'
    click_on service_order.code

    # Assert
    expect(page).to have_content 'Bicicleta'
    expect(page).to have_content '24h'
  end
end
