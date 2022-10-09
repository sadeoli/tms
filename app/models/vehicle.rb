class Vehicle < ApplicationRecord
  belongs_to :transportation_modal

  enum status: { ativo: 0, operando: 3, manutenção:5}

  validates :license_plate, :model, :brand, :max_weight, :manufacture_year, :status, presence:true
  validates :license_plate, uniqueness:true
end
