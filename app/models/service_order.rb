class ServiceOrder < ApplicationRecord
    enum status: { pending: 0, intransit: 3, ontime: 7, delayed: 9}
    belongs_to :vehicle, optional: true

    before_validation :generate_code, on: :create 

    def generate_code
        self.code = SecureRandom.alphanumeric(15).upcase
    end

    def calculate
        @transportation_modals = TransportationModal.active
        @transportation_modals.each do |transportation_modal|
            if !Calculation.new(service_order: self, transportation_modal: transportation_modal).result.nil?
                Calculation.create!(service_order: self, transportation_modal: transportation_modal)
            end
        end
    end

    def close
        self.delivery_date = Date.today
        if self.delivery_time > 24 * (self.delivery_date - self.ship_date).to_i
            self.ontime!
        else
            self.delayed!
        end
    end
    
end
