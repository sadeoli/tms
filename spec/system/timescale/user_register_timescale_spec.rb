# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário cadastra uma configuração de prazo' do
  it 'com sucesso' do
    # Arrange
    user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)
    TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1, max_weight: 8,
                                min_weight: 0, flat_rate: 5, status: :active)

    # Act
    login_as user
    visit root_path
    click_on 'Modalidade de Transporte'
    click_on 'Bicicleta'
    click_on 'Configurar prazo'
    fill_in 'Distância Máxima', with: '8'
    fill_in 'Distância Mínima', with: '2'
    fill_in 'Prazo', with: '24'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content 'Prazo cadastrado com sucesso.'
    expect(page).to have_content '24h'
    expect(page).to have_content '2km'
    expect(page).to have_content '8km'
  end

  it 'e mantém os campos obrigatórios' do
    # Arrange
    user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)
    TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1, max_weight: 8,
                                min_weight: 0, flat_rate: 5, status: :active)

    # Act
    login_as user
    visit root_path
    click_on 'Modalidade de Transporte'
    click_on 'Bicicleta'
    click_on 'Configurar prazo'
    fill_in 'Distância Máxima', with: ''
    fill_in 'Distância Mínima', with: ''
    fill_in 'Prazo', with: ''
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content 'Prazo não cadastrado.'
  end
end
