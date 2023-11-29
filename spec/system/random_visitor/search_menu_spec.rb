require 'rails_helper'

describe 'Usuário não autenticado usa o menu de busca ' do
    it 'procura por cidade' do
        #Arrange
        owner = User.create!(email: 'joao@example.com', password: 'password')        
        inn = Inn.create!(brand_name: 'Pousada Santuário - Cavaleiros do Zodíaco',corporate_name: 'Athenas Dona Hotéis e Resorts',cnpj: '475896321',
            contact_phone: '9874512458',email: 'seiyaseiyaseiya@cdz.com.br',full_address: 'Av. das Doze Casas, 12',zip_code: '04256-222',state: 'RJ',
            city: 'Rio de Janeiro',payment_methods: 'C/B',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)
        
        #Act
        visit root_path
        fill_in 'search_term', with: 'Rio de Janeiro'        
        click_on 'Buscar'        
        
        #Assert
        expect(page).to have_content 'Pousada Santuário - Cavaleiros do Zodíaco' 
    end 

    it 'procura por cidade errada' do
        #Arrange
        owner = User.create!(email: 'joao@example.com', password: 'password')        
        inn = Inn.create!(brand_name: 'Pousada Santuário - Cavaleiros do Zodíaco',corporate_name: 'Athenas Dona Hotéis e Resorts',cnpj: '475896321',
            contact_phone: '9874512458',email: 'seiyaseiyaseiya@cdz.com.br',full_address: 'Av. das Doze Casas, 12',zip_code: '04256-222',state: 'RJ',
            city: 'Rio de Janeiro',payment_methods: 'C/B',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)

        inn2 = Inn.create!(brand_name: 'Vila Oculta da Folha - Pousada Konoha',corporate_name: 'Dattebayo LTDA',cnpj: '4598741321',
            contact_phone: '9874512458',email: 'ninjutsu@gmail.com', description: 'Vila escondida dos ninjas do País do Fogo',full_address: 'Av Tapajós, 2527',zip_code: '04256-222',state: 'AM',
            city: 'Manaus',payment_methods: 'C/B e Pix',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)
        inn3 = Inn.create!(brand_name: 'Pousada Fluxo São Paulo',corporate_name: 'Cidade Grande Cansativa Corporate',cnpj: '475687321',
            contact_phone: '9874512458',email: 'ninjutsu@gmail.com',full_address: 'Av Tapajós, 2527',zip_code: '04256-222',state: 'SP',
            city: 'São Paulo',payment_methods: 'C/B e Pix',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)
        
        #Act
        visit root_path
        fill_in 'search_term', with: 'Rio de Janeiro'        
        click_on 'Buscar'        
        
        #Assert
        expect(page).to have_content 'Pousada Santuário - Cavaleiros do Zodíaco' 
        expect(page).not_to have_content 'Pousada Fluxo São Paulo'
        expect(page).not_to have_content 'Vila Oculta da Folha - Pousada Konoha' 
    end 

    it 'procura por nome de pousada' do
        #Arrange
        owner = User.create!(email: 'joao@example.com', password: 'password')        
        inn = Inn.create!(brand_name: 'Pousada Santuário - Cavaleiros do Zodíaco',corporate_name: 'Athenas Dona Hotéis e Resorts',cnpj: '475896321',
            contact_phone: '9874512458',email: 'seiyaseiyaseiya@cdz.com.br',full_address: 'Av. das Doze Casas, 12',zip_code: '04256-222',state: 'RJ',
            city: 'Rio de Janeiro',payment_methods: 'C/B',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)

        inn2 = Inn.create!(brand_name: 'Vila Oculta da Folha - Pousada Konoha',corporate_name: 'Dattebayo LTDA',cnpj: '4598741321',
            contact_phone: '9874512458',email: 'ninjutsu@gmail.com', description: 'Vila escondida dos ninjas do País do Fogo',full_address: 'Av Tapajós, 2527',zip_code: '04256-222',state: 'AM',
            city: 'Manaus',payment_methods: 'C/B e Pix',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)
        inn3 = Inn.create!(brand_name: 'Pousada Fluxo São Paulo',corporate_name: 'Cidade Grande Cansativa Corporate',cnpj: '475687321',
            contact_phone: '9874512458',email: 'ninjutsu@gmail.com',full_address: 'Av Tapajós, 2527',zip_code: '04256-222',state: 'SP',
            city: 'São Paulo',payment_methods: 'C/B e Pix',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)
        
        #Act
        visit root_path
        fill_in 'search_term', with: 'Vila Oculta da Folha - Pousada Konoha'        
        click_on 'Buscar'        
        
        #Assert
        expect(page).to have_content 'Vila Oculta da Folha - Pousada Konoha' 
        expect(page).not_to have_content 'Pousada Fluxo São Paulo'
        expect(page).not_to have_content 'Pousada Santuário - Cavaleiros do Zodíaco' 
    end

    it 'procura por nome de pousada em outra tela' do
        #Arrange
        owner = User.create!(email: 'joao@example.com', password: 'password')        
        inn = Inn.create!(brand_name: 'Pousada Santuário - Cavaleiros do Zodíaco',corporate_name: 'Athenas Dona Hotéis e Resorts',cnpj: '475896321',
            contact_phone: '9874512458',email: 'seiyaseiyaseiya@cdz.com.br',full_address: 'Av. das Doze Casas, 12',zip_code: '04256-222',state: 'RJ',
            city: 'Rio de Janeiro',payment_methods: 'C/B',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)

        inn2 = Inn.create!(brand_name: 'Vila Oculta da Folha - Pousada Konoha',corporate_name: 'Dattebayo LTDA',cnpj: '4598741321',
            contact_phone: '9874512458',email: 'ninjutsu@gmail.com', description: 'Vila escondida dos ninjas do País do Fogo',full_address: 'Av Tapajós, 2527',zip_code: '04256-222',state: 'AM',
            city: 'Manaus',payment_methods: 'C/B e Pix',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)
        inn3 = Inn.create!(brand_name: 'Pousada Fluxo São Paulo',corporate_name: 'Cidade Grande Cansativa Corporate',cnpj: '475687321',
            contact_phone: '9874512458',email: 'ninjutsu@gmail.com',full_address: 'Av Tapajós, 2527',zip_code: '04256-222',state: 'SP',
            city: 'São Paulo',payment_methods: 'C/B e Pix',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)
        
        #Act
        visit root_path
        click_on 'Pousada Fluxo São Paulo'
        fill_in 'search_term', with: 'Vila Oculta da Folha - Pousada Konoha'        
        click_on 'Buscar'        
        
        #Assert
        expect(page).to have_content 'Vila Oculta da Folha - Pousada Konoha' 
        expect(page).not_to have_content 'Pousada Fluxo São Paulo'
        expect(page).not_to have_content 'Pousada Santuário - Cavaleiros do Zodíaco' 
    end

    it 'procura por palavra de cidade no menu de busca' do
        #Arrange
        owner = User.create!(email: 'joao@example.com', password: 'password')        
        inn = Inn.create!(brand_name: 'Pousada Santuário - Cavaleiros do Zodíaco',corporate_name: 'Athenas Dona Hotéis e Resorts',cnpj: '475896321',
            contact_phone: '9874512458',email: 'seiyaseiyaseiya@cdz.com.br',full_address: 'Av. das Doze Casas, 12',zip_code: '04256-222',state: 'RJ',
            city: 'Rio de Janeiro',payment_methods: 'C/B',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)

        inn2 = Inn.create!(brand_name: 'Vila Oculta da Folha - Pousada Konoha',corporate_name: 'Dattebayo LTDA',cnpj: '4598741321',
            contact_phone: '9874512458',email: 'ninjutsu@gmail.com', description: 'Vila escondida dos ninjas do País do Fogo',full_address: 'Av Tapajós, 2527',zip_code: '04256-222',state: 'AM',
            city: 'Manaus',payment_methods: 'C/B e Pix',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)
        inn3 = Inn.create!(brand_name: 'Pousada Fluxo São Paulo',corporate_name: 'Cidade Grande Cansativa Corporate',cnpj: '475687321',
            contact_phone: '9874512458',email: 'ninjutsu@gmail.com',full_address: 'Av Tapajós, 2527',zip_code: '04256-222',state: 'SP',
            city: 'São Paulo',payment_methods: 'C/B e Pix',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)
        
        #Act
        visit root_path
        fill_in 'search_term', with: 'Paulo'        
        click_on 'Buscar'        
        
        #Assert
        expect(page).to have_content 'Pousada Fluxo São Paulo' 
        expect(page).not_to have_content 'Vila Oculta da Folha - Pousada Konoha'
        expect(page).not_to have_content 'Pousada Santuário - Cavaleiros do Zodíaco' 
    end    

    it 'procura por palavra de pousada em outra tela' do
        #Arrange
        owner = User.create!(email: 'joao@example.com', password: 'password')        
        inn = Inn.create!(brand_name: 'Pousada Santuário - Cavaleiros do Zodíaco',corporate_name: 'Athenas Dona Hotéis e Resorts',cnpj: '475896321',
            contact_phone: '9874512458',email: 'seiyaseiyaseiya@cdz.com.br',full_address: 'Av. das Doze Casas, 12',zip_code: '04256-222',state: 'RJ',
            city: 'Rio de Janeiro',payment_methods: 'C/B',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)

        inn2 = Inn.create!(brand_name: 'Vila Oculta da Folha - Pousada Konoha',corporate_name: 'Dattebayo LTDA',cnpj: '4598741321',
            contact_phone: '9874512458',email: 'ninjutsu@gmail.com', description: 'Vila escondida dos ninjas do País do Fogo',full_address: 'Av Tapajós, 2527',zip_code: '04256-222',state: 'AM',
            city: 'Manaus',payment_methods: 'C/B e Pix',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)
        inn3 = Inn.create!(brand_name: 'Pousada Fluxo São Paulo',corporate_name: 'Cidade Grande Cansativa Corporate',cnpj: '475687321',
            contact_phone: '9874512458',email: 'ninjutsu@gmail.com',full_address: 'Av Tapajós, 2527',zip_code: '04256-222',state: 'SP',
            city: 'São Paulo',payment_methods: 'C/B e Pix',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)
        
        #Act
        visit root_path
        click_on 'Pousada Fluxo São Paulo'
        fill_in 'search_term', with: 'Konoha'        
        click_on 'Buscar'        
        
        #Assert
        expect(page).to have_content 'Vila Oculta da Folha - Pousada Konoha' 
        expect(page).not_to have_content 'Pousada Fluxo São Paulo'
        expect(page).not_to have_content 'Pousada Santuário - Cavaleiros do Zodíaco' 
    end    
end