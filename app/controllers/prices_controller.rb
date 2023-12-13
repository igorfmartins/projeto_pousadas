class PricesController < ApplicationController
    before_action :authenticate_user!
      
    def show
        @room = Room.find(params[:room_id])
        @price = Price.find(params[:id])
    end

    def new      
      @room = Room.find(params[:room_id])
      @price = Price.new
    end
  
    def create
      @room = Room.find(params[:room_id])
      @price = Price.new(price_params)  
      range_date_to_price = @price.start_date..@price.end_date
      available_prices = Price.where(room_id: @room.id)
      available_price = []  

      if available_prices.present?
        # Filtro todas os preços existentes e comparo cada um.
        available_prices.each do |price_date|
          range_already_reserved = price_date.start_date..price_date.end_date
          if range_date_to_price.overlaps?(range_already_reserved)
            available_price << true
          else
            available_price << false
          end
        end      
      else
        available_price << false
      end 
    
      if available_price.all?(false)        
        @price.save
          redirect_to root_path        
      else
        flash.now[:alert] = 'Ja existe um preço para esse período, não é permitido sobrepor preços.'
        render :new
      end  
    end
        
    def destroy
      @room = Room.find(params[:room_id])
      @price = Price.find(params[:id])
    
      if @price.destroy
        flash.now[:alert] = 'Preço removido com sucesso.'
        redirect_to root_path
      else
        flash.now[:alert] = 'Preço não foi removido.'
        redirect_to root_path
      end
    end
    
    private
  
    def price_params
      params.require(:price).permit(:start_date, :end_date, :room_id, :daily_rate)
    end    
end  