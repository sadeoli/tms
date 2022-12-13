# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vehicle do
  describe '#valid?' do
    context 'presence' do
      it 'false when license_plate is empty' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        vehicle = described_class.new(license_plate: '', model: 'City Tour', brand: 'Caloi', max_weight: '5',
                                      manufacture_year: '2015', transportation_modal:, status: :working)

        # Act
        result = vehicle.valid?

        # Assert
        expect(result).to be false
      end

      it 'false when model is empty' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        vehicle = described_class.new(license_plate: 'HUIK-5232', model: '', brand: 'Caloi', max_weight: '5',
                                      manufacture_year: '2015', transportation_modal:, status: :working)

        # Act
        result = vehicle.valid?

        # Assert
        expect(result).to be false
      end

      it 'false when brand is empty' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        vehicle = described_class.new(license_plate: 'HUIK-5232', model: 'City Tour', brand: '', max_weight: '5',
                                      manufacture_year: '2015', transportation_modal:, status: :working)

        # Act
        result = vehicle.valid?

        # Assert
        expect(result).to be false
      end

      it 'false when max_weight is empty' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        vehicle = described_class.new(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '',
                                      manufacture_year: '2015', transportation_modal:, status: :working)

        # Act
        result = vehicle.valid?

        # Assert
        expect(result).to be false
      end

      it 'false when manufacture_year is empty' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        vehicle = described_class.new(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5',
                                      manufacture_year: '', transportation_modal:, status: :working)

        # Act
        result = vehicle.valid?

        # Assert
        expect(result).to be false
      end

      it 'false when transportation_modal is empty' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        vehicle = described_class.new(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5',
                                      manufacture_year: '2015', transportation_modal: nil, status: :working)

        # Act
        result = vehicle.valid?

        # Assert
        expect(result).to be false
      end

      it 'false when status is empty' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        vehicle = described_class.new(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5',
                                      manufacture_year: '2015', transportation_modal:, status: nil)

        # Act
        result = vehicle.valid?

        # Assert
        expect(result).to be false
      end
    end

    context 'uniqueness' do
      it 'false when license_plate is already is use' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        vehicle2 = described_class.create!(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5',
                                           manufacture_year: '2015', transportation_modal:, status: :working)
        vehicle = described_class.new(license_plate: 'HUIK-5232', model: 'Speed Track', brand: 'Caloi', max_weight: 7,
                                      manufacture_year: 2017, transportation_modal:, status: :working)
        # Act
        result = vehicle.valid?

        # Assert
        expect(result).to be false
      end
    end

    context 'numeracality' do
      it 'false when manufacture year is future' do
        # Arrange
        transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                           max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
        vehicle = described_class.new(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5',
                                      manufacture_year: 1.year.from_now.year, transportation_modal:, status: :working)

        # Act
        result = vehicle.valid?

        # Assert
        expect(result).to be false
      end
    end
  end

  describe '#set_max_weight' do
    it 'vehicle max_weight is lower or equal to its transportation modal max_weight on create' do
      # Arrange
      transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                         max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
      vehicle = described_class.new(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: 10,
                                    manufacture_year: 2015, transportation_modal:, status: :working)

      # Act
      vehicle.save!

      # Assert
      expect(vehicle.max_weight).to eq 8
    end

    it 'vehicle max_weight is lower or equal to its transportation modal max_weight on update' do
      # Arrange
      transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 1,
                                                         max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
      vehicle = described_class.create!(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: 5,
                                        manufacture_year: 2015, transportation_modal:, status: :working)

      # Act
      vehicle.update!(max_weight: 15)

      # Assert
      expect(vehicle.max_weight).to eq 8
    end
  end
end
