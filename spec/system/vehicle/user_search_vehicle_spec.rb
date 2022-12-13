# frozen_string_literal: true

require 'rails_helper'

describe 'Usuario busca um veículo' do
  it 'com sucesso' do
    # Arrange
    transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                       max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
    user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password')
    Vehicle.create!(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5',
                    manufacture_year: '2015', transportation_modal:, status: :active)
    Vehicle.create!(license_plate: 'HHDU-8946', model: 'GTS', brand: 'Shimano', max_weight: '7',
                    manufacture_year: '2017', transportation_modal:, status: :active)

    # Act
    login_as user
    visit root_path
    click_on 'Veículos'
    fill_in 'Placa', with: 'HUIK-5232'
    click_on 'Buscar'

    # Assert
    expect(page).to have_content 'Bicicleta'
    expect(page).to have_content 'HUIK-5232'
    expect(page).not_to have_content 'HHDU-8946'
    expect(page).to have_content 'City Tour'
    expect(page).to have_content 'Caloi'
    expect(page).to have_content '2015'
    expect(page).to have_content 'ATIVO'
    expect(page).to have_content '5kg'
  end

  it 'e encontra mais de um veículo' do
    # Arrange
    transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                       max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
    user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password')
    Vehicle.create!(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5',
                    manufacture_year: '2015', transportation_modal:, status: :active)
    Vehicle.create!(license_plate: 'HHDU-8946', model: 'GTS', brand: 'Shimano', max_weight: '7',
                    manufacture_year: '2017', transportation_modal:, status: :active)

    # Act
    login_as user
    visit root_path
    click_on 'Veículos'
    fill_in 'Placa', with: 'H'
    click_on 'Buscar'

    # Assert
    expect(page).to have_content 'Bicicleta'
    expect(page).to have_content 'HUIK-5232'
    expect(page).to have_content 'HHDU-8946'
  end

  it 'e não encontra o veículo' do
    # Arrange
    user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password')

    # Act
    login_as user
    visit root_path
    click_on 'Veículos'
    fill_in 'Placa', with: ''
    click_on 'Buscar'

    # Assert
    expect(page).to have_content 'Não foi possível encontrar o veículo.'
  end
end
