require 'rails_helper'

describe 'Usuário não autenticado ' do
    
    it 'visualiza os quartos que a Pousada possui' do
        #Arrange
        owner = User.create!(email: 'joao@example.com', password: 'password')
        inn = Inn.create!(brand_name: 'Pousada Santuário', corporate_name: 'Athenas Dona Hotéis e Resorts Company',cnpj: '34567865432',
              contact_phone: '3187654325',email: 'seiyaseiyaseiya@cdz.com.br',full_address: 'Rua Bonita, 23',zip_code: '04256-222',state: 'PR',
              city: 'Curitiba',payment_methods: 'C/B e Pix',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
              user: owner)
        room1 = Room.create!(name: 'Quarto Aioros', dimension: '12', bathroom: true, max_occupancy:'4', available:true, inn_id: inn.id)       
        room2 = Room.create!(name: 'Quarto Mu', dimension: '8', description: 'A decoração com tons suaves e imagens estelares cria um ambiente celestial.',
                bathroom: true, max_occupancy:'4', available:true, inn_id: inn.id)  
        room3 = Room.create!(name: 'Quarto Camus', dimension: '110', bathroom: true, max_occupancy:'4', available:true, inn_id: inn.id)       
         
    
        
        #Act
        visit root_path
        click_on 'Pousada Santuário'
        
        #Assert
        expect(page).to have_content 'Quarto Mu'       
        expect(page).to have_content 'Quarto Aioros'        
        expect(page).to have_content 'Quarto Camus'    
        expect(page).to have_content 'Pousada Santuário'  
        expect(page).to have_content 'Aqui as informações e detalhes da Pousada.'
    end

    it 'procura detalhes em um quarto' do
        #Arrange
        owner = User.create!(email: 'joao@example.com', password: 'password')        
        inn = Inn.create!(brand_name: 'Pousada Santuário - Cavaleiros do Zodíaco',corporate_name: 'Athenas Dona Hotéis e Resorts',cnpj: '475896321',
            contact_phone: '9874512458',email: 'seiyaseiyaseiya@cdz.com.br',full_address: 'Av. das Doze Casas, 12',zip_code: '04256-222',state: 'RJ',
            city: 'Rio de Janeiro',payment_methods: 'C/B',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)
        room = Room.create!(name: 'Quarto Aioros', description: 'Lote vazio', dimension: '12', bathroom: true, max_occupancy:'4', available:true, inn_id: inn.id)       
        
        #Act
        visit root_path
        click_on 'Pousada Santuário - Cavaleiros do Zodíaco'
        click_on 'Quarto Aioros'
        
        #Assert
        expect(page).to have_content 'Detalhes do Quarto' 
        expect(page).to have_content 'Quarto Aioros'
        expect(page).to have_content 'Lote vazio'
        expect(page).to have_content 'Dimensão (m²): 12.0'
        expect(page).to have_content 'Capacidade Máxima de Hóspedes: 4'
    end 

    it 'não acha todos os detalhes em um quarto' do
        #Arrange
        owner = User.create!(email: 'joao@example.com', password: 'password')        
        inn = Inn.create!(brand_name: 'Pousada Santuário - Cavaleiros do Zodíaco',corporate_name: 'Athenas Dona Hotéis e Resorts',cnpj: '475896321',
            contact_phone: '9874512458',email: 'seiyaseiyaseiya@cdz.com.br',full_address: 'Av. das Doze Casas, 12',zip_code: '04256-222',state: 'RJ',
            city: 'Rio de Janeiro',payment_methods: 'C/B',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)
        room = Room.create!(name: 'Quarto Aioros', dimension: '12', bathroom: true, max_occupancy:'4', available:true, inn_id: inn.id)       
        
        #Act
        visit root_path
        click_on 'Pousada Santuário - Cavaleiros do Zodíaco'
        click_on 'Quarto Aioros'
        
        #Assert
        expect(page).to have_content 'Detalhes do Quarto' 
        expect(page).to have_content 'Quarto Aioros'
        expect(page).not_to have_content 'Lote vazio'
        expect(page).not_to have_content 'Aqui as informações e detalhes da Pousada.'
        expect(page).not_to have_content 'Email: seiyaseiyaseiya@cdz.com.br'
    end 

end