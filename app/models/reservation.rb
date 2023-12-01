class Reservation < ApplicationRecord
  belongs_to :room
  belongs_to :guest
  belongs_to :inn
  validates :start_date, :end_date, :number_of_guests, presence: true
  validate :available?
  before_create :generate_confirmation_code
 
  def available?    
    start_date = self.start_date
    end_date = self.end_date      
    number = self.number_of_guests  
    range_date_to_rent = start_date..end_date
    available_reservations = Reservation.where(room_id: self.room_id)
    available_reservations
    available_dates = []    

    if available_reservations.present?
      available_reservations.each do |reservations_date|
        range_already_reserved = reservations_date.start_date..reservations_date.end_date
        if range_date_to_rent.overlaps?(range_already_reserved)
          available_dates << true
        else
          available_dates << false
        end
      end
    else
      available_dates << false
    end 
    if available_dates.all?(false)      
      
      room = Room.find(self.room_id)    
      if room.max_occupancy < self.number_of_guests.to_i       
        return "Esse quarto não possui capacidade para #{self.number_of_guests} hóspedes."
      else       
        return true, start_date, end_date, number_of_guests
      end
    else
      return "O período ja esta reservado."
    end
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

  def cancel_by_owner
    return unless pending_checkin? && overdue_for_checkin?
    transaction do
      update(pre_status: 'cancelada')
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
