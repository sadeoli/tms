class Calculation < ApplicationRecord
  belongs_to :service_order
  belongs_to :transportation_modal
  has_many :costs, through: :transportation_modal
  has_many :vehicles, through: :transportation_modal
  has_many :timescales, through: :transportation_modal


  def result
    if !weight_cost.nil? && !distance_cost.nil? && !time.nil?
      cost = (service_order.distance * weight_cost) + distance_cost + transportation_modal.flat_rate
      return {cost:cost,time:time}
    else
      nil
    end
  end

  def weight_cost
    Cost.where(transportation_modal:transportation_modal, category: :weight).each do |cost|
      if cost.maximum >= service_order.weight && cost.minimum <= service_order.weight
        return cost.unit_price
      end
    end
    nil
  end

  def distance_cost
    Cost.where(transportation_modal:transportation_modal, category: :distance).each do |cost|
      if cost.maximum >= service_order.distance && cost.minimum <= service_order.distance
        return cost.unit_price
      end
    end
    nil
  end

  def time
    Timescale.where(transportation_modal:transportation_modal).each do |time|
      if time.max_distance >= service_order.distance && time.min_distance <= service_order.distance
        return time.deadline
      end
    end
    nil
  end

end
