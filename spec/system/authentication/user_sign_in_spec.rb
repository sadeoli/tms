require 'rails_helper'

describe 'Usuario se autentica' do
    it 'com sucesso' do
        # Arrange
        User.create!(name: 'Usuário', email: 'usuario@sistemadefrete.com.br', password: 'password')

        # Act
        visit root_path
        fill_in 'E-mail', with: 'usuario@sistemadefrete.com.br'
        fill_in 'Senha', with: 'password'
        click_on 'Log in'
        
        # Assert
        expect(page).to have_content 'Login efetuado com sucesso.'
        within('nav') do
            expect(page).not_to have_link '[Entrar]'
            expect(page).to have_button 'Sair'
            expect(page).to have_content 'Usuário - usuario@sistemadefrete.com.br'
        end
    end

    it 'e faz logout' do
        # Arrange
        User.create!(name: 'Usuário', email: 'usuario@sistemadefrete.com.br', password: 'password')

        # Act
        visit root_path
        fill_in 'E-mail', with: 'usuario@sistemadefrete.com.br'
        fill_in 'Senha', with: 'password'
        click_on 'Log in'
        click_on 'Sair'
        
        # Assert
        expect(page).to have_content 'Para continuar, faça login ou registre-se.'
        within('nav') do
            expect(page).to have_link '[Entrar]'
            expect(page).not_to have_button 'Sair'
            expect(page).not_to have_content 'Usuário - usuario@sistemadefrete.com.br'
        end
        
    end
end