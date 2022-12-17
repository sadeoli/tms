# frozen_string_literal: true

class CalculationsController < ApplicationController
  before_action :set_service_order, only: [:started]
  before_action :set_calculation, only: [:started]

  def started
    @vehicles = Vehicle.where(transportation_modal: @calculation.transportation_modal, status: :active)
    return unless @vehicles.any?

    @service_order.intransit!
    @vehicles.first.working!
    @service_order.update(total_cost: @calculation.result[:cost], delivery_time: @calculation.result[:time],
                          vehicle: @vehicles.first, ship_date: Time.zone.today)
    redirect_to @service_order, notice: t(:so_started)
  end

  private

  def set_calculation
    @calculation = Calculation.find(params[:id])
  end

  def set_service_order
    @service_order = ServiceOrder.find(params[:service_order_id])
  end
end
