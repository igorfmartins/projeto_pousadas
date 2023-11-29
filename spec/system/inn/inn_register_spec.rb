require 'rails_helper'

describe 'registra uma pousada' do
    it 'com sucesso no banco de dados' do
        #Arrange
        owner = User.create!(email: 'joao@example.com', password: 'password')
       
        #Act
        visit root_path
        click_on 'Faça o Login Proprietário'                       
        fill_in 'E-mail', with: 'joao@example.com'
        fill_in 'Senha', with: 'password'
        click_on 'Log in'
        click_on 'Cadastrar Pousada'
        fill_in "Nome Fantasia", with: 'Pousada Sob Nova Direção'    
        fill_in "Razão Social", with: 'Pousada Direções LTDA'  
        fill_in "CNPJ", with: 12459873/0001-96 
        fill_in "Telefone de Contato", with: 1198745244
        fill_in "E-mail", with: 'joao@example.com'
        fill_in "Endereço Completo", with: 'Av. Ali no Sul, 101' 
        fill_in "CEP", with: '04587-202'
        fill_in "Estado", with: 'SC'
        fill_in "Cidade", with: 'Itajaí'
        fill_in "Métodos de Pagamento", with: 'só C/B'  
        check 'Pousada Disponível'
        click_on 'Cadastrar Pousada'      
        
        #Arrange
        expect(page).to have_content 'Sua pousada foi cadastrada com sucesso!'
        expect(page).to have_content 'Av. Ali no Sul, 101'
        expect(page).to have_content 'Pousada Sob Nova Direção'
        expect(page).to have_content 'só C/B'           
    end

    it 'e não consegue registrar' do
        #Arrange
        owner = User.create!(email: 'joao@example.com', password: 'password')
       
        #Act
        visit root_path
        click_on 'Faça o Login Proprietário'                       
        fill_in 'E-mail', with: 'joao@example.com'
        fill_in 'Senha', with: 'password'
        click_on 'Log in'
        click_on 'Cadastrar Pousada'
        fill_in "Nome Fantasia", with: ''    
        fill_in "Razão Social", with: ''  
        fill_in "CNPJ", with: 12459873/0001-96 
        fill_in "E-mail", with: ''
        fill_in "Endereço Completo", with: '' 
        fill_in "Estado", with: 'SC'
        fill_in "Cidade", with: 'Itajaí'
        fill_in "CEP", with: '04587-202'
        fill_in 'Horario do Início de Check-in', with: '02/02/2023'
        fill_in 'Horario Máximo de Check-out', with: '14/02/2023'
        fill_in "Métodos de Pagamento", with: 'só C/B'  
        click_on 'Cadastrar Pousada'      
        
        #Arrange
        expect(page).to have_content 'Não foi possível cadastrar a pousada.'
        expect(page).to have_content 'Ops! Houve alguns problemas com o cadastro da pousada:'
        expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
        expect(page).to have_content 'Razão Social não pode ficar em branco'           
    end
end
