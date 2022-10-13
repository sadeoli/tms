class TimescalesController < ApplicationController
    before_action :set_transportation_modal, only: [:create, :new]
    before_action only: [:new, :create] do
        redirect_to root_path unless current_user && current_user.admin?
    end

    def new
        @timescale = Timescale.new
    end

    def create
        @timescale  = @transportation_modal.Timescales.new(timescale_params)
        if @timescale.save
            redirect_to @transportation_modal, notice: 'Prazo cadastrado com sucesso.'
        else
            flash.now[:alert] = 'Prazo não cadastrado.'
            render 'new'
        end
    end

    private

    
    def timescale_params
        params.require(:timescale).permit(:max_distance, :min_distance, :deadline)
    end

    def set_transportation_modal
        @transportation_modal = TransportationModal.find(params[:transportation_modal_id])
    end
end