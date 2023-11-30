module Api
    class ReservationsController < ApplicationController
      def verify_reservation
        if strong_params['end_date'].to_date < strong_params['start_date'].to_date
          return render json: { error: "End date must be greater than the start date."}
        end
  
        range_date_to_rent = strong_params['start_date'].to_date..strong_params['end_date'].to_date
        available_reservations = Reservation.where(room_id: strong_params['room_id'])
        available_dates = []
  
        available_reservations.each do |reservations_date|
          range_already_reserved = reservations_date.start_date..reservations_date.end_date
  
          if range_date_to_rent.overlaps?(range_already_reserved)
            available_dates << false
          else
            available_dates << true
          end
        end
  
        if available_dates.all?
          if room.max_occupancy >= strong_params['number_of_guests']
            render json: { 
              reservation_details: {
                status: "success!",
                start_date: strong_params['start_date'],
                end_date: strong_params['end_date'],
                number_of_guests: strong_params['number_of_guests'],
                total_price: room.daily_rate * range_date_to_rent.count * strong_params['number_of_guests']
              } 
            }
          else
            render json: { error: "This room cannot have more than #{room.max_occupancy} guests."}
          end
        else
          render json: { error: "The selected date range is already booked/reserved." }
        end
      end
  
      private
  
      def room
        @room = Room.find(strong_params['room_id'])
      end
  
      def strong_params
        params.require(:reservation).permit(:room_id, :start_date, :end_date, :number_of_guests)
      end
    end
  end