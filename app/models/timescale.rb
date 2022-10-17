class Timescale < ApplicationRecord
  belongs_to :transportation_modal

  validates :deadline, numericality: {greater_than: 0}

  validates :min_distance, :max_distance, :deadline, presence:true
  validate :minimum_cannot_be_lower_than_transportation_modal_minimum, 
      :maximum_cannot_be_greater_than_transportation_modal_maximum, 
          :range_is_unique, unless: -> {self.min_distance.nil? || self.max_distance.nil?}
        

    def minimum_cannot_be_lower_than_transportation_modal_minimum
        if self.transportation_modal.min_distance > self.min_distance
            errors.add(:min_distance, "não pode ser menor que #{self.transportation_modal.min_distance}km")
        end
    end

    def maximum_cannot_be_greater_than_transportation_modal_maximum
        if self.transportation_modal.max_distance < self.max_distance
            errors.add(:max_distance, "não pode ser maior que #{self.transportation_modal.max_distance}km")
        end
    end

    def range_is_unique
      Timescale.where(transportation_modal:self.transportation_modal).each do |other_timescale|
        if other_timescale.min_distance < self.min_distance && other_timescale.max_distance > self.min_distance
            errors.add(:min_distance, "já cadastrado")
        end
        if other_timescale.min_distance < self.max_distance && other_timescale.max_distance > self.max_distance
            errors.add(:max_distance, "já cadastrado")
        end
      end
    end
end
