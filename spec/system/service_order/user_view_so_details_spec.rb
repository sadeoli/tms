require 'rails_helper'

describe 'Usuário vê uma ordem de serviço' do
    it 'e não vê modalidades desativadas' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :inactive)
        transportation_modal2 = TransportationModal.create!(name: 'Motocicleta', max_distance: 100 , min_distance: 11,
                max_weight: 20, min_weight: 0, flat_rate: 15, status: :active)
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password')
        service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP', 
        product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50, 
        recipient_name: 'Maria Carvalho', recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP', 
        recipient_phone: '019985463251', distance: 12, delivery_time: nil, status: :pending,total_cost:nil)
        Cost.create!(category: :distance, minimum:5, maximum:10,unit_price:3, transportation_modal:transportation_modal)
        Cost.create!(category: :weight, minimum:0,maximum:8,unit_price:5, transportation_modal:transportation_modal)
        Timescale.create!(min_distance:1,max_distance:10,deadline:24,transportation_modal:transportation_modal)
        Cost.create!(category: :distance, minimum:11, maximum:15,unit_price:3, transportation_modal:transportation_modal2)
        Cost.create!(category: :weight, minimum:0,maximum:8,unit_price:5, transportation_modal:transportation_modal2)
        Timescale.create!(min_distance:11,max_distance:40,deadline:24,transportation_modal:transportation_modal2)
        
        # Act
        login_as user 
        visit root_path
        click_on 'Ordens de Serviço'
        click_on service_order.code

        # Assert
        expect(page).not_to have_content 'Bicicleta'
        expect(page).to have_content 'Motocicleta'
    end

    it 'e vê quantidade de veículos ativos' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        vehicle_1 = Vehicle.create!(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5', 
                    manufacture_year: '2015', transportation_modal:transportation_modal, status: :active)
        vehicle_2 = Vehicle.create!(license_plate: 'HHDU-8946', model: 'GTS', brand: 'Shimano', max_weight: '7', 
                        manufacture_year: '2017', transportation_modal:transportation_modal, status: :active)
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password')
        service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP', 
        product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50, 
        recipient_name: 'Maria Carvalho', recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP', 
        recipient_phone: '019985463251', distance: 7, delivery_time: nil, status: :pending,total_cost:nil)
        Cost.create!(category: :distance, minimum:5, maximum:10,unit_price:3, transportation_modal:transportation_modal)
        Cost.create!(category: :weight, minimum:0,maximum:8,unit_price:5, transportation_modal:transportation_modal)
        Timescale.create!(min_distance:1,max_distance:10,deadline:24,transportation_modal:transportation_modal)
        
        # Act
        login_as user 
        visit root_path
        click_on 'Ordens de Serviço'
        click_on service_order.code

        # Assert
        expect(page).to have_content 'Disponibilidade'
        expect(page).to have_content '2 veículos'
    end
end
