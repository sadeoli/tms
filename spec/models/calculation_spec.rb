# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Calculation do
  context 'weight_cost' do
    it 'return unit_price when weight cost meets the service order' do
      # Arrange
      transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                         max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
      service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP',
                                           product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50,
                                           recipient_name: 'Maria Carvalho',
                                           recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP',
                                           recipient_phone: '019985463251', distance: 7, delivery_time: nil,
                                           status: :pending, total_cost: nil)
      Cost.create!(category: :weight, minimum: 0, maximum: 8, unit_price: 5,
                   transportation_modal:)
      calculation = described_class.create!(transportation_modal:, service_order:)

      # Act
      result = calculation.weight_cost

      # Assert
      expect(result).to eq 5
    end

    it 'return nil when weight cost does not meet the service order' do
      # Arrange
      transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                         max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
      service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP',
                                           product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50,
                                           recipient_name: 'Maria Carvalho',
                                           recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP',
                                           recipient_phone: '019985463251', distance: 7, delivery_time: nil,
                                           status: :pending, total_cost: nil)
      Cost.create!(category: :weight, minimum: 6, maximum: 8, unit_price: 5,
                   transportation_modal:)
      calculation = described_class.create!(transportation_modal:, service_order:)

      # Act
      result = calculation.weight_cost

      # Assert
      expect(result).to be_nil
    end
  end

  context 'distance_cost' do
    it 'return unit_price when distance cost meets the service order' do
      # Arrange
      transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                         max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
      service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP',
                                           product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50,
                                           recipient_name: 'Maria Carvalho',
                                           recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP',
                                           recipient_phone: '019985463251', distance: 7, delivery_time: nil,
                                           status: :pending, total_cost: nil)
      Cost.create!(category: :distance, minimum: 5, maximum: 10, unit_price: 3,
                   transportation_modal:)
      calculation = described_class.create!(transportation_modal:, service_order:)

      # Act
      result = calculation.distance_cost

      # Assert
      expect(result).to eq 3
    end

    it 'return nil when distance cost does not meet the service order' do
      # Arrange
      transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                         max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
      service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP',
                                           product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50,
                                           recipient_name: 'Maria Carvalho',
                                           recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP',
                                           recipient_phone: '019985463251', distance: 7, delivery_time: nil,
                                           status: :pending, total_cost: nil)
      Cost.create!(category: :distance, minimum: 8, maximum: 10, unit_price: 3,
                   transportation_modal:)
      calculation = described_class.create!(transportation_modal:, service_order:)

      # Act
      result = calculation.distance_cost

      # Assert
      expect(result).to be_nil
    end
  end

  context 'time' do
    it 'return deadline when timescale meets the service order' do
      # Arrange
      transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                         max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
      service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP',
                                           product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50,
                                           recipient_name: 'Maria Carvalho',
                                           recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP',
                                           recipient_phone: '019985463251', distance: 7, delivery_time: nil,
                                           status: :pending, total_cost: nil)
      Timescale.create!(min_distance: 1, max_distance: 10, deadline: 24, transportation_modal:)
      calculation = described_class.create!(transportation_modal:, service_order:)

      # Act
      result = calculation.time

      # Assert
      expect(result).to eq 24
    end

    it 'return nil when timescale does not meet the service order' do
      # Arrange
      transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                         max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
      service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP',
                                           product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50,
                                           recipient_name: 'Maria Carvalho',
                                           recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP',
                                           recipient_phone: '019985463251', distance: 7, delivery_time: nil,
                                           status: :pending, total_cost: nil)
      Timescale.create!(min_distance: 8, max_distance: 10, deadline: 24,
                        transportation_modal:)
      calculation = described_class.create!(transportation_modal:, service_order:)

      # Act
      result = calculation.time

      # Assert
      expect(result).to be_nil
    end
  end

  context 'result' do
    it 'return calculated cost and time when it meets the service order' do
      # Arrange
      transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                         max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
      service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP',
                                           product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50,
                                           recipient_name: 'Maria Carvalho',
                                           recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP',
                                           recipient_phone: '019985463251', distance: 7, delivery_time: nil,
                                           status: :pending, total_cost: nil)
      Timescale.create!(min_distance: 1, max_distance: 10, deadline: 24, transportation_modal:)
      Cost.create!(category: :distance, minimum: 5, maximum: 10, unit_price: 3,
                   transportation_modal:)
      Cost.create!(category: :weight, minimum: 0, maximum: 8, unit_price: 5,
                   transportation_modal:)
      calculation = described_class.create!(transportation_modal:, service_order:)

      # Act
      time_result = calculation.result[:time]
      cost_result = calculation.result[:cost]

      # Assert
      expect(time_result).to eq 24
      expect(cost_result).to eq 43
    end

    it 'return nil when timescale does not meet the service order' do
      # Arrange
      transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                         max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
      service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP',
                                           product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50,
                                           recipient_name: 'Maria Carvalho',
                                           recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP',
                                           recipient_phone: '019985463251', distance: 7, delivery_time: nil,
                                           status: :pending, total_cost: nil)
      Cost.create!(category: :distance, minimum: 5, maximum: 10, unit_price: 3,
                   transportation_modal:)
      Cost.create!(category: :weight, minimum: 0, maximum: 8, unit_price: 5,
                   transportation_modal:)
      calculation = described_class.create!(transportation_modal:, service_order:)

      # Act
      result = calculation.result

      # Assert
      expect(result).to be_nil
    end

    it 'return nil when cost does not meet the service order' do
      # Arrange
      transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                         max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
      service_order = ServiceOrder.create!(pickup_address: 'Rua das Amoras, 52 - Campinas/SP',
                                           product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50,
                                           recipient_name: 'Maria Carvalho',
                                           recipient_address: 'Rua das Laranjeiras, 15 - Campinas/SP',
                                           recipient_phone: '019985463251', distance: 7, delivery_time: nil,
                                           status: :pending, total_cost: nil)
      Timescale.create!(min_distance: 1, max_distance: 10, deadline: 24,
                        transportation_modal:)
      calculation = described_class.create!(transportation_modal:, service_order:)

      # Act
      result = calculation.result

      # Assert
      expect(result).to be_nil
    end
  end
end
