class Reservation < ApplicationRecord
  attr_accessor :rating, :review
  belongs_to :room
  belongs_to :guest
  belongs_to :inn
  validates :start_date, :end_date, :number_of_guests, presence: true
  validate :available?
  before_create :generate_confirmation_code
  
  def available?
    conflicting_reservations = room.reservations.where(
      "(start_date < ? AND end_date > ?) OR (start_date < ? AND end_date > ?)",
      end_date, start_date, start_date, end_date
    )
    number_of_guests_ok = conflicting_reservations.sum(:number_of_guests) + number_of_guests <= room.max_occupancy
    !conflicting_reservations.exists? && number_of_guests_ok
  end
  
  def pending_checkin?
    pre_status == 'pendente'
  end
  
  def checkin_allowed?
    pending_checkin? && Date.current >= start_date
  end

  def overdue_for_checkin?
    Date.current > start_date + 2.days
  end

  def checkin!
    update(active_stay: true, checkin_datetime: Time.now)
  end

  def active_stay?
    active_stay
  end  

  def cancel_by_owner
    return unless pending_checkin? && overdue_for_checkin?
    transaction do
      update(pre_status: 'cancelada')      
      room.update(status: 'disponivel')
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
