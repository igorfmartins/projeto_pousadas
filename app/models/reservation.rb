class Reservation < ApplicationRecord
  attr_accessor :rating, :review, :start_date, :end_date, :number_of_guests
  belongs_to :room
  belongs_to :guest
  belongs_to :inn
  validates :start_date, :end_date, :number_of_guests, presence: true
  validate :available?
  before_create :generate_confirmation_code
 
  def available?
    start_date = self.start_date
    end_date = self.end_date
        
    if start_date > end_date
      return "A data de checkin deve ser menor que a data de checkout."
    end

    range_date_to_rent = start_date..end_date
    available_reservations = Reservation.where(room_id: self.room_id)
    available_dates = []

    available_reservations.each do |reservations_date|
      range_already_reserved = reservations_date.start_date..reservations_date.end_date
      if range_date_to_rent.overlaps?(range_already_reserved)
        available_dates << false
      else
        available_dates << true
      end
    end

    if available_dates.all?
      room = Room.find(self.room_id)
      if room.max_occupancy < self.number_of_guests.to_i
        return "Esse quarto não possui capacidade para #{self.number_of_guests} hóspedes."      
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

  def calculate_partial_day_payment
    partial_day_payment = @reservation.room.daily_rate / 2
    # Se o check-out ocorrer depois do meio-dia, cobre o dia parcial do check-out
    checkout_hour > 12 ? partial_day_payment : 0
end

  def calculate_total_paid(start_date, checkout_date, total_days)
    checkout_time = Time.now
    checkout_time = Time.parse('12:00 PM') if checkout_time.hour > 12
  
    if checkout_date == Date.current && checkout_time.hour < 12
      # Se o check-out ocorrer antes do horário padrão, cobre a diária completa
      total_paid = @reservation.room.daily_rate * total_days
    else
      # Caso contrário, calcule o valor proporcional
      total_paid = @reservation.room.daily_rate * (total_days - 1) + calculate_partial_day_payment(checkout_time.hour)
    end
  
    total_paid
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
