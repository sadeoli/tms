# frozen_string_literal: true

require 'rails_helper'

describe 'Usuario registra um veículo' do
  it 'com sucesso' do
    # Arrange
    TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
    user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)
    TransportationModal.create!(name: 'Motocicleta', max_distance: 100, min_distance: 11,
                                max_weight: 20, min_weight: 0, flat_rate: 15, status: :active)

    # Act
    login_as user
    visit root_path
    click_on 'Veículos'
    click_on 'Cadastrar'
    select 'Bicicleta', from: 'Modalidade de Transporte'
    fill_in 'Placa de Identificação', with: 'HUIK-5232'
    fill_in 'Modelo', with: 'City Tour'
    fill_in 'Marca', with: 'Caloi'
    fill_in 'Ano de Fabricação', with: '2015'
    fill_in 'Peso Máximo de Carga', with: '8'
    select 'Em manutenção', from: 'Status'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content 'Veículo cadastrado com sucesso.'
    expect(page).to have_content 'Bicicleta'
    expect(page).to have_content 'HUIK-5232'
    expect(page).to have_content 'City Tour'
    expect(page).to have_content 'Caloi'
    expect(page).to have_content '2015'
    expect(page).to have_content 'EM MANUTENÇÃO'
  end

  it 'e mantém os campos obrigatórios' do
    # Arrange
    TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
    user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)
    TransportationModal.create!(name: 'Motocicleta', max_distance: 100, min_distance: 11,
                                max_weight: 20, min_weight: 0, flat_rate: 15, status: :active)

    # Act
    login_as user
    visit root_path
    click_on 'Veículos'
    click_on 'Cadastrar'
    select 'Bicicleta', from: 'Modalidade de Transporte'
    fill_in 'Placa de Identificação', with: ''
    fill_in 'Modelo', with: ''
    fill_in 'Marca', with: ''
    fill_in 'Ano de Fabricação', with: ''
    fill_in 'Peso Máximo de Carga', with: ''
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content 'Veículo não cadastrado.'
  end
end
