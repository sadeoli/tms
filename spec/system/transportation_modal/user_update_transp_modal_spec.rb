# frozen_string_literal: true

require 'rails_helper'

describe 'Usuario edita uma modalidade de transporte' do
  it 'com sucesso' do
    # Arrange
    TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
    user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)

    # Act
    login_as user
    visit root_path
    click_on 'Modalidade de Transporte'
    click_on 'Bicicleta'
    click_on 'Editar'
    fill_in 'Taxa Fixa', with: '8'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content 'R$ 8,00'
    expect(page).not_to have_content 'R$ 5,00'
  end

  it 'e mantém os campos obrigatórios' do
    # Arrange
    TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
    user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)

    # Act
    login_as user
    visit root_path
    click_on 'Modalidade de Transporte'
    click_on 'Bicicleta'
    click_on 'Editar'
    fill_in 'Taxa Fixa', with: ''
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content 'Não foi possível atualizar a modalidade de transporte.'
  end

  it 'e desativa' do
    # Arrange
    TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
    TransportationModal.create!(name: 'Motocicleta', max_distance: 100, min_distance: 11,
                                max_weight: 20, min_weight: 0, flat_rate: 15, status: :active)
    user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)

    # Act
    login_as user
    visit root_path
    click_on 'Modalidade de Transporte'
    click_on 'Bicicleta'
    click_on 'Desativar'

    # Assert
    expect(page).to have_content 'Status INATIVO'
    expect(page).to have_content 'Bicicleta'
  end
end
