class ServiceOrdersController < ApplicationController
    before_action :set_service_order, only: [:show, :calculated]
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

    def calculated
        @costs = Cost.all
        @transportation_modals = TransportationModal.all
        @service_order.calculate
        redirect_to @service_order
    end

    def show
        @calculations = Calculation.where(service_order:@service_order)
        if @calculations.empty?
            flash.now[:alert]= "Não há modalidade de transporte ou configuração de preço que atenda essa ordem de serviço."
        end
    end

    private

    def set_service_order
        @service_order = ServiceOrder.find(params[:id])
    end

    def service_order_params
        params.require(:service_order).permit(:pickup_addres, :product_code, :weight, :width, :height,
            :depth , :recipient_name ,:recipient_address , :recipient_phone , :distance)
    end
end