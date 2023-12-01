class RatingsController < ApplicationController

    def index
      room_id = params[:room_id]
      inn_id = params[:inn_id]  
      @ratings = Rating.joins(:room, :inn).where(rooms: { id: room_id }, inns: { id: inn_id }).all
    end
  
    def new
      @reservation = Reservation.find(params[:reservation_id])
      @rating = Rating.new
    end
  
    def create
      @reservation = Reservation.find(params[:reservation_id])
      @rating = Rating.new(rating_params.merge(reservation: @reservation))
  
      if @rating.save
        redirect_to my_reservations_path, notice: 'Avaliação enviada com sucesso.'
      else
        render :new
      end
    end
  
    private
  
    def rating_params
      params.require(:rating).permit(:rating, :review)
    end
end