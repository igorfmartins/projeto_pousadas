class ReservationsController < ApplicationController
    before_action :set_room, only: [:pre_save, :pre_confirmation, :new, :create, :confirmation, :my_stays]
    before_action :authenticate_guest!, only: [:new, :create, :confirmation, :ready, :destroy, :checkin]
  
    def pre_save   
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
      @reservation = Reservation.new(room: @room)
      @daily = @room.daily_rate
    end
  
    def create    
      @reservation = Reservation.new(reservation_params.merge(room: @room))
      @reservation.pre_status = 'pendente'
  
      if @reservation.available?      
        if @reservation.save
          redirect_to confirmation_inn_room_reservation_path(inn_id: @room.inn.id, room_id: @room.id, id: @reservation.id)
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
      @reservation = Reservation.find(params[:id])
      @room = @reservation.room
      @inn = @room.inn
    end
  
    def ready
      @reservation = Reservation.find(params[:id])
      @reservation.update(pre_status: 'confirmada')
      redirect_to root_path, notice: 'Reserva confirmada com sucesso!'
    end
  
    def my_reservations      
      @reservations = current_guest.reservations  
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
      @my_stays = current_user.inn.reservations
    end

    def my_active_stays
      @active_stays = current_user.inn.reservations.where(active_stay: true)
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
      @reservation = Reservation.find(params['reservation_id'])
      
      total_days = (@reservation.end_date - @reservation.start_date).to_i + 1
        checkout_date = Date.current
        @total_paid = calculate_total_paid(@reservation.start_date, checkout_date, total_days)
  
        @reservation.update(
          active_stay: false,
          checkout_datetime: Time.now,
          total_paid: @total_paid,
          payment_method: params[:payment_method]
        )
  
        if @reservation.rated?
          redirect_to finish_checkout_inn_path(@reservation.inn), notice: 'Estadia finalizada com sucesso!'
        else
          redirect_to new_reservation_rating_path(@reservation), notice: 'Por favor, avalie sua estadia.'
        end
    
      
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
  