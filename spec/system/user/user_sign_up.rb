require 'rails_helper'

describe 'User cria uma conta' do
    it 'com sucesso' do
        #Arrange

        #Act
        visit root_path
        click_on 'Crie uma conta como Proprietário'        
        fill_in 'E-mail', with: 'joao@example.com'
        fill_in 'Senha', with: 'password'
        fill_in 'Confirme sua senha', with: 'password'
        click_on 'Crie sua conta'

        #Assert        
        expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
        expect(page).to have_button 'Sair'        
        expect(page).to have_content 'joao@example.com'
        
    end

    it 'com dados em branco' do
        #Arrange

        #Act
        visit root_path
        click_on 'Crie uma conta como Proprietário'
        fill_in 'E-mail', with: ''
        fill_in 'Senha', with: ''
        fill_in 'Confirme sua senha', with: ''
        click_on 'Crie sua conta'  

        #Assert
        expect(page).not_to have_content 'Boas vindas! Você realizou seu registro com sucesso.'        
        expect(page).to have_content "E-mail não pode ficar em branco" 
        expect(page).to have_content "Senha não pode ficar em branco"     
    end   
end
