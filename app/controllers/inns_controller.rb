class InnsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_inn, only: [:edit, :update, :show]

  def index
    redirect_to root_path
  end

  def new
    @inn = Inn.new
  end

  def create
    @inn = Inn.new(inn_params)
    @inn.user = current_user

    if @inn.save
      flash.now[:alert] = 'Sua pousada foi cadastrada com sucesso!'
      redirect_to root_path
    else
      flash.now[:alert] = 'Não foi possível cadastrar a pousada.'
      render 'new'
    end
  end

  def edit
    @inn
  end

  def update
    if @inn.update(inn_params)
      flash.now[:alert] = 'Pousada atualizada com sucesso.'
      redirect_to @inn
    else
      flash.now[:alert] = 'Pousada não atualizada.'
      render 'edit'
    end
  end

  def show
    @inn
    @available_rooms = @inn.rooms.where(available: true).order(:name)
  end

  private

  def set_inn
    @inn = Inn.find(params[:id])
  end

  def inn_params
    params.require(:inn).permit(:brand_name, :corporate_name, :cnpj, :contact_phone, :email, :full_address, :state, :city, :zip_code, :description, :rooms_max, :pets_accepted, :breakfast, :camping, :accessibility, :policies, :payment_methods, :check_in_time, :check_out_time, :user_id, :active)
  end
end
