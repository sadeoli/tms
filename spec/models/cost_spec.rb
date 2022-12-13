# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cost do
  describe '#valid?' do
    context 'presence' do
      it 'false when category is empty' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        cost = described_class.new(category: nil, minimum: 5, maximum: 10, unit_price: 3,
                                   transportation_modal:)

        # Act
        result = cost.valid?

        # Assert
        expect(result).to be false
      end

      it 'false when minimum is empty' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        cost = described_class.new(category: :distance, minimum: '', maximum: 10, unit_price: 3,
                                   transportation_modal:)

        # Act
        result = cost.valid?

        # Assert
        expect(result).to be false
      end

      it 'false when maximum is empty' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        cost = described_class.new(category: :distance, minimum: 5, maximum: '', unit_price: 3,
                                   transportation_modal:)

        # Act
        result = cost.valid?

        # Assert
        expect(result).to be false
      end

      it 'false when unit_price is empty' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        cost = described_class.new(category: :distance, minimum: 5, maximum: 10, unit_price: '',
                                   transportation_modal:)

        # Act
        result = cost.valid?

        # Assert
        expect(result).to be false
      end
    end

    context 'numericality' do
      it 'false when unit_price is negative' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        cost = described_class.new(category: :weight, minimum: 2, maximum: 7, unit_price: -50,
                                   transportation_modal:)

        # Act
        result = cost.valid?

        # Assert
        expect(result).to be false
      end
    end

    context 'minimum_cannot_be_lower_than_transportation_modal_minimum' do
      it 'false when distance attribute' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        cost = described_class.new(category: :distance, minimum: 0, maximum: 10, unit_price: 3,
                                   transportation_modal:)

        # Act
        result = cost.valid?

        # Assert
        expect(result).to be false
        expect(cost.errors.include?(:minimum)).to be true
      end

      it 'false when weight attribute' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 2, flat_rate: 5, status: :active)
        cost = described_class.new(category: :weight, minimum: 0, maximum: 10, unit_price: 3,
                                   transportation_modal:)

        # Act
        result = cost.valid?

        # Assert
        expect(result).to be false
        expect(cost.errors.include?(:minimum)).to be true
      end
    end

    context 'maximum_cannot_be_greater_than_transportation_modal_maximum' do
      it 'false when distance attribute' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        cost = described_class.new(category: :distance, minimum: 2, maximum: 15, unit_price: 3,
                                   transportation_modal:)

        # Act
        result = cost.valid?

        # Assert
        expect(result).to be false
        expect(cost.errors.include?(:maximum)).to be true
      end

      it 'false when weight attribute' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 2, flat_rate: 5, status: :active)
        cost = described_class.new(category: :weight, minimum: 2, maximum: 10, unit_price: 3,
                                   transportation_modal:)

        # Act
        result = cost.valid?

        # Assert
        expect(result).to be false
        expect(cost.errors.include?(:maximum)).to be true
      end
    end

    context 'range_is_unique' do
      it 'false when minimum is already in use' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 2, flat_rate: 5, status: :active)
        described_class.create!(category: :weight, minimum: 2, maximum: 7, unit_price: 3,
                                transportation_modal:)
        cost = described_class.new(category: :weight, minimum: 3, maximum: 8, unit_price: 3,
                                   transportation_modal:)

        # Act
        result = cost.valid?

        # Assert
        expect(result).to be false
        expect(cost.errors.include?(:minimum)).to be true
      end

      it 'false when maximum is already in use' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 2, flat_rate: 5, status: :active)
        described_class.create!(category: :weight, minimum: 3, maximum: 8, unit_price: 3,
                                transportation_modal:)
        cost = described_class.new(category: :weight, minimum: 2, maximum: 7, unit_price: 3,
                                   transportation_modal:)

        # Act
        result = cost.valid?

        # Assert
        expect(result).to be false
        expect(cost.errors.include?(:maximum)).to be true
      end
    end
  end
end
