require 'rails_helper'

describe 'Usuario vê a lista de veículos' do
    it 'com sucesso' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                                                        max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password')
        vehicle_1 = Vehicle.create!(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5', 
                                    manufacture_year: '2015', transportation_modal:transportation_modal, status: :active)
        vehicle_2 = Vehicle.create!(license_plate: 'HHDU-8946', model: 'GTS', brand: 'Shimano', max_weight: '7', 
            manufacture_year: '2017', transportation_modal:transportation_modal, status: :active)

        # Act
        login_as user 
        visit root_path
        click_on 'Veículos'

        #Assert
        expect(current_path).to eq vehicles_path
        expect(page).to have_content 'Bicicleta'
        expect(page).to have_content 'HUIK-5232'
        expect(page).to have_content 'HHDU-8946'
        expect(page).to have_content 'City Tour'
        expect(page).to have_content 'Caloi'
        expect(page).to have_content '2015'
        expect(page).to have_content 'ATIVO'
        expect(page).not_to have_content 'OPERANDO'
        expect(page).to have_content '5kg'
    end

    it 'após iniciar uma ordem de serviço' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password')
        vehicle_1 = Vehicle.create!(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5', 
        manufacture_year: '2015', transportation_modal:transportation_modal, status: :active)
        vehicle_2 = Vehicle.create!(license_plate: 'HHDU-8946', model: 'GTS', brand: 'Shimano', max_weight: '7', 
            manufacture_year: '2017', transportation_modal:transportation_modal, status: :active)
        service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP', 
        product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50, 
        recipient_name: 'Maria Carvalho', recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP', 
        recipient_phone: '019985463251', distance: 7, delivery_time: nil, status: :pending,total_cost:nil)
        Cost.create!(category: :distance, minimum:5, maximum:40,unit_price:3, transportation_modal:transportation_modal)
        Cost.create!(category: :weight, minimum:0,maximum:10,unit_price:5, transportation_modal:transportation_modal) 
        Timescale.create!(min_distance:0,max_distance:40,deadline:24,transportation_modal:transportation_modal)

        # Act
        login_as user
        visit root_path
        click_on 'Ordens de Serviço'
        click_on service_order.code
        click_on 'Escolher'
        click_on 'Veículos'

        #Assert
        expect(page).to have_content 'OPERANDO'
        expect(page).to have_content 'ATIVO'
    end
end
