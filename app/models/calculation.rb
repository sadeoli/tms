class Calculation < ApplicationRecord
  belongs_to :service_order
  belongs_to :transportation_modal
  has_many :costs, through: :transportation_modal
  has_many :vehicles, through: :transportation_modal


  def result
    @costs = Cost.where(transportation_modal:transportation_modal)
    if !weight_cost.nil? && !distance_cost.nil?
      return ((service_order.distance * weight_cost) + distance_cost + transportation_modal.flat_rate)
    else
      nil
    end
  end

  def weight_cost
    @costs.weight.each do |cost|
      if cost.maximum >= service_order.weight && cost.minimum <= service_order.weight
        return cost.unit_price
      end
    end
    nil
  end

  def distance_cost
    @costs.distance.each do |cost|
      if cost.maximum >= service_order.distance && cost.minimum <= service_order.distance
        return cost.unit_price
      end
    end
    nil
  end

end
