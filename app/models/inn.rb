class Inn < ApplicationRecord
    belongs_to :user
    has_many :rooms
    validates :brand_name, :corporate_name, :cnpj, :contact_phone, :email, :full_address, :state, :city, :zip_code, presence: true
  
    def self.search(term)
      if term
        where('brand_name LIKE ? OR city LIKE ?', "%#{term}%", "%#{term}%").order(:brand_name)
      else
        all.order(:brand_name)
      end
    end  
end
  