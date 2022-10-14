require 'rails_helper'

describe 'Usuario edita um veículo' do
    it 'com sucesso' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                                                        max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)
        vehicle = Vehicle.create!(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5', 
            manufacture_year: '2015', transportation_modal:transportation_modal, status: :maintenance)
            

        # Act
        login_as user 
        visit root_path
        click_on 'Veículos'
        click_on 'Editar'
        fill_in 'Peso Máximo de Carga', with: '7'
        select 'Ativo', from: 'Status'
        click_on 'Cadastrar'

        # Assert
        expect(page).to have_content 'Veículo atualizado com sucesso.'
        expect(page).to have_content 'Bicicleta'
        expect(page).to have_content 'HUIK-5232'
        expect(page).to have_content 'City Tour'
        expect(page).to have_content '7kg'
        expect(page).to have_content '2015'
        expect(page).to have_content 'ATIVO'
    end

    it 'e mantém os campos obrigatórios' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                                                        max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)
        vehicle = Vehicle.create!(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5', 
            manufacture_year: '2015', transportation_modal:transportation_modal, status: :active)

        # Act
        login_as user 
        visit root_path
        click_on 'Veículos'
        click_on 'Editar'
        fill_in 'Placa de Identificação', with: ''
        fill_in 'Modelo', with: ''
        fill_in 'Marca', with: ''
        fill_in 'Ano de Fabricação', with: ''
        fill_in 'Peso Máximo de Carga', with: ''
        click_on 'Cadastrar'

        # Assert
        expect(page).to have_content 'Não foi possível atualizar o veículo.'
    end
end