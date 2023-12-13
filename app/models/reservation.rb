class Reservation < ApplicationRecord  
  belongs_to :guest
  belongs_to :room
  belongs_to :inn
  has_one :rating
  validates :start_date, :end_date, :number_of_guests, presence: true  
  before_create :generate_confirmation_code 
  

  def overdue_for_checkin?
    Date.current > start_date + 2.days
  end

  def checkin!
    update(active_stay: true, status:'check-in', checkin_datetime: Time.now)
  end

  def checkout!
    update(active_stay: true, status:'check-out', checkout_datetime: Time.now)
  end

  def cancel_by_owner
    return unless pending_checkin? && overdue_for_checkin?
    transaction do
      update(status: 'cancelada')
      reservation.update(status: 'disponivel')
    end
  end


  private

  def generate_confirmation_code
    self.confirmation_code = generate_unique_code
  end

  def generate_unique_code
    codigo = (1..8).map { rand(10) }.join
    return codigo
  end  
end
