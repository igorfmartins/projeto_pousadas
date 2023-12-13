class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_room, only: [:show, :edit, :update]

  def index
    @rooms = @inn.rooms
  end

  def show
    @room
    @prices = @room.prices 
  end

  def new
    @inn = current_user.inn
    @room = Room.new
  end

  def create
    @room = current_user.inn.rooms.build(room_params)
    if @room.save
      flash.now[:alert] = 'Quarto adicionado com sucesso.'
      redirect_to root_path
    else
      flash.now[:alert] = 'Algo deu errado, tente novamente.'
      render :new
    end
  end

  def edit
    @inn = @room.inn
    @room
  end

  def update
    if @room.update(room_params) 
      flash.now[:alert] = 'Quarto atualizado com sucesso.'
      redirect_to root_path
    else
      flash.now[:alert] = 'Quarto não atualizado.'
      render 'edit'
    end
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :description, :dimension, :max_occupancy, :daily_rate, :bathroom, :balcony, :air_conditioning, :tv, :wardrobe, :safe, :accessible, :available)
  end
end
