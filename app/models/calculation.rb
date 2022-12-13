# frozen_string_literal: true

class Calculation < ApplicationRecord
  belongs_to :service_order
  belongs_to :transportation_modal
  has_many :costs, through: :transportation_modal
  has_many :vehicles, through: :transportation_modal
  has_many :timescales, through: :transportation_modal

  def result
    return unless !weight_cost.nil? && !distance_cost.nil? && !time.nil?

    cost = (service_order.distance * weight_cost) + distance_cost + transportation_modal.flat_rate
    { cost:, time: }
  end

  def weight_cost
    Cost.where(transportation_modal:, category: :weight).find_each do |cost|
      return cost.unit_price if cost.maximum >= service_order.weight && cost.minimum <= service_order.weight
    end
    nil
  end

  def distance_cost
    Cost.where(transportation_modal:, category: :distance).find_each do |cost|
      return cost.unit_price if cost.maximum >= service_order.distance && cost.minimum <= service_order.distance
    end
    nil
  end

  def time
    Timescale.where(transportation_modal:).find_each do |time|
      return time.deadline if time.max_distance >= service_order.distance && time.min_distance <= service_order.distance
    end
    nil
  end
end
