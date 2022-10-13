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
        recipient_phone: '019985463251', distance: 7, delivery_time: nil, status: :pending,total_cost:nil)
        Cost.create!(category: :distance, minimum:5, maximum:40,unit_price:3, transportation_modal:transportation_modal)
        Cost.create!(category: :weight, minimum:0,maximum:10,unit_price:5, transportation_modal:transportation_modal)
        Timescale.create!(min_distance:0,max_distance:40,deadline:24,transportation_modal:transportation_modal)
        Cost.create!(category: :distance, minimum:5, maximum:40,unit_price:3, transportation_modal:transportation_modal2)
        Cost.create!(category: :weight, minimum:0,maximum:10,unit_price:5, transportation_modal:transportation_modal2)
        Timescale.create!(min_distance:0,max_distance:40,deadline:24,transportation_modal:transportation_modal2)
        
        # Act
        login_as user 
        visit root_path
        click_on 'Ordens de Serviço'
        click_on service_order.code

        # Assert
        expect(page).not_to have_content 'Bicicleta'
        expect(page).to have_content 'Motocicleta'
    end
end
