module Api
  class InnsController < ApplicationController
    def list_available_inns
      if brand_name
        if find_inn(brand_name).present?
          render json: { inn: create_inn_response(find_inn(brand_name)) }, status: :ok
        else
          render json: { error: "Does not exist an inn with the name #{brand_name}." }, status: :ok 
        end
      else
        render json: { inns: Inn.where(active: true).map { |inn| create_inn_response(inn) } }, status: :ok
      end
    end

    def room_details
      if inn_id
        render json: { 
          total_rooms: find_rooms(inn_id).count,
          rooms: find_rooms(inn_id)
        }
      else
        render json: { error: "You should pass an inn_id to retrieve room details." }, status: :bad_request
      end
    end

    private

    def brand_name
      strong_params['inn']['brand_name']
    end

    def inn_id
      strong_params['room']['inn_id']
    end

    def find_rooms(inn_id)
      @rooms ||= Inn.find(inn_id).rooms
    end

    def find_inn(brand_name)
      @inn = Inn.find_by(brand_name: brand_name, active: true)
    end

    def create_room_response(room)
      {
        name: room.name,
        description: room.description,
        dimension: room.dimension,
        max_occupancy: room.max_occupancy,
        daily_rate: room.daily_rate,
        bathroom: room.bathroom,
        balcony: room.balcony,
        air_conditioning: room.air_conditioning,
        tv: room.tv,
        wardrobe: room.wardrobe,
        safe: room.safe,
        accessible: room.accessible
      }
    end

    def create_inn_response(inn)
      return unless inn

      {
        brand_name: inn.brand_name,
        contact_phone: inn.contact_phone,
        email: inn.email,
        full_address: inn.full_address,
        state: inn.state,
        city: inn.city,
        zip_code: inn.zip_code,
        description: inn.description,
        rooms_max: inn.rooms_max,
        pets_accepted: inn.pets_accepted,
        breakfast: inn.breakfast,
        camping: inn.camping,
        accessibility: inn.accessibility,
        policies: inn.policies,
        payment_methods: inn.payment_methods,
        check_in_time: inn.check_in_time,
        check_out_time: inn.check_out_time
      }
    end

    def strong_params
      params.permit(:inn => [:brand_name], :room => [:inn_id])
    end
  end
end
