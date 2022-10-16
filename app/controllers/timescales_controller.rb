class TimescalesController < ApplicationController
    before_action :set_transportation_modal, only: [:create, :new, :update, :edit]
    before_action :set_timescale, only: [:update, :edit]
    before_action only: [:new, :create, :update, :edit] do
        redirect_to root_path unless current_user && current_user.admin?
    end

    def new
        @timescale = Timescale.new
    end

    def create
        @timescale  = @transportation_modal.timescales.new(timescale_params)
        if @timescale.save
            redirect_to @transportation_modal, notice: 'Prazo cadastrado com sucesso.'
        else
            flash.now[:alert] = 'Prazo não cadastrado.'
            render 'new'
        end
    end

    def edit
    end

    def update
        if @timescale.update(timescale_params)
            redirect_to @transportation_modal, notice: 'Prazo atualizado com sucesso.'
        else
            flash.now[:alert] = 'Não foi possível atualizar o prazo.'
            render 'edit'
        end
    end

    private

    
    def timescale_params
        params.require(:timescale).permit(:max_distance, :min_distance, :deadline)
    end

    def set_transportation_modal
        @transportation_modal = TransportationModal.find(params[:transportation_modal_id])
    end

    def set_timescale
        @timescale = @transportation_modal.timescales.find(params[:id])
    end
end