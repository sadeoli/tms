class Cost < ApplicationRecord
    enum category: {weight: 2, distance:6}
    belongs_to :transportation_modal
    validates :unit_price, numericality: {greater_than_or_equal_to: 0}

    validates :category, :minimum, :maximum, :unit_price, presence:true
    validate :minimum_cannot_be_lower_than_transportation_modal_minimum, 
    :maximum_cannot_be_greater_than_transportation_modal_maximum, 
    :range_is_unique, unless: -> {self.minimum.nil? || self.maximum.nil?}
        

    def minimum_cannot_be_lower_than_transportation_modal_minimum
        if self.weight? && self.transportation_modal.min_weight > self.minimum
            errors.add(:minimum, "não pode ser menor que #{self.transportation_modal.min_weight}kg")
        elsif self.distance? && self.transportation_modal.min_distance > self.minimum
            errors.add(:minimum, "não pode ser menor que #{self.transportation_modal.min_distance}km")
        end
    end

    def maximum_cannot_be_greater_than_transportation_modal_maximum
        if self.weight? && self.transportation_modal.max_weight < self.maximum
            errors.add(:maximum, "não pode ser maior que #{self.transportation_modal.max_weight}kg")
        elsif self.distance? && self.transportation_modal.max_distance < self.maximum
            errors.add(:maximum, "não pode ser maior que #{self.transportation_modal.max_distance}km")
        end
    end

    def range_is_unique
        costs = Cost.where(transportation_modal:self.transportation_modal,category: self.category)
        costs.each do |other_cost|
            if other_cost.minimum < self.minimum && other_cost.maximum > self.minimum
                errors.add(:minimum, "já cadastrado")
            end
            if other_cost.minimum < self.maximum && other_cost.maximum > self.maximum
                errors.add(:maximum, "já cadastrado")
            end
        end
    end
end
