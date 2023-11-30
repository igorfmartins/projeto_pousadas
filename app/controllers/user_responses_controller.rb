class UserResponsesController < ApplicationController
    before_action :authenticate_user!
  
    def new
      @rating = Rating.find(params[:rating_id])
      @user_response = UserResponse.new
    end
  
    def create
      @rating = Rating.find(params[:rating_id])
      @user_response = UserResponse.new(user_response_params.merge(rating: @rating))
  
      if @user_response.save
        redirect_to inn_ratings_path, notice: 'Resposta enviada com sucesso.'
      else
        render :new
      end
    end
  
    private
  
    def user_response_params
      params.require(:user_response).permit(:response)
    end
  end