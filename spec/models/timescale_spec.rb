require 'rails_helper'

RSpec.describe Timescale, type: :model do
    describe '#valid?' do
        context 'presence' do
            it  'false when min_distance is empty' do
                # Arrange
                transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                    max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
                timescale = Timescale.new(min_distance: nil,max_distance:10,deadline:24,transportation_modal:transportation_modal)

                # Act
                result = timescale.save

                # Assert
                expect(result).to eq false
            end

            it  'false when max_distance is empty' do
                # Arrange
                transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                    max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
                timescale = Timescale.new(min_distance: 1,max_distance:nil,deadline:24,transportation_modal:transportation_modal)

                # Act
                result = timescale.save

                # Assert
                expect(result).to eq false
            end

            it  'false when deadline is empty' do
                # Arrange
                transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                    max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
                timescale = Timescale.new(min_distance: 1,max_distance:10,deadline:nil,transportation_modal:transportation_modal)

                # Act
                result = timescale.save

                # Assert
                expect(result).to eq false
            end
        end

        context 'numericality' do
            it 'false when deadline is zero' do
                # Arrange
                transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                    max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
                timescale = Timescale.new(min_distance: 1,max_distance:10,deadline: 0,transportation_modal:transportation_modal)

                # Act
                result = timescale.save

                # Assert
                expect(result).to eq false
            end
        end

        context 'minimum_cannot_be_lower_than_transportation_modal_minimum' do
            it 'false when distance is lower' do
                # Arrange
                transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                    max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
                timescale = Timescale.new(min_distance: 0,max_distance:10,deadline: 0,transportation_modal:transportation_modal)

                # Act
                result = timescale.save

                # Assert
                expect(result).to eq false
            end
        end

        context 'maximum_cannot_be_greater_than_transportation_modal_maximum' do
            it 'false when distance is greater' do
                # Arrange
                transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                    max_weight: 8, min_weight: 0, flat_rate: 5, status: :active)
                timescale = Timescale.new(min_distance: 0,max_distance:11,deadline: 0,transportation_modal:transportation_modal)

                # Act
                result = timescale.save

                # Assert
                expect(result).to eq false
            end 
        end

        context 'range_is_unique' do
            it 'false when minimum is already in use' do
                # Arrange
                transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                    max_weight: 8, min_weight: 2, flat_rate: 5, status: :active)
                Timescale.create!(min_distance: 1,max_distance:5,deadline:24,transportation_modal:transportation_modal)
                timescale = Timescale.new(min_distance: 2,max_distance:10,deadline:24,transportation_modal:transportation_modal)

                # Act
                result = timescale.save

                # Assert
                expect(result).to eq false
            end

            it 'false when maximum is already in use' do
                # Arrange
                transportation_modal = TransportationModal.create!(name: 'Bicicleta', max_distance: 10 , min_distance: 1,
                    max_weight: 8, min_weight: 2, flat_rate: 5, status: :active)
                Timescale.create!(min_distance: 4,max_distance:8,deadline:24,transportation_modal:transportation_modal)
                timescale = Timescale.new(min_distance: 1,max_distance:7,deadline:24,transportation_modal:transportation_modal)
    
                # Act
                result = timescale.save

                # Assert
                expect(result).to eq false
            end
        end
    end

end
