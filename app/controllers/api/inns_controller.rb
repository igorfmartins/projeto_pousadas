module Api
    class InnsController < ApplicationController
      def list_available_inns
        if brand_name
          render json: { inn: create_response(find_inn(brand_name)) }, status: :ok
        else
          render json: { inns: Inn.where(active: true).map { |inn| create_response(inn) } }, status: :ok
        end
      end
        
      private
  
      def brand_name
        params['brand_name']
      end
  
      def find_inn(brand_name)
        Inn.find_by(brand_name: brand_name, active: true)
      end
  
      def create_response(inn)
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
    end
end