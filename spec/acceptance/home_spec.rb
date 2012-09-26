#encoding: utf-8

require 'spec_helper'

feature 'Pagina inicial' do
	scenario 'teste inicial' do	
		visit '/'
		page.should have_content 'Sepol'
		page.should have_content 'Bem vindo a Pagina do Setor de Polímeros da UENF'
	end
end