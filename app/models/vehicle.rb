class Vehicle < ApplicationRecord
  belongs_to :transportation_modal

  enum status: { active: 0, working: 3, maintenance:5}

  validates :license_plate, :model, :brand, :max_weight, :manufacture_year, :status, presence:true
  validates :license_plate, uniqueness:true
end
