require 'rails_helper'

describe 'Usuário não autenticado ' do
    it 'encontra todas pousadas cadastradas na tela inicial' do
        #Arrange
        owner = User.create!(email: 'joao@example.com', password: 'password')
        inn = Inn.create!(brand_name: 'Pousada do João',corporate_name: 'Pousada Joao Corporativo LTDA',cnpj: '34567865432',
            contact_phone: '3187654325',email: 'pousadajoao@outlook.com',full_address: 'Rua Bonita, 23',zip_code: '04256-222',state: 'PR',
            city: 'Curitiba',payment_methods: 'C/B e Pix',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)
        inn2 = Inn.create!(brand_name: 'Pousada Santuário',corporate_name: 'Athenas Dona Hotéis e Resorts',cnpj: '475896321',
            contact_phone: '9874512458',email: 'seiyaseiyaseiya@cdz.com.br',full_address: 'Av. das Doze Casas, 12',zip_code: '04256-222',state: 'RJ',
            city: 'Rio de Janeiro',payment_methods: 'C/B',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)
        inn3 = Inn.create!(brand_name: 'Pousada Alameda dos Anjos',corporate_name: 'Zordon Pousadas LTDA',cnpj: '475556321',
            contact_phone: '9874512458',email: 'horademorfar@gmail.com',full_address: 'Alameda dos Anjos, 256',zip_code: '04256-222',state: 'SP',
            city: 'São Paulo',payment_methods: 'C/B e Pix',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)
        inn4 = Inn.create!(brand_name: 'Vila Oculta da Folha - Pousada Konoha',corporate_name: 'Dattebayo LTDA',cnpj: '4598741321',
            contact_phone: '9874512458',email: 'ninjutsu@gmail.com',full_address: 'Av Tapajós, 2527',zip_code: '04256-222',state: 'AM',
            city: 'Manaus',payment_methods: 'C/B e Pix',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)
        inn5 = Inn.create!(brand_name: 'Pousada Fluxo São Paulo',corporate_name: 'Cidade Grande Cansativa Corporate',cnpj: '475687321',
            contact_phone: '9874512458',email: 'ninjutsu@gmail.com',full_address: 'Av Tapajós, 2527',zip_code: '04256-222',state: 'SP',
            city: 'São Paulo',payment_methods: 'C/B e Pix',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)
        
        #Act
        visit root_path
        
        #Assert
        expect(page).to have_content 'Pousada Alameda dos Anjos- São Paulo'
        expect(page).to have_content 'Vila Oculta da Folha - Pousada Konoha- Manaus'
        expect(page).to have_content 'Pousada Fluxo São Paulo- São Paulo'
        expect(page).to have_content 'Pousada do João - Curitiba'
        expect(page).to have_content 'Pousada Santuário - Rio de Janeiro'        
    end

    it 'encontra detalhes da pousada selecionada' do
        #Arrange
        owner = User.create!(email: 'joao@example.com', password: 'password')        
        inn = Inn.create!(brand_name: 'Pousada Alameda dos Anjos',corporate_name: 'Zordon Pousadas LTDA',cnpj: '475556321',
            contact_phone: '9874512458',email: 'horademorfar@gmail.com',full_address: 'Alameda dos Anjos, 256',zip_code: '04256-222',state: 'SP',
            city: 'São Paulo',payment_methods: 'C/B e Pix',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
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
        click_on 'Vila Oculta da Folha - Pousada Konoha'
        
        #Assert
        expect(page).to have_content 'Vila Oculta da Folha - Pousada Konoha'
        expect(page).to have_content 'Aqui as informações e detalhes da Pousada.'
        expect(page).to have_content 'Telefone: 9874512458'
        expect(page).to have_content 'Email: ninjutsu@gmail.com'
        expect(page).to have_content 'Endereço: Av Tapajós, 2527'
        expect(page).to have_content 'Métodos de Pagamento: C/B e Pix'        
    end

    it 'clica no nome de uma cidade para filtrar uma busca' do
        #Arrange
        owner = User.create!(email: 'joao@example.com', password: 'password')
        inn = Inn.create!(brand_name: 'Pousada do João',corporate_name: 'Pousada Joao Corporativo LTDA',cnpj: '34567865432',
            contact_phone: '3187654325',email: 'pousadajoao@outlook.com',full_address: 'Rua Bonita, 23',zip_code: '04256-222',state: 'PR',
            city: 'Curitiba',payment_methods: 'C/B e Pix',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)
        inn2 = Inn.create!(brand_name: 'Pousada Santuário',corporate_name: 'Athenas Dona Hotéis e Resorts',cnpj: '475896321',
            contact_phone: '9874512458',email: 'seiyaseiyaseiya@cdz.com.br',full_address: 'Av. das Doze Casas, 12',zip_code: '04256-222',state: 'SP',
            city: 'São Paulo',payment_methods: 'C/B',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)
        inn3 = Inn.create!(brand_name: 'Pousada Alameda dos Anjos',corporate_name: 'Zordon Pousadas LTDA',cnpj: '475556321',
            contact_phone: '9874512458',email: 'horademorfar@gmail.com',full_address: 'Alameda dos Anjos, 256',zip_code: '04256-222',state: 'SP',
            city: 'São Paulo',payment_methods: 'C/B e Pix',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)
        inn4 = Inn.create!(brand_name: 'Vila Oculta da Folha - Pousada Konoha',corporate_name: 'Dattebayo LTDA',cnpj: '4598741321',
            contact_phone: '9874512458',email: 'ninjutsu@gmail.com',full_address: 'Av Tapajós, 2527',zip_code: '04256-222',state: 'AM',
            city: 'Manaus',payment_methods: 'C/B e Pix',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)
        inn5 = Inn.create!(brand_name: 'Pousada Fluxo São Paulo',corporate_name: 'Cidade Grande Cansativa Corporate',cnpj: '475687321',
            contact_phone: '9874512458',email: 'ninjutsu@gmail.com',full_address: 'Av Tapajós, 2527',zip_code: '04256-222',state: 'SP',
            city: 'São Paulo',payment_methods: 'C/B e Pix',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),active: true,
            user: owner)
        
        #Act
        visit root_path
        click_on 'São Paulo'
        
        #Assert
        expect(page).to have_content 'Pousada Alameda dos Anjos'        
        expect(page).to have_content 'Pousada Fluxo São Paulo'        
        expect(page).to have_content 'Pousada Santuário'    
        expect(page).not_to have_content 'Vila Oculta da Folha - Pousada Konoha- Manaus'    
    end
end