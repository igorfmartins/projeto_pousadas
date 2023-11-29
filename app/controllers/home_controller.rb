class HomeController < ApplicationController
    def index
      @latest_inns = Inn.order(created_at: :desc).limit(3)
      @other_inns = Inn.where.not(id: @latest_inns.map(&:id)).where(active: true).order(:brand_name)
      @cities_all = Inn.pluck(:city).uniq
    end
  
    def show
        
    end
  
    def all
      @selected_city = params[:city]
      @pousadas_na_cidade = Inn.where("city LIKE ?", "%#{@selected_city}%").where(active: true)
    end    
end
  
  