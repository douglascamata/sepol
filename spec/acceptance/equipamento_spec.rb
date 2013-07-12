#encoding: utf-8

require 'spec_helper'

feature 'Adicionar equipamento' do
  scenario 'Não pode ser realizado por visitante' do
      visit new_equipamento_path
      page.should have_content 'Você precisa estar logado para acessar essa página!'
  end

  scenario 'Não pode ser realizado por qualquer usuario' do
    usuario = FactoryGirl.create :usuario
    logar(usuario)
    visit new_equipamento_path
    page.should have_content 'Você não tem permissão para acessar essa página!'
  end


  scenario 'Com sucesso' do 
    usuario = FactoryGirl.create :usuario, admin: true
    logar(usuario)

    visit new_equipamento_path
    fill_in 'Nome', with: 'Super Equipamento'
    fill_in 'Descrição', with: 'Alguma Descrição'
    attach_file('Imagem', 'app/assets/images/missing.jpg')
    click_button 'Save'
    page.should have_content 'Equipamento criado com sucesso!'
  end

  scenario 'Sem sucesso' do
    usuario = FactoryGirl.create :usuario, admin: true
    logar(usuario)
    visit new_equipamento_path
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    click_button 'Save'
    page.should have_content 'Nome não pode ficar em branco'
    page.should have_content 'Descrição não pode ficar em branco'
    page.should have_content 'Imagem não pode ficar em branco'
  end
end

feature 'Listar Equipamentos' do
  scenario 'Listar todos equipamentos' do
    10.times{FactoryGirl.create :equipamento}
    visit equipamentos_path
    Equipamento.all.each{|equipamento| page.should have_content equipamento.nome}
  end
end