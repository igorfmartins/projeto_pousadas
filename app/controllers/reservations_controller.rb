class ReservationsController < ApplicationController
  before_action :set_room, only: [:pre_save, :new, :create, :confirmation]
  before_action :authenticate_guest!, only: [:new, :create, :confirmation, :ready, :destroy, :checkin]

  def pre_save
    @room
    session[:non_user] = {
      start_date: params[:start_date],
      end_date: params[:end_date],
      number_of_guests: params[:number_of_guests]
    }
    redirect_to pre_confirmation_inn_room_reservation_path(inn_id: @room.inn.id, room_id: @room.id)
  end

  def pre_confirmation
    unless user_signed_in?
      return redirect_to new_guest_registration_url
    end
    existing_reservations = Reservation.where(
      room_id: @room.id,
      start_date: session[:non_user][:start_date],
      end_date: session[:non_user][:end_date]
    )

    if existing_reservations.empty?
      flash.now[:alert] = 'Este quarto está livre para as datas escolhidas.'
      redirect_to confirmation_inn_room_reservation_path
    else
      flash.now[:alert] = 'Este quarto já está reservado para as datas escolhidas.'
      render 'pre_save'
    end
  end

  def new
    @room
    @reservation = Reservation.new(room: @room)
    @daily = @room.daily_rate    
  end

  def create
    @room 
    @reservation = Reservation.new(reservation_params.merge(room: @room))
    @reservation.pre_status = 'pendente'
  
    if @reservation.available?
      if @reservation.save
        @reservation_params = params["reservation"]
        route = route_params = {
          inn_id: params["reservation"]["inn_id"],
          room_id: params["reservation"]["room_id"],
          reservation_id: @reservation.id,
          start_date: params["reservation"]["start_date"],
          end_date: params["reservation"]["end_date"],
          number_of_guests: params["reservation"]["number_of_guests"]
        }       
        redirect_to inn_room_reservation_confirmation_path(route)
      else
        flash.now[:alert] = 'Erro ao salvar a reserva.'
        render :new
      end
    else
      flash.now[:alert] = 'Este quarto já está reservado para as datas escolhidas.'
      render :new
    end
  end

  def confirmation
    @reservation_params = {inn_id: params["inn_id"], room_id: params["room_id"], reservation_id: params["reservation_id"],
                          start_date: params["start_date"], end_date: params["end_date"],number_of_guests: params["number_of_guests"]}
    @reservation = Reservation.find(params["reservation_id"])   
    @room = @reservation.room
    @inn = @room.inn
  end

  def ready
    @reservation = Reservation.find(params["reservation_id"])
    @reservation.update(pre_status: 'confirmada')
    redirect_to root_path, notice: 'Reserva confirmada com sucesso!'
  end

  def my_reservations      
    @reservations = Reservation.find(params["guest_id"])
    if @reservations.empty?
      flash.now[:notice] = 'Você não tem reservas.'
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.deletable?
      @reservation.destroy
      redirect_to reservations_path, notice: 'Reserva excluída com sucesso.'
    else
      redirect_to reservations_path, alert: 'Não é possível excluir a reserva nesta fase. Entre em contato conosco.'
    end
  end

  def my_stays
    @inn = current_user.inn.id 
    @my_stays = Reservation.where(inn_id: params["inn_id"], active_stay: true)  
  end
    
  def my_active_stays
    @active_stays = Reservation.where(inn_id: params["inn_id"], pre_status: 'confirmada')   
  end  
 
  def checkin
    @reservation = Reservation.find(params[:id])
    if @reservation.checkin_allowed?
      @reservation.checkin!
      redirect_to my_inn_reservations_path, notice: 'Check-in realizado com sucesso!'
    else
      redirect_to my_inn_reservations_path, alert: 'Check-in não permitido para esta reserva.'
    end
  end    

  def finish_stay
    @reservation = Reservation.find(params["reservation_id"])
    start_day = @reservation.attributes['start_date'].strftime("%Y%m%d").to_i
    end_day = @reservation.attributes['end_date'].strftime("%Y%m%d").to_i
    checkout_date = Date.current.strftime("%Y%m%d").to_i
    total_days = (checkout_date - start_day)
    room_id = @reservation.attributes['room_id']
    room = Room.find(room_id)
    rate = room.daily_rate

    @total_paid = total_days * rate * @reservation.attributes['number_of_guests'].to_i    
    @reservation.active_stay = false
    @reservation.checkout_datetime = Time.now
    @reservation.total_paid = @total_paid        
    @reservation.save
    redirect_to root_path, alert: 'Check-out realizado.'
  end   

  def finish_checkout

  end

  private

  def set_room
    @room = Room.find(params['room_id'])
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :number_of_guests, :room_id, :guest_id, :inn_id)
  end

  def cancel_if_not_checked_in
    @all_my_reservations.each do |reservation|
      if reservation.pending_checkin? && reservation.overdue_for_checkin?
        reservation.cancel_by_owner
      end
    end
  end 
end
