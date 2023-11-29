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
      if @price.save
        redirect_to root_path, notice: 'Preço adicionado com sucesso.'
      else
        flash[:notice] = 'Ja existe um preço para esse período, não é permitido sobrepor preços.'
        render 'new'
      end
    end  
    
    def destroy
      @room = Room.find(params[:room_id])
      @price = Price.find(params[:id])
    
      if @price.destroy
        redirect_to root_path, notice: 'Preço removido com sucesso.'
      else
        redirect_to root_path, notice: 'Preço não foi removido.'
      end
    end
    
    private
  
    def price_params
      params.require(:price).permit(:start_date, :end_date, :room_id, :daily_rate)
    end    
end  