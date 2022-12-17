# frozen_string_literal: true

class ServiceOrdersController < ApplicationController
  before_action :set_service_order, only: %i[show calculated closed edit update]
  before_action only: %i[new create update edit] do
    redirect_to root_path, alert: t(:access_denied) unless current_user&.admin?
  end

  def index
    @service_orders = ServiceOrder.all
  end

  def show
    @calculations = Calculation.where(service_order: @service_order)
    return unless @calculations.empty?

    flash.now[:alert] = t(:calculation_error)
  end

  def new
    @service_order = ServiceOrder.new
  end

  def edit; end

  def create
    @service_order = ServiceOrder.new(service_order_params)
    if @service_order.save
      redirect_to service_orders_path, notice: t(:service_order_created)
    else
      flash.now[:alert] = t(:service_order_not_created)
      render 'new'
    end
  end

  def update
    if @service_order.update(service_order_params)
      redirect_to @service_order, notice: t(:service_order_updated)
    else
      flash.now[:notice] = t(:service_order_not_updated)
      render 'edit'
    end
  end

  def filter
    @service_orders = ServiceOrder.where(status: :pending)
    render 'index'
  end

  def calculated
    @service_order.calculate
    redirect_to @service_order
  end

  def closed
    @service_order.close
    @service_order.vehicle.active!
    redirect_to @service_order
  end

  def search
    @code = params[:query]
    @service_order = ServiceOrder.find_by(code: @code)
    return unless @service_order.nil?

    if user_signed_in?
      redirect_to service_orders_path, alert: t(:service_order_not_found)
    else
      redirect_to root_path, alert: t(:service_order_not_found)
    end
  end

  private

  def set_service_order
    @service_order = ServiceOrder.find(params[:id])
  end

  def service_order_params
    params.require(:service_order).permit(:pickup_address, :product_code, :weight, :width, :height,
                                          :depth, :recipient_name, :recipient_address, :recipient_phone,
                                          :distance, :delay_reason)
  end
end
