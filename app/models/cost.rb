# frozen_string_literal: true

class Cost < ApplicationRecord
  enum category: { weight: 2, distance: 6 }
  belongs_to :transportation_modal
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }

  validates :category, :minimum, :maximum, :unit_price, presence: true
  validate :minimum_cannot_be_lower_than_transportation_modal_minimum,
           :maximum_cannot_be_greater_than_transportation_modal_maximum,
           :range_is_unique, unless: -> { minimum.nil? || maximum.nil? }

  def minimum_cannot_be_lower_than_transportation_modal_minimum
    if weight? && transportation_modal.min_weight > minimum
      errors.add(:minimum, "não pode ser menor que #{transportation_modal.min_weight}kg")
    elsif distance? && transportation_modal.min_distance > minimum
      errors.add(:minimum, "não pode ser menor que #{transportation_modal.min_distance}km")
    end
  end

  def maximum_cannot_be_greater_than_transportation_modal_maximum
    if weight? && transportation_modal.max_weight < maximum
      errors.add(:maximum, "não pode ser maior que #{transportation_modal.max_weight}kg")
    elsif distance? && transportation_modal.max_distance < maximum
      errors.add(:maximum, "não pode ser maior que #{transportation_modal.max_distance}km")
    end
  end

  def range_is_unique
    costs = Cost.where(transportation_modal:, category:)
    costs.each do |other_cost|
      errors.add(:minimum, 'já cadastrado') if other_cost.minimum < minimum && other_cost.maximum > minimum
      errors.add(:maximum, 'já cadastrado') if other_cost.minimum < maximum && other_cost.maximum > maximum
    end
  end
end
