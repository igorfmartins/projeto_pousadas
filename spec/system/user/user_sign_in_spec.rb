require 'rails_helper'

describe 'Usuário se autentica' do 
    it 'com sucesso' do 
        #Arrange
        User.create!(email: 'devdeve@outlook.com', password:'password')

        #Act
        visit root_path
        click_on 'Faça o Login Proprietário'                       
        fill_in 'E-mail', with: 'devdeve@outlook.com'
        fill_in 'Senha', with: 'password'
        click_on 'Log in'      

        #Assert
        expect(page).to have_content 'Login efetuado com sucesso.'        
        expect(page).not_to have_link 'Entrar'  
        expect(page).to have_button 'Sair'      
        expect(page).to have_content 'devdeve@outlook.com'
    end    
    
    it 'e faz logout' do 
        #Arrange
        User.create!(email: 'devdeve@outlook.com', password:'password')

        #Act
        visit root_path
        click_on 'Faça o Login Proprietário'                       
        fill_in 'E-mail', with: 'devdeve@outlook.com'
        fill_in 'Senha', with: 'password'
        click_on 'Log in'
        click_on 'Sair'

        #Assert
        expect(page).to have_content 'Logout efetuado com sucesso.'
        expect(page).to have_link 'Faça o Login'
        expect(page).not_to have_button 'Sair'
        expect(page).not_to have_content 'devdeve@outlook.com' 
    end
end    
