# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário edita uma configuração de prazo' do
  it 'com sucesso' do
    # Arrange
    user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)
    transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                       max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
    Timescale.create!(min_distance: 2, max_distance: 8, deadline: 24, transportation_modal:)

    # Act
    login_as user
    visit root_path
    click_on 'Modalidade de Transporte'
    click_on 'Bicicleta'
    click_on 'Editar'
    fill_in 'Distância Mínima', with: '1'
    fill_in 'Distância Máxima', with: '9'
    fill_in 'Prazo', with: '48'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content '1km'
    expect(page).to have_content '9km'
    expect(page).to have_content '48h'
  end

  it 'e mantém os campos obrigatórios' do
    # Arrange
    user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)
    transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                       max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
    Timescale.create!(min_distance: 2, max_distance: 8, deadline: 24, transportation_modal:)

    # Act
    login_as user
    visit root_path
    click_on 'Modalidade de Transporte'
    click_on 'Bicicleta'
    click_on 'Editar'
    fill_in 'Distância Mínima', with: ''
    fill_in 'Distância Máxima', with: ''
    fill_in 'Prazo', with: ''
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content 'Não foi possível atualizar o prazo.'
  end
end
