# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário vê detalhes de uma ordem de serviço' do
  it 'e é usuário regular' do
    user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :regular)
    service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP',
                                         product_code: 'CX124060', weight: 5, width: 20, height: 40,
                                         depth: 50, recipient_name: 'Maria Carvalho',
                                         recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP',
                                         recipient_phone: '019985463251', distance: 7)

    # Act
    login_as user
    visit root_path
    click_on 'Ordens de Serviço'
    click_on service_order.code

    # Assert
    expect(page).not_to have_content 'Editar'
  end

  it 'e é usuário administrador' do
    user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)
    service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP',
                                         product_code: 'CX124060', weight: 5, width: 20, height: 40,
                                         depth: 50, recipient_name: 'Maria Carvalho',
                                         recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP',
                                         recipient_phone: '019985463251', distance: 7)

    # Act
    login_as user
    visit root_path
    click_on 'Ordens de Serviço'
    click_on service_order.code

    # Assert
    expect(page).to have_content 'Editar'
  end
end
