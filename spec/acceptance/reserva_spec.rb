#encoding: utf-8

require 'spec_helper'
require './spec/suport/usuario.rb'

feature 'Login' do
	scenario 'Criar usuario' do				
		usuario = FactoryGirl.create :usuario
		logar(usuario)
		page.should have_content "Login efetuado com sucesso!"
	end
end