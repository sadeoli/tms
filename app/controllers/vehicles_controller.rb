# frozen_string_literal: true

class VehiclesController < ApplicationController
  before_action only: %i[new create edit update] do
    redirect_to root_path, alert: t(:access_denied) unless current_user&.admin?
  end

  before_action :set_vehicle, only: %i[edit update show]

  def index
    @vehicles = Vehicle.all
  end

  def new
    @vehicle = Vehicle.new
    @transportation_modals = TransportationModal.all
  end

  def edit
    @transportation_modals = TransportationModal.all
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    if @vehicle.save
      redirect_to vehicles_path, notice: t(:vehicle_created)
    else
      @transportation_modals = TransportationModal.all
      flash.now[:alert] = t(:vehicle_not_created)
      render 'new'
    end
  end

  def update
    if @vehicle.update(vehicle_params)
      redirect_to vehicles_path, notice: t(:vehicle_updated)
    else
      @transportation_modals = TransportationModal.all
      flash.now[:alert] = t(:vehicle_not_updated)
      render 'edit'
    end
  end

  def search
    @code = params[:query]
    @vehicles = Vehicle.where('license_plate LIKE ?', "%#{@code}%")
    redirect_to vehicles_path, alert: t(:vehicle_not_found) if @vehicles.empty?
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
