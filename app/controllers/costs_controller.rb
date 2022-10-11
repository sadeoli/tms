class CostsController < ApplicationController
    before_action only: [:new, :create, :edit, :update] do
        redirect_to root_path unless current_user && current_user.admin?
    end

    def index
        @costs = Cost.all
    end

    def new
        @transportation_modals = TransportationModal.all
        @cost = Cost.new
    end

    def create
        @cost = Cost.new(cost_params)
    end

    private

    
    def cost_params
        params.require(:cost).permit(:category, :maximum, :minimum, :unit_price, :transportation_modal)
    end
end