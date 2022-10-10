require 'rails_helper'

describe 'Usuario vê Modalidade de Transporte' do
    it 'a partir do menu' do
        # Arrange
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password')
        
        # Act
        login_as user 
        visit root_path
        click_on 'Modalidade de Transporte'
        

        # Assert
        expect(current_path).to eq transportation_modals_path
    end

    it 'e vê modalidades de transporte cadastradas' do
        # Arrange
        transportation_modal1 = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                    max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        transportation_modal2 = TransportationModal.create!(name: 'Motocicleta', max_distance: 100 , min_distance: 11,
                        max_weight: 20, min_weight: 0, flat_rate: 15, status: :active)
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password')

        # Act
        login_as user 
        visit root_path
        click_on 'Modalidade de Transporte'


        # Assert
        expect(page).to have_content 'Bicicleta'
        expect(page).to have_content 'Motocicleta'
        expect(page).to have_content 'Distância Máxima 10km'
        expect(page).to have_content 'Distância Mínima 1km'
        expect(page).to have_content 'Peso Máximo da Carga 8kg'
        expect(page).to have_content 'Peso Mínimo da Carga 0kg'
        expect(page).to have_content 'Taxa Fixa R$ 5,00'  
    end

end