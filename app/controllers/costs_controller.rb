# frozen_string_literal: true

class CostsController < ApplicationController
  before_action :set_transportation_modal, only: %i[create new edit update set_cost]
  before_action :set_cost, only: %i[edit update]
  before_action only: %i[new create edit update] do
    redirect_to root_path, alert: 'ACESSO NEGADO' unless current_user&.admin?
  end

  def index
    @costs = Cost.all
    @timescales = Timescale.all
  end

  def new
    @cost = Cost.new
  end

  def edit; end

  def create
    @cost = @transportation_modal.costs.new(cost_params)
    if @cost.save
      redirect_to @transportation_modal, notice: 'Preço cadastrado com sucesso.'
    else
      @transportation_modals = TransportationModal.all
      flash.now[:alert] = 'Preço não cadastrado.'
      render 'new'
    end
  end

  def update
    if @cost.update(cost_params)
      redirect_to @transportation_modal, notice: 'Preço atualizado com sucesso.'
    else
      flash.now[:alert] = 'Não foi possível atualizar o preço.'
      render 'edit'
    end
  end

  private

  def cost_params
    params.require(:cost).permit(:category, :maximum, :minimum, :unit_price)
  end

  def set_transportation_modal
    @transportation_modal = TransportationModal.find(params[:transportation_modal_id])
  end

  def set_cost
    @cost = @transportation_modal.costs.find(params[:id])
  end
end
