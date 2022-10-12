class CalculationsController < ApplicationController
    before_action :set_service_order, only: [:started]
    before_action :set_calculation, only: [:started]

    def started
        @vehicles = Vehicle.where(transportation_modal:@calculation.transportation_modal, status: :active)
        if @vehicles.any?
            @service_order.intransit!
            @vehicles.first.working!
            @service_order.update(total_cost:@calculation.result)
            redirect_to @service_order, notice: 'Ordem de serviço iniciada.'
        end
    end

    private

    def set_calculation
        @calculation = Calculation.find(params[:id])
    end  

    def set_service_order
        @service_order = ServiceOrder.find(params[:service_order_id])
    end

end