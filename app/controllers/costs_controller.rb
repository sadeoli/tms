class CostsController < ApplicationController
    before_action :set_transportation_modal, only: [:create, :new]
    before_action only: [:new, :create, :edit, :update] do
        redirect_to root_path unless current_user && current_user.admin?
    end

    def index
        @costs = Cost.all
    end

    def new
        @cost = Cost.new
    end

    def create
        cost = @transportation_modal.costs.new(cost_params)
        if cost.save
            redirect_to @transportation_modal, notice: 'Preço cadastrado com sucesso.'
        else
            @transportation_modals = TransportationModal.all
            flash.now[:alert] = 'Preço não cadastrado.'
            render 'new'
        end
    end

    private

    
    def cost_params
        params.require(:cost).permit(:category, :maximum, :minimum, :unit_price)
    end

    def set_transportation_modal
        @transportation_modal = TransportationModal.find(params[:transportation_modal_id])
    end
end