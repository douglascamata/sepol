#encoding: utf-8

require 'spec_helper'

feature 'Login' do
	scenario 'fazer login' do	
		usuario = FactoryGirl.create :usuario, nome: 'usuario', email: 'usuario@test.br', password: '123456foobar', password_confirmation: '123456foobar', lattes: 'http://buscatextual.cnpq.br/usuario', cargo: 'bolsita'
		visit new_usuario_session_path
		fill_in 'Email', with: usuario.email
		fill_in 'Password', with: usuario.password
		# fill_in 'Nome', with: usuario.nome
		fill_in 'Lattes', with: usuario.lattes
		fill_in 'Cargo', with: usuario.cargo
		click_button 'Sign in'		
	end
end