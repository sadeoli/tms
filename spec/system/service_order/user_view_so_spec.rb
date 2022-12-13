# frozen_string_literal: true

require 'rails_helper'

describe 'Usuario vê a lista de ordens de serviço' do
  it 'com sucesso' do
    # Arrange
    user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password')
    service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP',
                                         product_code: 'CX124060', weight: 5, width: 20, height: 40,
                                         depth: 50,
                                         recipient_name: 'Maria Carvalho',
                                         recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP',
                                         recipient_phone: '019985463251', distance: 7, delivery_time: nil,
                                         status: :pending, total_cost: nil)

    # Act
    login_as user
    visit root_path
    click_on 'Ordens de Serviço'

    # Assert
    expect(page).to have_content service_order.code
    expect(page).to have_content '5kg'
    expect(page).to have_content '20x50x40cm'
    expect(page).to have_content '7km'
  end

  it 'e filtra somente pendentes' do
    # Arrange
    user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password')
    service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP',
                                         product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50,
                                         recipient_name: 'Maria Carvalho',
                                         recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP',
                                         recipient_phone: '019985463251', distance: 7, status: :pending)
    other_service_order = ServiceOrder.create!(pickup_address: 'R. Silveira Neto, 144 - Água Verde, Curitiba - PR',
                                               product_code: 'PPS85', weight: 1000, width: 1200,
                                               height: 2000, depth: 1100, recipient_name: 'Izabel Alves',
                                               recipient_address: 'R. Fernão Sales, 16 - Vila Hortência, Sorocaba - SP',
                                               recipient_phone: '015975485638', distance: 300,
                                               status: :intransit)

    # Act
    login_as user
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Pendentes'

    # Assert
    expect(page).to have_content service_order.code
    expect(page).not_to have_content other_service_order.code
    expect(page).to have_content '5kg'
    expect(page).to have_content '20x50x40cm'
    expect(page).to have_content '7km'
  end
end
