require 'rails_helper'

describe 'User edita um quarto' do
    it 'com sucesso' do
        #Arrange
        owner = User.create!(email: 'joao@example.com', password: 'password')
        inn = Inn.create!(brand_name: 'Pousada do João',corporate_name: 'Pousada Joao Corporativo LTDA',cnpj: '34567865432',
            contact_phone: '3187654325',email: 'pousadajoao@outlook.com',full_address: 'Rua Bonita, 23',zip_code: '04256-222',
            state: 'PR',city: 'Curitiba',payment_methods: 'C/B e Pix',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),
            user: owner)
            
        #Act
        visit root_path
        click_on 'Faça o Login Proprietário'                       
        fill_in 'E-mail', with: 'joao@example.com'
        fill_in 'Senha', with: 'password'
        click_on 'Log in'
        click_on 'Pousada do João'
        click_on 'Cadastrar Quarto'
        fill_in 'Nome', with: 'Quarto fofo'
        fill_in 'Descrição', with: 'Um quarto grande para você e seus amigos.'
        fill_in 'Dimensão', with: 15
        fill_in 'Ocupação Máxima', with: 5
        check 'Banheiro'
        check 'Disponível'
        click_on 'Cadastrar Quarto'
        click_on 'Editar Quarto' 
        fill_in 'Nome', with: 'Quarto Novo'
        fill_in 'Descrição', with: 'Um quarto que ficou menor.'
        fill_in 'Dimensão', with: 8
        fill_in 'Ocupação Máxima', with: 2
        click_on 'Cadastrar Quarto'

        #Arrange
        expect(page).to have_content 'Detalhes do Quarto' 
        expect(page).to have_content 'Um quarto que ficou menor.'
        expect(page).to have_content 'Quarto Novo' 
        expect(page).to have_content 'Capacidade Máxima de Hóspedes: 2'        
    end

    it 'com recebe erros de cadastro' do
        #Arrange
        owner = User.create!(email: 'joao@example.com', password: 'password')
        inn = Inn.create!(brand_name: 'Pousada do João',corporate_name: 'Pousada Joao Corporativo LTDA',cnpj: '34567865432',
            contact_phone: '3187654325',email: 'pousadajoao@outlook.com',full_address: 'Rua Bonita, 23',zip_code: '04256-222',state: 'PR',
            city: 'Curitiba',payment_methods: 'C/B e Pix',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),
            user: owner)
          
        #Act
        visit root_path
        click_on 'Faça o Login Proprietário'                       
        fill_in 'E-mail', with: 'joao@example.com'
        fill_in 'Senha', with: 'password'
        click_on 'Log in'
        click_on 'Pousada do João'
        click_on 'Cadastrar Quarto'
        fill_in 'Nome', with: 'Quarto fofo'
        fill_in 'Descrição', with: 'Um quarto grande para você e seus amigos.'
        fill_in 'Dimensão', with: 15
        fill_in 'Ocupação Máxima', with: 5
        check 'Banheiro'
        check 'Disponível'
        click_on 'Cadastrar Quarto'
        click_on 'Editar Quarto' 
        fill_in 'Nome', with: ''
        fill_in 'Descrição', with: 'Um quarto que ficou menor.'
        fill_in 'Dimensão', with: ''
        fill_in 'Ocupação Máxima', with: 2
        click_on 'Cadastrar Quarto'

        #Arrange
        expect(page).to have_content 'Ops! Houve alguns problemas com o cadastro da pousada:'
        expect(page).to have_content 'Editar Quarto' 
        expect(page).to have_content 'Nome não pode ficar em branco'
        expect(page).to have_content 'Dimensão não pode ficar em branco' 
        expect(page).to have_content 'Quarto não atualizado.'
    end

    it 'atualiza o quarto como indiponível' do
        #Arrange
        owner = User.create!(email: 'joao@example.com', password: 'password')
        inn = Inn.create!(brand_name: 'Pousada do João',corporate_name: 'Pousada Joao Corporativo LTDA',cnpj: '34567865432',
            contact_phone: '3187654325',email: 'pousadajoao@outlook.com',full_address: 'Rua Bonita, 23',zip_code: '04256-222',state: 'PR',
            city: 'Curitiba',payment_methods: 'C/B e Pix',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),
            user: owner)
          
        #Act
        visit root_path
        click_on 'Faça o Login Proprietário'                       
        fill_in 'E-mail', with: 'joao@example.com'
        fill_in 'Senha', with: 'password'
        click_on 'Log in'
        click_on 'Pousada do João'
        click_on 'Cadastrar Quarto'
        fill_in 'Nome', with: 'Quarto fofo'
        fill_in 'Descrição', with: 'Um quarto grande para você e seus amigos.'
        fill_in 'Dimensão', with: 15
        fill_in 'Ocupação Máxima', with: 5
        check 'Banheiro'
        check 'Disponível'
        click_on 'Cadastrar Quarto'
        click_on 'Editar Quarto' 
        fill_in 'Nome', with: 'Quarto Novo'
        fill_in 'Descrição', with: 'Um quarto que ficou menor.'
        fill_in 'Dimensão', with: 8
        fill_in 'Ocupação Máxima', with: 2
        uncheck 'Disponível'
        click_on 'Cadastrar Quarto'
        click_on 'Voltar'
        click_on 'Pousada do João'

        #Arrange
        expect(page).not_to have_content 'Quarto Novo'
        expect(page).to have_link 'Editar Pousada'
    end  
end
