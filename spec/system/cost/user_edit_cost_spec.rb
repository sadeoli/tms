require 'rails_helper'

describe 'Usuário edita uma configuração de preço' do
    it 'por peso' do
        # Arrange
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        Cost.create!(category: :weight, minimum:2,maximum:7,unit_price:50, transportation_modal:transportation_modal)


        # Act
        login_as user 
        visit root_path
        click_on 'Modalidade de Transporte'
        click_on 'Bicicleta'
        click_on 'Editar'
        fill_in 'Mínimo', with: '0'
        fill_in 'Máximo', with: '8'
        fill_in 'Preço Unitário', with: '8'
        click_on 'Cadastrar'

        # Assert
        expect(page).to have_content 'Preço atualizado com sucesso.'
        expect(page).to have_content 'Peso'
        expect(page).to have_content '8kg'
        expect(page).to have_content '0kg'
        expect(page).to have_content 'R$ 8,00' 
    end

    it 'por distância' do
        # Arrange
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        Cost.create!(category: :distance, minimum:5, maximum:6,unit_price:30, transportation_modal:transportation_modal)


        # Act
        login_as user 
        visit root_path
        click_on 'Modalidade de Transporte'
        click_on 'Bicicleta'
        click_on 'Editar'
        fill_in 'Mínimo', with: '1'
        fill_in 'Máximo', with: '7'
        fill_in 'Preço Unitário', with: '10'
        click_on 'Cadastrar'

        # Assert
        expect(page).to have_content 'Preço atualizado com sucesso.'
        expect(page).to have_content 'Peso'
        expect(page).to have_content '0km'
        expect(page).to have_content '7km'
        expect(page).to have_content 'R$ 10,00' 
    end
end