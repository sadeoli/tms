require 'rails_helper'

RSpec.describe ServiceOrder, type: :model do
    describe 'gera um código aleatório' do
        it 'ao criar nova ordem de serviço' do
            # Arrange 
            transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
            service_order = ServiceOrder.new(pickup_address: 'Rua das Amoras, 52 - Campinas/SP', 
            product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50, 
            recipient_name: 'Maria Carvalho', recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP', 
            recipient_phone: '019985463251', distance: 7, delivery_time: nil, status: :pending ,total_cost:nil)

            # Act
            service_order.save!
            result = service_order.code

            # Assert
            expect(result).not_to be_empty
            expect(result.length).to eq 15
        end

        it 'e o código é único' do
            # Arrange
            transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
            service_order = ServiceOrder.new(pickup_address: 'Rua das Amoras, 52 - Campinas/SP', 
            product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50, 
            recipient_name: 'Maria Carvalho', recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP', 
            recipient_phone: '019985463251', distance: 7, delivery_time: nil, status: :pending ,total_cost:nil)
            other_service_order = ServiceOrder.create!(pickup_address: 'R. França, 539 - Jardim Europa, São Paulo - SP, 01446-010',
            product_code: 'CX752169', weight: 15, width: 50, height: 70, depth:70, recipient_name: 'Francisco Quintal', 
            recipient_address: 'R. Sebastião Walter Fusco, 309 - Cidade Soinco, Guarulhos - SP, 07182-230', 
            recipient_phone: '011987523648', distance: 30)

            # Act
            service_order.save!

            # Assert
            expect(other_service_order.code).not_to eq service_order.code
        end

        it 'e não deve ser modificado' do
            # Arrange 
            transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
            service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP', 
            product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50, 
            recipient_name: 'Maria Carvalho', recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP', 
            recipient_phone: '019985463251', distance: 7, delivery_time: nil, status: :pending ,total_cost:nil)
            original_code = service_order.code    

            # Act
            service_order.update!(distance: 5)

            # Assert
            expect(service_order.code).to eq original_code
            
        end
    end

    describe 'calculate' do
        it 'cria um cálculo vinculado à ordem de serviço' do
            # Arrange 
            transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
            service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP', 
            product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50, 
            recipient_name: 'Maria Carvalho', recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP', 
            recipient_phone: '019985463251', distance: 7)
            Cost.create!(category: :distance, minimum:5, maximum:10,unit_price:3, transportation_modal:transportation_modal)
            Cost.create!(category: :weight, minimum:0,maximum:8,unit_price:5, transportation_modal:transportation_modal)
            Timescale.create!(min_distance:1,max_distance:10,deadline:24,transportation_modal:transportation_modal)

            # Act
            service_order.calculate
            result = Calculation.where(service_order:service_order,transportation_modal:transportation_modal).count

            # Assert
            expect(result).to eq 1
        end

        it 'não um cálculo caso não haja modalidade ativa' do
            # Arrange 
            transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                max_weight: 8, min_weight: 0, flat_rate: 5, status: :inactive)
            service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP', 
            product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50, 
            recipient_name: 'Maria Carvalho', recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP', 
            recipient_phone: '019985463251', distance: 7)
            Cost.create!(category: :distance, minimum:5, maximum:10,unit_price:3, transportation_modal:transportation_modal)
            Cost.create!(category: :weight, minimum:0,maximum:8,unit_price:5, transportation_modal:transportation_modal)
            Timescale.create!(min_distance:1,max_distance:10,deadline:24,transportation_modal:transportation_modal)

            # Act
            service_order.calculate
            result = Calculation.where(service_order:service_order,transportation_modal:transportation_modal).count

            # Assert
            expect(result).to eq 0
        end
    end

    describe 'close' do
        it 'atualiza status para entregue no prazo' do            
        end
    end
end
