#encoding: utf-8

require 'spec_helper'
require './spec/suport/usuario.rb'

feature 'Reserva de equipamento' do
	scenario 'Efetuar reserva de equipamento' do
		usuario = FactoryGirl.create :usuario
		equipamento = FactoryGirl.create :equipamento
		horario_inicio  = Time.now.utc
		horario_final = horario_inicio + 2.hours
		logar(usuario)
		visit new_reserva_path
		select equipamento.nome, from: "equipamento"
		fill_in "Horario inicial", with: horario_inicio
		fill_in "Horario final", with: horario_final
		click_button 'Save'

		visit reserva_path(equipamento.id)
		page.should have_content horario_inicio.strftime("%T - %D")
		page.should have_content horario_final.strftime("%T - %D")
	end
end

feature 'Comentario de reserva' do
	scenario 'Deve ser possivel fazer comentarios sobre a reserva' do
		equipamento = FactoryGirl.create :equipamento
		reserva = FactoryGirl.create :reserva, equipamento: equipamento
		usuario = FactoryGirl.create :usuario
		logar(usuario)

		visit reserva_comentarios_path(reserva)

		fill_in "comentario", with: "Aqui esta um comentario."
		click_button "Enviar"

		page.should have_content "Aqui esta um comentario."
	end
end

feature	'Informações da reserva' do
	scenario 'Deve conter as informacoes basicas da reserva' do
		equipamento = FactoryGirl.create :equipamento
		reserva = FactoryGirl.create :reserva, equipamento: equipamento
		usuario = FactoryGirl.create :usuario
		logar(usuario)

		visit reserva_comentarios_path(reserva)		

		page.should have_content usuario.nome
		page.should have_content reserva.horario_inicial.strftime("%D - %T")
		page.should have_content reserva.horario_final.strftime("%D - %T")
		page.should have_content equipamento.nome
	end
end