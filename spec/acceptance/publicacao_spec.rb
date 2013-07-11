#encoding: utf-8

require 'spec_helper'

feature 'Adicionar publicação' do
  scenario 'Não pode ser realizado por visitante' do
      visit new_publicacao_path
      page.should have_content 'Você precisa estar logado para acessar essa página.'    
  end

  scenario 'Não pode ser realizado por qualquer usuario' do
    usuario = FactoryGirl.create :usuario
    logar(usuario)
    visit new_publicacao_path
    page.should have_content 'Você precisa logar como administrador para acessar essa página.'    
  end


  scenario 'Com sucesso' do 
    usuario = FactoryGirl.create :usuario, admin: true
    logar(usuario)

    visit new_publicacao_path
    fill_in 'Título', with: 'Algum título'
    fill_in 'Abstract', with: 'Aqui vai o abstract'
    fill_in 'Link', with: 'http://google.com'
    click_button 'Save'
    page.should have_content 'Publicação criada com sucesso!'
  end

  scenario 'Sem sucesso' do
    usuario = FactoryGirl.create :usuario, admin: true
    logar(usuario)

    visit new_publicacao_path
    fill_in 'Título', with: ''
    fill_in 'Abstract', with: ''
    fill_in 'Link', with: ''
    click_button 'Save'
    page.should have_content 'Título não pode ficar em branco'
    page.should have_content 'Abstract não pode ficar em branco'
  end
end

feature 'Visualização de Publicações' do
  scenario 'Visualização basica' do
    6.times{FactoryGirl.create :publicacao}
    visit publicacoes_path

    Publicacao.all.each do |publicacao| 
      page.should have_content publicacao.titulo
      page.should have_content publicacao.abstract
    end
  end
end