#encoding: utf-8

require 'spec_helper'

feature 'Reserva de equipamento' do
  scenario 'Apenas usuarios logados podem acessar essa pagina.' do
    equipamento = FactoryGirl.create :equipamento
    visit new_equipamento_reserva_path(equipamento)
    page.should have_content 'Você precisa estar logado para acessar essa página.'
  end

  scenario 'Efetuar reserva de equipamento' do
    usuario = FactoryGirl.create :usuario
    equipamento = FactoryGirl.create :equipamento
    horario_inicio  = Time.now.utc
    horario_final = horario_inicio + 2.hours
    logar(usuario)

    visit new_equipamento_reserva_path(equipamento)
    
    fill_in "Horario inicial", with: horario_inicio
    fill_in "Horario final", with: horario_final
    click_button 'Save'

    page.should have_content "Reserva feita com sucesso."
  end
end

feature 'Comentario de reserva' do
  scenario 'Apenas usuarios logados podem acessar essa pagina.' do
    equipamento = FactoryGirl.create :equipamento
    reserva = FactoryGirl.create :reserva, equipamento: equipamento
    visit equipamento_reserva_comentarios_path(equipamento, reserva)
    page.should have_content 'Você precisa estar logado para acessar essa página.'
  end

  scenario 'Deve ser possivel fazer comentarios sobre a reserva' do
    usuario = FactoryGirl.create :usuario
    equipamento = FactoryGirl.create :equipamento
    reserva = FactoryGirl.create :reserva, equipamento: equipamento, usuario: usuario
    logar(usuario)

    visit equipamento_reserva_comentarios_path(equipamento, reserva)
    find("#lB").click

    fill_in "comentario", with: "Aqui esta um comentario."
    click_button "Enviar"

    page.should have_content "Aqui esta um comentario."
  end
end

feature 'Informações da reserva' do
  scenario 'Apenas usuarios logados podem acessar essa pagina.' do
    equipamento = FactoryGirl.create :equipamento
    reserva = FactoryGirl.create :reserva, equipamento: equipamento
    visit equipamento_reserva_comentarios_path(equipamento, reserva)
    page.should have_content 'Você precisa estar logado para acessar essa página.'
  end

  scenario 'Deve conter as informacoes basicas da reserva' do
    equipamento = FactoryGirl.create :equipamento
    reserva = FactoryGirl.create :reserva, equipamento: equipamento
    usuario = FactoryGirl.create :usuario
    logar(usuario)

    visit equipamento_reserva_comentarios_path(equipamento, reserva)    

    page.should have_content usuario.nome
    page.should have_content reserva.horario_inicial.strftime("%D - %T")
    page.should have_content reserva.horario_final.strftime("%D - %T")
    page.should have_content equipamento.nome
  end

  scenario 'O Usuario só pode ter acesso as informações das suas reservas' do
    equipamento_1 = FactoryGirl.create :equipamento, nome: 'Equipamento 1'
    equipamento_2 = FactoryGirl.create :equipamento, nome: 'Equipamento 2'
    usuario_1 = FactoryGirl.create :usuario
    usuario_2 = FactoryGirl.create :usuario
    FactoryGirl.create :reserva, equipamento: equipamento_2, usuario: usuario_2
    FactoryGirl.create :reserva, equipamento: equipamento_1, usuario: usuario_1
    
    logar(usuario_1)
    visit reservas_path
    
    page.should have_content equipamento_1.nome
    page.should_not have_content equipamento_2.nome
  end

end