class TransportationModal < ApplicationRecord
    enum status: { active: 0, inactive: 2}
    has_many :vehicles
    has_many :costs
    has_many :timescales

    validates :name, :max_weight, :min_weight, :max_distance, :min_distance, :flat_rate, :status, presence:true
    validates :name, uniqueness:true
end
