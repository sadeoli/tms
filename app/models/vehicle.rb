# frozen_string_literal: true

class Vehicle < ApplicationRecord
  belongs_to :transportation_modal
  has_many :service_orders

  enum status: { active: 0, working: 3, maintenance: 5 }
  validates :manufacture_year, numericality: { less_than_or_equal_to: Time.zone.today.year }
  validates :license_plate, :model, :brand, :max_weight, :manufacture_year, :status, presence: true
  validates :license_plate, uniqueness: true

  before_save :set_max_weight

  def set_max_weight
    self.max_weight = transportation_modal.max_weight if max_weight > transportation_modal.max_weight
  end
end
