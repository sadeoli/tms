require 'rails_helper'

describe 'Usuário cadastra uma configuração de preço' do
    it 'por peso' do
        # Arrange
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)
        TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1, max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)

        # Act
        login_as user 
        visit root_path
        click_on 'Modalidade de Transporte'
        click_on 'Bicicleta'
        click_on 'Configurar preço'
        select 'Peso (kg)', from: 'Categoria'
        fill_in 'Máximo', with: '8'
        fill_in 'Mínimo', with: '0'
        fill_in 'Preço', with: '50'
        click_on 'Cadastrar'

        # Assert
        expect(page).to have_content 'Preço cadastrado com sucesso.'
        expect(page).to have_content 'Peso'
        expect(page).to have_content '8kg'
        expect(page).to have_content '0kg'
        expect(page).to have_content 'R$ 50,00' 
    end

    it 'por distância' do
        # Arrange
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)
        TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1, max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)

        # Act
        login_as user 
        visit root_path
        click_on 'Modalidade de Transporte'
        click_on 'Bicicleta'
        click_on 'Configurar preço'
        select 'Distância (km)', from: 'Categoria'
        fill_in 'Máximo', with: '5'
        fill_in 'Mínimo', with: '40'
        fill_in 'Preço', with: '30'
        click_on 'Cadastrar'

        # Assert
        expect(page).to have_content 'Preço cadastrado com sucesso.'
        expect(page).to have_content 'Distância'
        expect(page).to have_content '40km'
        expect(page).to have_content '5km'
        expect(page).to have_content 'R$ 30,00'       
    end

    it 'e mantém os campos obrigatórios' do
        # Arrange
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)
        TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1, max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)

        # Act
        login_as user 
        visit root_path
        click_on 'Modalidade de Transporte'
        click_on 'Bicicleta'
        click_on 'Configurar preço'
        fill_in 'Máximo', with: ''
        fill_in 'Mínimo', with: ''
        fill_in 'Preço', with: ''
        click_on 'Cadastrar'

        # Assert
        expect(page).to have_content 'Preço não cadastrado.'
    end
end