# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

p "############### INITIALIZING SEEDS ###############"

# Proprietários
3.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "123123"
  )
end

# Visitantes
3.times do
  Guest.create!(
    full_name: Faker::Name.name,
    cpf: Faker::Number.between(from: 10000000000, to: 99999999999),
    email: Faker::Internet.email,
    password: "123123"
  )
end

# Pousadas
15.times do
  Inn.create!(
    brand_name: Faker::Commerce.brand,
    corporate_name: Faker::Commerce.vendor,
    cnpj: Faker::Number.between(from: 10000000000000, to: 99999999999999),
    contact_phone: Faker::Number.between(from: 100000000, to: 999999999),
    email: Faker::Internet.email,
    full_address: "Av. dos códigos, #{rand(1..99)}",
    state: ['São Paulo', 'Rio de Janeiro', 'Bahia', 'Amazonas', 'Paraíba'].sample,
    city: ['Araraquara', 'Caxias do Sul', 'Salvador', 'Manaus'].sample,
    zip_code: Faker::Number.between(from: 10000000, to: 99999999),
    description: Faker::Quote.most_interesting_man_in_the_world,
    rooms_max: rand(1..9),
    pets_accepted: true,
    breakfast: true,
    camping: true,
    accessibility: 'Yep',
    policies: 'N/A',
    payment_methods: ['Crédito', 'Débito', 'Pix', 'Dinheiro'].sample,
    check_in_time: Time.parse("12:00"),
    check_out_time: Time.parse("14:00"),
    active: true,
    user_id: User.all.sample.id
  )
end

# Quartos
60.times do
  Room.create!(
    name: Faker::Artist.name,
    description: Faker::ChuckNorris.fact,
    dimension: rand(4..50),
    max_occupancy: rand(4..8),
    daily_rate: rand(150..1000),
    bathroom: true,
    balcony: true,
    air_conditioning: true,
    tv: true,
    wardrobe: true,
    safe: true,
    accessible: true,
    available: true,
    inn_id: Inn.all.sample.id,
  )
end

# Reservas
20.times do
  room_id = Room.all.sample.id

  Reservation.create!(
    start_date: Date.parse("2023-11-#{rand(1..30)}"),
    end_date: Date.parse("2023-12-#{rand(1..31)}"),
    number_of_guests: rand(1..4),
    status: "confirmado",
    room_id: room_id,
    guest_id: Guest.all.sample.id,
    pre_status: "confirmado",
    confirmation_code: Faker::Number.between(from: 10000000, to: 99999999),
    inn_id: Room.find(room_id).inn.id,
    active_stay: true,
    checkin_datetime: Time.parse("13:00"),
  )
end

p "############### SEEDS COMPLETED ###############"