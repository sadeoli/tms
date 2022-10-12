class ServiceOrdersController < ApplicationController
    before_action :set_service_order, only: [:show, :calculated, :closed, :update, :edit]
    before_action only: [:new, :create, :edit, :update] do
        redirect_to root_path unless current_user && current_user.admin?
    end

    def index
        @service_orders = ServiceOrder.all
    end

    def new
        @service_order = ServiceOrder.new
    end

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
        @service_order.update(service_order_params)
        redirect_to @service_order, notice: 'Ordem de serviço atualizada com sucesso.'
    end

    def edit
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

    def show
        @calculations = Calculation.where(service_order:@service_order)
        if @calculations.empty?
            flash.now[:alert]= "Não há modalidade de transporte e/ou configuração de tarifas que atendam essa ordem de serviço."
        end
    end

    private

    def set_service_order
        @service_order = ServiceOrder.find(params[:id])
    end

    def service_order_params
        params.require(:service_order).permit(:pickup_address, :product_code, :weight, :width, :height,
            :depth , :recipient_name ,:recipient_address , :recipient_phone , :distance, :delay_reason)
    end
end