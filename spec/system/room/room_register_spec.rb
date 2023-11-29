require 'rails_helper'

describe 'Proprietário cadastra um quarto' do
    it 'com sucesso' do
        #Arrange
        owner = User.create!(email: 'joao@example.com', password: 'password')
        inn = Inn.create!(brand_name: 'Pousada do João',corporate_name: 'Pousada Joao Corporativo LTDA',cnpj: '34567865432',
            contact_phone: '3187654325',email: 'pousadajoao@outlook.com',full_address: 'Rua Bonita, 23',zip_code: '25487-080', state: 'PR',
            city: 'Curitiba',payment_methods: 'C/B e Pix',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),
            user: owner)
        
        #Act
        visit root_path
        click_on 'Faça o Login Proprietário'                       
        fill_in 'E-mail', with: 'joao@example.com'
        fill_in 'Senha', with: 'password'
        click_on 'Log in'
        click_on 'Pousada do João'
        click_on 'Cadastrar Quartos'
        fill_in 'Nome', with: 'Quarto do João'
        fill_in 'Dimensão', with: 15
        fill_in 'Ocupação Máxima', with: 4
        check 'Banheiro'
        check 'Disponível'
        click_on 'Cadastrar Quarto'
        
        #Assert
        expect(page).to have_content 'Quarto adicionado com sucesso.'
        expect(page).to have_content 'Quarto do João'
        expect(page).to have_content 'Capacidade Máxima de Hóspedes: 4'
    end

    it 'com dados em branco' do
        #Arrange
        owner = User.create!(email: 'joao@example.com', password: 'password')
        inn = Inn.create!(brand_name: 'Pousada do João',corporate_name: 'Pousada Joao Corporativo LTDA',cnpj: '34567865432',
            contact_phone: '3187654325',email: 'pousadajoao@outlook.com',full_address: 'Rua Bonita, 23',zip_code: '024588-808', state: 'PR',
            city: 'Curitiba',payment_methods: 'C/B e Pix',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),
            user: owner)
        #Act
        visit root_path
        click_on 'Faça o Login Proprietário'                       
        fill_in 'E-mail', with: 'joao@example.com'
        fill_in 'Senha', with: 'password'
        click_on 'Log in'
        click_on 'Pousada do João'
        click_on 'Cadastrar Quartos'
        fill_in 'Nome', with: ''
        fill_in 'Dimensão', with: ''
        fill_in 'Ocupação Máxima', with: ''
        click_on 'Cadastrar Quarto'
        
        #Assert
        expect(page).to have_content 'Algo deu errado, tente novamente.'
        expect(page).to have_content "Nome não pode ficar em branco"
        expect(page).to have_content "Dimensão não pode ficar em branco"
        expect(page).to have_content "Ocupação Máxima não pode ficar em branco"
    end
end