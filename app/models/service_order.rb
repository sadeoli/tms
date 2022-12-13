# frozen_string_literal: true

class ServiceOrder < ApplicationRecord
  enum status: { pending: 0, intransit: 3, ontime: 7, delayed: 9 }
  belongs_to :vehicle, optional: true

  validates :pickup_address, :product_code, :weight, :width, :height, :depth, :recipient_name,
            :recipient_address, :recipient_phone, :distance, presence: true
  validates :weight, :width, :height, :depth, :distance, numericality: { greater_than: 1 }

  before_validation :generate_code, on: :create

  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end

  def calculate
    @transportation_modals = TransportationModal.active
    @transportation_modals.each do |transportation_modal|
      unless Calculation.new(service_order: self, transportation_modal:).result.nil?
        Calculation.create!(service_order: self, transportation_modal:)
      end
    end
  end

  def close
    self.delivery_date = Time.zone.today
    if delivery_time > 24 * (delivery_date - ship_date).to_i
      ontime!
    else
      delayed!
    end
  end
end
