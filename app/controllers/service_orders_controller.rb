class ServiceOrdersController < ApplicationController
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

    private

    def service_order_params
        params.require(:service_order).permit(:pickup_addres, :product_code, :weight, :width, :height,
            :depth , :recipient_name ,:recipient_address , :recipient_phone , :distance)
    end
end