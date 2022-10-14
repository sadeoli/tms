class VehiclesController < ApplicationController
    before_action only: [:new, :create, :edit, :update] do
        redirect_to root_path unless current_user && current_user.admin?
    end

    before_action :set_vehicle, only: [:edit, :update]

    def index
        @vehicles = Vehicle.all
    end

    def new
        @vehicle = Vehicle.new
        @transportation_modals = TransportationModal.all 
    end

    def create
        @vehicle = Vehicle.new(vehicle_params)
        if @vehicle.save
            redirect_to vehicles_path, notice: 'Veículo cadastrado com sucesso.'
        else
            @transportation_modals = TransportationModal.all
            flash.now[:alert] = 'Veículo não cadastrado.'
            render 'new'
        end
    end

    def edit
        @transportation_modals = TransportationModal.all
    end

    def update
        if @vehicle.update(vehicle_params)
            redirect_to vehicles_path, notice: 'Veículo atualizado com sucesso.'
        else
            @transportation_modals = TransportationModal.all
            flash.now[:alert] = 'Não foi possível atualizar o veículo.'
            render 'edit'
        end
    end

    private

    def vehicle_params
        params.require(:vehicle).permit(:license_plate, :model, :brand, :max_weight,
            :manufacture_year, :transportation_modal_id, :status)
    end

    def set_vehicle
        @vehicle = Vehicle.find(params[:id])
    end

end