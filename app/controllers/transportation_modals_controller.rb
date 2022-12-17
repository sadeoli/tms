# frozen_string_literal: true

class TransportationModalsController < ApplicationController
  before_action only: %i[new create edit update inactived] do
    redirect_to root_path, alert: t(:access_denied) unless current_user&.admin?
  end

  before_action :set_transportation_modal, only: %i[show edit update inactived]

  def index
    @transportation_modals = TransportationModal.all
  end

  def show; end

  def new
    @transportation_modal = TransportationModal.new
  end

  def edit; end

  def create
    @transportation_modal = TransportationModal.new(transportation_modal_params)
    if @transportation_modal.save
      redirect_to transportation_modals_path, notice: t(:transportation_modal_created)
    else
      flash.now[:alert] = t(:transportation_modal_not_created)
      render 'new'
    end
  end

  def update
    if @transportation_modal.update(transportation_modal_params)
      redirect_to @transportation_modal, notice: t(:transportation_modal_updated)
    else
      flash.now[:alert] = t(:transportation_modal_not_updated)
      render 'edit'
    end
  end

  def inactived
    @transportation_modal.inactive!
    redirect_to @transportation_modal
  end

  private

  def transportation_modal_params
    params.require(:transportation_modal).permit(:name, :max_distance, :min_distance, :max_weight,
                                                 :min_weight, :flat_rate)
  end

  def set_transportation_modal
    @transportation_modal = TransportationModal.find(params[:id])
  end
end
