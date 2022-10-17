require 'rails_helper'

describe 'Usuario registra uma ordem de serviço' do
    it 'com sucesso' do
        # Arrange
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)
        allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('HUSAI6DA5DSCI08')

        # Act
        login_as user 
        visit root_path
        click_on 'Ordens de Serviço'
        click_on 'Cadastrar'
        fill_in 'Peso', with: '5'
        fill_in 'Altura', with: '50'
        fill_in 'Profundidade', with: '40'
        fill_in 'Largura', with: '20'
        fill_in 'Endereço de Retirada', with: 'Rua das Amoras, 52 - Campinas/SP'
        fill_in 'Código do Produto', with: 'CX124060'
        fill_in 'Nome do Destinatário', with: 'Maria Carvalho'
        fill_in 'Endereço do Destinatário', with: 'Rua das Laranjeiras, 15 - Campinas/SP'
        fill_in 'Telefone do Destinatário', with: '019985463251'
        fill_in 'Distância', with: '7'
        click_on 'Cadastrar'

        # Assert
        expect(page).to have_content 'HUSAI6DA5DSCI08'
        expect(page).to have_content '5kg'
        expect(page).to have_content '20x40x50cm'
        expect(page).to have_content '7km'
    end

    it 'e mantém os campos obrigatórios' do
        # Arrange
        user = User.create!(email: 'usuario@sistemadefrete.com.br', password: 'password', access_group: :admin)

        # Act
        login_as user 
        visit root_path
        click_on 'Ordens de Serviço'
        click_on 'Cadastrar'
        fill_in 'Peso', with: ''
        fill_in 'Altura', with: ''
        fill_in 'Profundidade', with: ''
        fill_in 'Largura', with: ''
        fill_in 'Endereço de Retirada', with: ''
        fill_in 'Código do Produto', with: ''
        fill_in 'Nome do Destinatário', with: ''
        fill_in 'Endereço do Destinatário', with: ''
        fill_in 'Telefone do Destinatário', with: ''
        fill_in 'Distância', with: ''
        click_on 'Cadastrar'

        # Assert
        expect(page).to have_content 'Ordem de serviço não cadastrado.'        
    end
end