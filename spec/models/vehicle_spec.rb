require 'rails_helper'

RSpec.describe Vehicle, type: :model do
    describe '#valid?' do
        context 'presence' do
            it  'false when license_plate is empty' do
                # Arrange
                transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                    max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
                vehicle = Vehicle.new(license_plate: '', model: 'City Tour', brand: 'Caloi', max_weight: '5', 
                    manufacture_year: '2015', transportation_modal:transportation_modal, status: :working)

                # Act
                result = vehicle.valid?

                # Assert
                expect(result).to eq false
            end

            it  'false when model is empty' do
                # Arrange
                transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                    max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
                vehicle = Vehicle.new(license_plate: 'HUIK-5232', model: '', brand: 'Caloi', max_weight: '5', 
                    manufacture_year: '2015', transportation_modal:transportation_modal, status: :working)

                # Act
                result = vehicle.valid?

                # Assert
                expect(result).to eq false
            end

            it  'false when brand is empty' do
                # Arrange
                transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                    max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
                vehicle = Vehicle.new(license_plate: 'HUIK-5232', model: 'City Tour', brand: '', max_weight: '5', 
                    manufacture_year: '2015', transportation_modal:transportation_modal, status: :working)

                # Act
                result = vehicle.valid?

                # Assert
                expect(result).to eq false
            end

            it  'false when max_weight is empty' do
                # Arrange
                transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                    max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
                vehicle = Vehicle.new(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '', 
                    manufacture_year: '2015', transportation_modal:transportation_modal, status: :working)

                # Act
                result = vehicle.valid?

                # Assert
                expect(result).to eq false
            end

            it  'false when manufacture_year is empty' do
                # Arrange
                transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                    max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
                vehicle = Vehicle.new(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5', 
                    manufacture_year: '', transportation_modal:transportation_modal, status: :working)

                # Act
                result = vehicle.valid?

                # Assert
                expect(result).to eq false
            end

            it  'false when transportation_modal is empty' do
                # Arrange
                transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                    max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
                vehicle = Vehicle.new(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5', 
                    manufacture_year: '2015', transportation_modal:nil, status: :working)

                # Act
                result = vehicle.valid?

                # Assert
                expect(result).to eq false
            end

            it  'false when status is empty' do
                # Arrange
                transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                    max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
                vehicle = Vehicle.new(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5', 
                    manufacture_year: '2015', transportation_modal:transportation_modal, status: nil)

                # Act
                result = vehicle.valid?

                # Assert
                expect(result).to eq false
            end
        end
    end

end
