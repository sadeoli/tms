# frozen_string_literal: true

class ServiceOrdersController < ApplicationController
  before_action :set_service_order, only: %i[show calculated closed edit update]
  before_action only: %i[new create update edit] do
    redirect_to root_path, alert: 'ACESSO NEGADO' unless current_user&.admin?
  end

  def index
    @service_orders = ServiceOrder.all
  end

  def show
    @calculations = Calculation.where(service_order: @service_order)
    return unless @calculations.empty?

    flash.now[:alert] =
      'Não há modalidade de transporte e/ou configuração de tarifas que atendam essa ordem de serviço.'
  end

  def new
    @service_order = ServiceOrder.new
  end

  def edit; end

  def create
    @service_order = ServiceOrder.new(service_order_params)
    if @service_order.save
      redirect_to service_orders_path, notice: 'Ordem de serviço cadastrado com sucesso.'
    else
      flash.now[:alert] = 'Ordem de serviço não cadastrado.'
      render 'new'
    end
  end

  def update
    if @service_order.update(service_order_params)
      redirect_to @service_order, notice: 'Ordem de serviço atualizada com sucesso.'
    else
      flash.now[:notice] = 'Não foi possível atualizar a ordem de serviço.'
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
      redirect_to service_orders_path, alert: 'Não foi possível encontrar o pedido.'
    else
      redirect_to root_path, alert: 'Não foi possível encontrar o pedido.'
    end
  end

  private

  def set_service_order
    @service_order = ServiceOrder.find(params[:id])
  end

  def service_order_params
    params.require(:service_order).permit(:pickup_address, :product_code, :weight, :width, :height,
                                          :depth, :recipient_name, :recipient_address, :recipient_phone, :distance, :delay_reason)
  end
end
