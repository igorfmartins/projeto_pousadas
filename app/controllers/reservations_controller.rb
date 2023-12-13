class ReservationsController < ApplicationController
  before_action :set_room, only: [:new, :create]
  before_action :authenticate_user!, only: [:overdue]

  def new
    @room
    @reservation = Reservation.new
  end

  def create
    @room 
    @reservation = Reservation.new(reservation_params)
    @reservation.status = "awaiting"   
    range_date_to_rent = @reservation.start_date..@reservation.end_date
    available_reservations = Reservation.where(room_id: @room.id)
    available_dates = []

    if available_reservations.present?
      # Filtro todas as reservas existentes e comparo cada uma.
      available_reservations.each do |reservations_date|
        range_already_reserved = reservations_date.start_date..reservations_date.end_date
        if range_date_to_rent.overlaps?(range_already_reserved)
          available_dates << true
        else
          available_dates << false
        end
      end      
    else
      available_dates << false
    end 
  
    if available_dates.all?(false)
      if @room.max_occupancy < @reservation.number_of_guests.to_i
        flash.now[:alert] = "Esse quarto não possui capacidade para #{@reservation.number_of_guests} hóspedes."
        render :new
      else       
        flash.now[:alert] = "Reserva cadastrada com sucesso."
        @reservation.save
        redirect_to inn_room_reservation_confirmation_path(reservation_id: @reservation.id)
      end
    else
      flash.now[:alert] = "O período ja esta reservado."
      render :new
    end  
  end 

  def confirmation
    @reservation = Reservation.find(params["reservation_id"])       
  end     

  def my_reservations
    @reservations = Reservation.where(guest_id: current_guest.id)
  end

  def ready
    @reservation = Reservation.find(params["reservation_id"])
    @reservation.update(status: 'confirmed')
    flash.now[:alert] = 'Reserva confirmada com sucesso!'
    redirect_to root_path
  end

  def checkin
    @reservation = Reservation.find(params["reservation_id"])
    if Date.current >= @reservation.start_date
      @reservation.checkin! 
      flash.now[:alert] = 'Check-in realizado com sucesso!'
      redirect_to root_path
    else
      flash.now[:alert] = 'Check-in não permitido para esta reserva.'
      redirect_to inn_my_reservations_path
    end
  end 

  def checkout
    @reservation = Reservation.find(params["reservation_id"])
    @reservation.checkout!
    flash.now[:alert] = 'Check-out realizado com sucesso!'
    redirect_to inn_my_reservations_path
  end

  def overdue

  end

  private
  
  def set_room
    @room = Room.find(params['room_id'])
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :number_of_guests, :reservation_id, :inn_id, :room_id, :guest_id)
  end

end