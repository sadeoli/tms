require 'rails_helper'

describe 'Usuario vê a lista de ordens de serviço' do
    it 'com sucesso' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                                                        max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password')
        vehicle = Vehicle.create!(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5', 
                                    manufacture_year: '2015', transportation_modal:transportation_modal, status: :active)
        service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP', 
                                            product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50, 
                                            recipient_name: 'Maria Carvalho', recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP', 
                                            recipient_phone: '019985463251', distance: 7, delivery_time: nil, status: :pending,total_cost:nil)

        # Act
        login_as user 
        visit root_path
        click_on 'Ordens de Serviço'

        # Assert
        expect(page).to have_content service_order.code
        expect(page).to have_content '5kg'
        expect(page).to have_content '20x50x40cm'
        expect(page).to have_content '7km'
    end
end