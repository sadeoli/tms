require 'rails_helper'

describe 'Usuario vê detalhes de uma modalidade de transporte' do
    it 'e seus custos cadastrados' do
        # Arrange
        transportation_modal1 = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                    max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        transportation_modal2 = TransportationModal.create!(name: 'Motocicleta', max_distance: 100 , min_distance: 11,
                        max_weight: 20, min_weight: 0, flat_rate: 15, status: :active)
        Cost.create!(category: :weight, minimum:0,maximum:8,unit_price:50, transportation_modal:transportation_modal1)
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password')

        # Act
        login_as user 
        visit root_path
        click_on 'Modalidade de Transporte'
        click_on 'Bicicleta'


        # Assert
        expect(page).to have_content 'Bicicleta'
        expect(page).to have_content 'Distância Máxima 10km'
        expect(page).to have_content 'Distância Mínima 1km'
        expect(page).to have_content 'Peso Máximo da Carga 8kg'
        expect(page).to have_content 'Peso Mínimo da Carga 0kg'
        expect(page).to have_content 'Taxa Fixa R$ 5,00'  
        expect(page).to have_content '8kg'
        expect(page).to have_content '0kg'
        expect(page).to have_content 'R$ 50,00' 
    end

    it 'e não vê custos de outra modalidade de transporte' do
        # Arrange
        transportation_modal1 = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                    max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        transportation_modal2 = TransportationModal.create!(name: 'Motocicleta', max_distance: 100 , min_distance: 11,
                        max_weight: 20, min_weight: 0, flat_rate: 15, status: :active)
        Cost.create!(category: :weight, minimum:0,maximum:8,unit_price:50, transportation_modal:transportation_modal1)
        Cost.create!(category: :distance, minimum:15,maximum:19,unit_price:30, transportation_modal:transportation_modal2)
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password')

        # Act
        login_as user 
        visit root_path
        click_on 'Modalidade de Transporte'
        click_on 'Bicicleta'


        # Assert
        expect(page).not_to have_content '15km'
        expect(page).not_to have_content '19km'
        expect(page).not_to have_content 'R$ 30,00' 
    end

    it 'e seus prazos' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                    max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password')
        Timescale.create!(min_distance:2,max_distance:8,deadline:24,transportation_modal:transportation_modal)
        

        # Act
        login_as user 
        visit root_path
        click_on 'Modalidade de Transporte'
        click_on 'Bicicleta'


        # Assert
        expect(page).to have_content 'Bicicleta' 
        expect(page).to have_content 'Configuração de Prazo'
        expect(page).to have_content '8km'
        expect(page).to have_content '2km'
        expect(page).to have_content '24h' 
    end
end