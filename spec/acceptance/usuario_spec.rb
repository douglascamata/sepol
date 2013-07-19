#encoding: utf-8

require 'spec_helper'
require './spec/suport/usuario'

feature 'Login' do
	scenario 'Criar usuario' do				
		visit new_usuario_registration_path
		fill_in 'Email', with: 'usuario@test.br'
		fill_in 'Password', with: '123456foobar'
		fill_in 'Password confirmation', with: '123456foobar'
		fill_in 'Nome', with:'usuario'
		fill_in 'Lattes', with: 'http://buscatextual.cnpq.br/usuario'
		select 'Pesquisador', from: 'Cargo'
		click_button 'Sign up'
		page.should have_content "Login efetuado com sucesso."				
	end
	
	scenario 'fazer login' do	
		usuario = FactoryGirl.create :usuario
		logar(usuario)
		page.should have_content "Login efetuado com sucesso!"		
	end
end


feature 'Listar Usuarios' do
	scenario 'Listar todos usuarios' do
		usuario = FactoryGirl.create :usuario
		visit usuarios_path
		find("#lA").click
		page.should have_content usuario.nome
		page.should have_link('Email', href: "mailto:#{usuario.email}")
		page.should have_link('Lattes', href: usuario.lattes)
		page.should have_content usuario.cargo	
	end
end	