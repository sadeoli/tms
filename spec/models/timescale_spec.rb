# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Timescale do
  describe '#valid?' do
    context 'presence' do
      it 'false when min_distance is empty' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        timescale = described_class.new(min_distance: nil, max_distance: 10, deadline: 24,
                                        transportation_modal:)

        # Act
        result = timescale.valid?

        # Assert
        expect(result).to be false
      end

      it 'false when max_distance is empty' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        timescale = described_class.new(min_distance: 1, max_distance: nil, deadline: 24,
                                        transportation_modal:)

        # Act
        result = timescale.valid?

        # Assert
        expect(result).to be false
      end

      it 'false when deadline is empty' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        timescale = described_class.new(min_distance: 1, max_distance: 10, deadline: nil,
                                        transportation_modal:)

        # Act
        result = timescale.valid?

        # Assert
        expect(result).to be false
      end
    end

    context 'numericality' do
      it 'false when deadline is zero' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        timescale = described_class.new(min_distance: 1, max_distance: 10, deadline: 0,
                                        transportation_modal:)

        # Act
        result = timescale.valid?

        # Assert
        expect(result).to be false
      end
    end

    context 'minimum_cannot_be_lower_than_transportation_modal_minimum' do
      it 'false when distance is lower' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        timescale = described_class.new(min_distance: 0, max_distance: 10, deadline: 0,
                                        transportation_modal:)

        # Act
        result = timescale.valid?

        # Assert
        expect(result).to be false
        expect(timescale.errors.include?(:min_distance)).to be true
      end
    end

    context 'maximum_cannot_be_greater_than_transportation_modal_maximum' do
      it 'false when distance is greater' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        timescale = described_class.new(min_distance: 0, max_distance: 11, deadline: 0,
                                        transportation_modal:)

        # Act
        result = timescale.valid?

        # Assert
        expect(result).to be false
        expect(timescale.errors.include?(:max_distance)).to be true
      end
    end

    context 'range_is_unique' do
      it 'false when minimum is already in use' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 2, flat_rate: 5, status: :active)
        described_class.create!(min_distance: 1, max_distance: 5, deadline: 24,
                                transportation_modal:)
        timescale = described_class.new(min_distance: 2, max_distance: 10, deadline: 24,
                                        transportation_modal:)

        # Act
        result = timescale.valid?

        # Assert
        expect(result).to be false
        expect(timescale.errors.include?(:min_distance)).to be true
      end

      it 'false when maximum is already in use' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 2, flat_rate: 5, status: :active)
        described_class.create!(min_distance: 4, max_distance: 8, deadline: 24,
                                transportation_modal:)
        timescale = described_class.new(min_distance: 1, max_distance: 7, deadline: 24,
                                        transportation_modal:)

        # Act
        result = timescale.valid?

        # Assert
        expect(result).to be false
        expect(timescale.errors.include?(:max_distance)).to be true
      end
    end
  end
end
