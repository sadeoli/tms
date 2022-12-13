# frozen_string_literal: true

class TransportationModal < ApplicationRecord
  enum status: { active: 0, inactive: 2 }
  has_many :vehicles
  has_many :costs
  has_many :timescales

  validates :min_weight, :min_distance, :flat_rate, numericality: { greater_than_or_equal_to: 0 }
  validates :max_weight, comparison: { greater_than: :min_weight }
  validates :max_distance, comparison: { greater_than: :min_distance }
  validates :name, :max_weight, :min_weight, :max_distance, :min_distance, :flat_rate, :status, presence: true
  validates :name, uniqueness: true
end
