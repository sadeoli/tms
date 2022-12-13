# frozen_string_literal: true

require 'rails_helper'

describe 'Usuario edita uma ordem de serviço' do
  it 'com sucesso se está pendente' do
    # Arrange
    user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)
    service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP',
                                         product_code: 'CX124060', weight: 5, width: 20, height: 40,
                                         depth: 50,
                                         recipient_name: 'Maria Carvalho',
                                         recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP',
                                         recipient_phone: '019985463251', distance: 7)

    # Act
    login_as user
    visit root_path
    click_on 'Ordens de Serviço'
    click_on service_order.code
    click_on 'Editar'
    fill_in 'Endereço de Retirada', with: 'R. Iacanga, 49 - Vila Joao Jorge, Campinas - SP, 13041-309'
    fill_in 'Distância', with: '8'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content 'Ordem de serviço atualizada com sucesso.'
    expect(page).to have_content 'R. Iacanga, 49 - Vila Joao Jorge, Campinas - SP, 13041-309'
    expect(page).to have_content '8km'
  end

  it 'sem sucesso se estiver em trânsito' do
    # Arrange
    user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)
    service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP',
                                         product_code: 'CX124060', weight: 5, width: 20, height: 40,
                                         depth: 50,
                                         recipient_name: 'Maria Carvalho',
                                         recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP',
                                         recipient_phone: '019985463251', distance: 7, status: :intransit)

    # Act
    login_as user
    visit root_path
    click_on 'Ordens de Serviço'
    click_on service_order.code

    # Assert
    expect(page).not_to have_content 'Editar'
  end

  it 'sem sucesso se estiver entregue' do
    # Arrange
    user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)
    service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP',
                                         product_code: 'CX124060', weight: 5, width: 20, height: 40,
                                         depth: 50,
                                         recipient_name: 'Maria Carvalho',
                                         recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP',
                                         recipient_phone: '019985463251', distance: 7, status: :delayed)

    # Act
    login_as user
    visit root_path
    click_on 'Ordens de Serviço'
    click_on service_order.code

    # Assert
    expect(page).not_to have_content 'Editar'
  end
end
