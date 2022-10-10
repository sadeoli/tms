class ServiceOrder < ApplicationRecord
    enum status: { pending: 0, intransit: 3, ontime: 7, delayed: 9}

    before_validation :generate_code, on: :create 

    def generate_code
        self.code = SecureRandom.alphanumeric(15).upcase
    end
end
