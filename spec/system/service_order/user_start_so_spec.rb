# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário inicia uma ordem de serviço' do
  it 'e vê detalhes' do
    # Arrange
    transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                       max_weight: 8, min_weight: 0, flat_rate: 5,
                                                       status: :active)
    user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password')
    Vehicle.create!(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5',
                    manufacture_year: '2015', transportation_modal:, status: :active)
    service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP',
                                         product_code: 'CX124060', weight: 5, width: 20, height: 40,
                                         depth: 50,
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
    click_on 'Escolher'

    # Assert
    expect(page).to have_content 'Ordem de serviço iniciada.'
    expect(page).to have_content 'R$ 43,00'
    expect(page).to have_content '24 horas'
    expect(page).not_to have_content 'PENDENTE'
    expect(page).to have_content 'EM ENTREGA'
  end

  it 'e encerra no prazo' do
    # Arrange
    transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                       max_weight: 8, min_weight: 0, flat_rate: 5,
                                                       status: :active)
    user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password')
    Vehicle.create!(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5',
                    manufacture_year: '2015', transportation_modal:, status: :active)
    service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP',
                                         product_code: 'CX124060', weight: 5, width: 20, height: 40,
                                         depth: 50,
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
    click_on 'Escolher'
    click_on 'Encerrar'

    # Assert
    expect(page).not_to have_content 'PENDENTE'
    expect(page).not_to have_content 'EM ENTREGA'
    expect(page).to have_content 'ENTREGUE NO PRAZO'
  end
end
