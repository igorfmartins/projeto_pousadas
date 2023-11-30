class RatingsController < ApplicationController

    def index
      @inn = Inn.find(params[:inn_id])
      @ratings = @inn.ratings.order(created_at: :desc)
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