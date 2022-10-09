class TransportationModal < ApplicationRecord
    enum status: { ativo: 0, inativo: 2}

    validates :name, :max_weight, :min_weight, :max_distance, :min_distance, :flat_rate, :status, presence:true
    validates :name, uniqueness:true
end
