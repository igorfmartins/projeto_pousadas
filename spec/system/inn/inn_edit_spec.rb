require 'rails_helper'

describe 'User edita uma pousada' do
    it 'com sucesso' do
        #Arrange
        owner = User.create!(email: 'joao@example.com', password: 'password')
        inn = Inn.create!(brand_name: 'Pousada do João',corporate_name: 'Pousada Joao Corporativo LTDA',cnpj: '34567865432',
            contact_phone: '3187654325',email: 'pousadajoao@outlook.com',full_address: 'Rua Bonita, 23',state: 'PR',
            city: 'Curitiba', zip_code: '04235-080' , payment_methods: 'C/B e Pix',check_in_time: DateTime.new(2021, 2, 10),check_out_time: DateTime.new(2021, 2, 20),
            user: owner)
            
        #Act
        visit root_path
        click_on 'Faça o Login Proprietário'                       
        fill_in 'E-mail', with: 'joao@example.com'
        fill_in 'Senha', with: 'password'
        click_on 'Log in'
        click_on 'Pousada do João'
        click_on 'Editar Pousada'      
        fill_in "Nome Fantasia", with: 'Pousada Sob Nova Direção'     
        fill_in "Endereço", with: 'Rua Mudou, 432'
        fill_in "Estado", with: 'SC'
        fill_in "Cidade", with: 'Itajaí'
        fill_in "Métodos de Pagamento", with: 'só C/B'  
        click_on 'Cadastrar Pousada'       

        #Arrange
        expect(page).to have_content 'Rua Mudou, 432'
        expect(page).to have_content 'Pousada Sob Nova Direção'
        expect(page).to have_content 'Itajaí'
        expect(page).to have_content 'só C/B'    
    end

    it 'sem conseguir atualizar' do
        #Arrange
        owner = User.create!(email: 'joao@example.com', password: 'password')
        inn = Inn.create!(brand_name: 'Pousada do João',
            corporate_name: 'Pousada Joao Corporativo LTDA',
            cnpj: '34567865432',
            contact_phone: '3187654325',
            email: 'pousadajoao@outlook.com',
            full_address: 'Rua Bonita, 23',
            state: 'PR',
            city: 'Curitiba',
            zip_code: '04235-080',
            payment_methods: 'C/B e Pix',
            check_in_time: DateTime.new(2021, 2, 10),
            check_out_time: DateTime.new(2021, 2, 20),
            user: owner)
        #Act
        visit root_path
        click_on 'Faça o Login Proprietário'                       
        fill_in 'E-mail', with: 'joao@example.com'
        fill_in 'Senha', with: 'password'
        click_on 'Log in'
        click_on 'Pousada do João'
        click_on 'Editar Pousada'      
        fill_in "Nome Fantasia", with: ''     
        fill_in "Endereço", with: ''
        fill_in "Estado", with: 'SC'
        fill_in "Cidade", with: 'Itajaí'
        fill_in "Métodos de Pagamento", with: 'só C/B'  
        click_on 'Cadastrar Pousada'       

        #Arrange
        expect(page).to have_content 'Pousada não atualizada.'
        expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
        expect(page).to have_content 'Endereço Completo não pode ficar em branco'     
    end
end
