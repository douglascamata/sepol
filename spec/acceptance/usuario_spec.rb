#encoding: utf-8

require 'spec_helper'

feature 'Login' do
	scenario 'fazer login' do	
		usuario = FactoryGirl.create :usuario, nome: 'usuario', email: 'usuario@test.br', password: '123456foobar', password_confirmation: '123456foobar', lattes: 'http://buscatextual.cnpq.br/usuario', cargo: 'bolsita'
		visit new_usuario_registration_path
		fill_in 'Email', with: usuario.email
		fill_in 'Password', with: usuario.password
		fill_in 'Nome', with: usuario.nome
		fill_in 'Lattes', with: usuario.lattes
		fill_in 'Cargo', with: usuario.cargo
		click_button 'Sign up'		
	end
end

feature 'Listar Usuarios' do
	scenario 'Listar todos usuarios' do
		usuario = FactoryGirl.create :usuario

		visit usuarios_path
		# -usuarios.each do |usuario|
			page.should have_content usuario.nome
			page.should have_content usuario.email
			page.should have_content usuario.lattes
			page.should have_content usuario.cargo
		# end
	end
end	