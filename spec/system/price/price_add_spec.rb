require 'rails_helper'

describe 'Proprietário cadastra preço de temporada' do
    it 'com sucesso' do
        #Arrange
        owner = User.create!(email: 'joao@example.com', password: 'password')
        inn = Inn.create!(brand_name: 'Pousada do João',corporate_name: 'Pousada Joao Corporativo LTDA',cnpj: '34567865432',
            contact_phone: '3187654325',email: 'pousadajoao@outlook.com',full_address: 'Rua Bonita, 23',zip_code: '25487896' ,state: 'PR',
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
        click_on 'Adicionar Preço Personalizado'
        fill_in 'Início', with: '15-02-2023'
        fill_in 'Término', with: '28-02-2023'
        fill_in 'Diária', with: 350
        click_on 'Salvar'      
        
        #Assert
        expect(page).to have_content 'Valor diária e Preços especiais de Temporada'
        expect(page).to have_content '15/02 até 28/02: $350.00'
        expect(page).to have_link 'Detalhes do Preço'
    end

    it 'e depois apaga o Preço de Temporada' do
        #Arrange
        owner = User.create!(email: 'joao@example.com', password: 'password')
        inn = Inn.create!(brand_name: 'Pousada do João',corporate_name: 'Pousada Joao Corporativo LTDA',cnpj: '34567865432',
            contact_phone: '3187654325',email: 'pousadajoao@outlook.com',full_address: 'Rua Bonita, 23',zip_code: '25487896' ,state: 'PR',
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
        click_on 'Adicionar Preço Personalizado'
        fill_in 'Início', with: '15-02-2023'
        fill_in 'Término', with: '28-02-2023'
        fill_in 'Diária', with: 350
        click_on 'Salvar'
        click_on 'Detalhes do Preço'  
        click_on 'Remover Preço'   
        
        #Assert
        expect(page).to have_content 'Preço removido com sucesso.'
        expect(page).not_to have_content '15/02 até 28/02: $350'
        
    end

end