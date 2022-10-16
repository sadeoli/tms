require 'rails_helper'

describe 'Usuário busca por um pedido' do
    it 'e encontra um pedido' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
            max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        vehicle = Vehicle.create!(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5', 
        manufacture_year: '2015', transportation_modal:transportation_modal, status: :working)
        service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP', 
        product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50, 
        recipient_name: 'Maria Carvalho', recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP', 
        recipient_phone: '019985463251', distance: 7, delivery_time: 24, status: :intransit, vehicle:vehicle)

        # Act
        visit root_path
        fill_in 'Código de Rastreamento', with: service_order.code
        click_on 'Consultar'

        # Assert
        expect(page).to have_content service_order.code
        expect(page).to have_content 'Rua das Amoras, 52 - Campinas/SP'
        expect(page).to have_content 'Rua das Laranjeiras, 15 - Campinas/SP'
        expect(page).to have_content '24 horas'
        expect(page).to have_content 'Bicicleta'
    end

    it 'e não encontra um pedido' do
        # Arrange

        # Act
        visit root_path
        fill_in 'Código de Rastreamento', with: 'HDYS558'
        click_on 'Consultar'

        # Assert
        expect(page).to have_content 'Não foi possível encontrar o pedido.'

    end
end