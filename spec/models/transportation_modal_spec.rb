# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransportationModal do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        # Arrange
        transportation_modal = described_class.new(name: '', max_distance: 10, min_distance: 1,
                                                   max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)

        # Act
        result = transportation_modal.valid?

        # Assert
        expect(result).to be false
      end

      it 'false when max_distance is empty' do
        # Arrange
        transportation_modal = described_class.new(name: 'Bicicleta', max_distance: nil, min_distance: 1,
                                                   max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)

        # Act
        result = transportation_modal.valid?

        # Assert
        expect(result).to be false
      end

      it 'false when min_distance is empty' do
        # Arrange
        transportation_modal = described_class.new(name: 'Bicicleta', max_distance: 10, min_distance: nil,
                                                   max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)

        # Act
        result = transportation_modal.valid?

        # Assert
        expect(result).to be false
      end

      it 'false when max_weight is empty' do
        # Arrange
        transportation_modal = described_class.new(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                   max_weight: nil, min_weight: 0, flat_rate: 5, status: :active)

        # Act
        result = transportation_modal.valid?

        # Assert
        expect(result).to be false
      end

      it 'false when min_weight is empty' do
        # Arrange
        transportation_modal = described_class.new(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                   max_weight: 8, min_weight: nil, flat_rate: 5, status: :active)

        # Act
        result = transportation_modal.valid?

        # Assert
        expect(result).to be false
      end

      it 'false when flat_rate is empty' do
        # Arrange
        transportation_modal = described_class.new(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                   max_weight: 8, min_weight: 0, flat_rate: nil, status: :active)

        # Act
        result = transportation_modal.valid?

        # Assert
        expect(result).to be false
      end

      it 'false when status is empty' do
        # Arrange
        transportation_modal = described_class.new(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                   max_weight: 8, min_weight: 0, flat_rate: 5, status: nil)

        # Act
        result = transportation_modal.valid?

        # Assert
        expect(result).to be false
      end
    end

    context 'uniqueness' do
      it 'false when name is already in use' do
        # Arrange
        transportation_modal1 = described_class.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                        max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        transportation_modal2 = described_class.new(name: 'Bicicleta', max_distance: 9, min_distance: 2,
                                                    max_weight: 9, min_weight: 1, flat_rate: 7, status: :active)

        # Act
        result = transportation_modal2.valid?

        # Assert
        expect(result).to be false
      end
    end

    context 'numericality' do
      it 'false when min_distance is negative' do
        # Arrange
        transportation_modal = described_class.new(name: 'Bicicleta', max_distance: 10, min_distance: -1,
                                                   max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)

        # Act
        result = transportation_modal.valid?

        # Assert
        expect(result).to be false
      end

      it 'false when min_weight is negative' do
        # Arrange
        transportation_modal = described_class.new(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                   max_weight: 8, min_weight: -5, flat_rate: 5, status: :active)

        # Act
        result = transportation_modal.valid?

        # Assert
        expect(result).to be false
      end

      it 'false when flat_rate is negative' do
        # Arrange
        transportation_modal = described_class.new(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                   max_weight: 8, min_weight: 5, flat_rate: -5, status: :active)

        # Act
        result = transportation_modal.valid?

        # Assert
        expect(result).to be false
      end
    end

    context 'comparison' do
      it 'false when max_distance is lower than min_distance' do
        # Arrange
        transportation_modal = described_class.new(name: 'Bicicleta', max_distance: 10, min_distance: 11,
                                                   max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)

        # Act
        result = transportation_modal.valid?

        # Assert
        expect(result).to be false
      end

      it 'false when max_weight is lower than min_weight' do
        # Arrange
        transportation_modal = described_class.new(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                   max_weight: 8, min_weight: 15, flat_rate: 5, status: :active)

        # Act
        result = transportation_modal.valid?

        # Assert
        expect(result).to be false
      end
    end
  end
end
