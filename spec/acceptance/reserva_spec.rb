#encoding: utf-8

require 'spec_helper'

feature 'Reserva de equipamento' do
  scenario 'Apenas usuarios logados podem acessar essa pagina.' do
    equipamento = FactoryGirl.create :equipamento
    visit new_equipamento_reserva_path(equipamento)
    page.should have_content 'Você precisa estar logado para acessar essa página!'
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
    page.should have_content 'Você precisa estar logado para acessar essa página!'
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

feature 'Pagina para o usuario monitorar suas reservas' do
  scenario 'Listando todas as reservas' do
    usuario = FactoryGirl.create :usuario
    reservas = []
    equipamentos = FactoryGirl.create_list :equipamento, 4, nome: "Equipamento"
    equipamentos.each{|equipamento| reservas << (FactoryGirl.create :reserva, equipamento: equipamento, usuario: usuario)}
    
    logar(usuario)
    visit reservas_path
    
    current_path.should == reservas_path
    page.should have_content 'Minhas Reservas'

    reservas.each do |reserva| 
      page.should have_content reserva.equipamento.nome
      page.should have_content reserva.horario_inicial.strftime("%T - %D")
    end
  end

  scenario 'Usuario deve poder visualizar todas as reservas para um equipamento especifico' do
    usuario_1 = FactoryGirl.create :usuario
    usuario_2 = FactoryGirl.create :usuario
    
    equipamento = FactoryGirl.create :equipamento, nome: "Equipamento"
    reservas_1 = FactoryGirl.create_list :reserva, 3, equipamento: equipamento, usuario: usuario_1
    reservas_2 = FactoryGirl.create_list :reserva, 3, equipamento: equipamento, usuario: usuario_2
    
    logar(usuario_1)


    visit equipamento_reservas_path(equipamento)

    page.should have_content 'Minhas reservas para:'
    page.should have_content equipamento.nome

    reservas_1.each do |reserva|
      page.should have_content reserva.horario_inicial.strftime("%T - %D")
    end
    
    reservas_2.each do |reserva|
      page.should_not have_content reserva.horario_inicial.strftime("%T - %D")
    end
  end


  scenario 'O Usuario só pode ver as suas reservas' do
    equipamento_1 = FactoryGirl.create :equipamento, nome: 'Equipamento 1'
    equipamento_2 = FactoryGirl.create :equipamento, nome: 'Equipamento 2'
    usuario_1 = FactoryGirl.create :usuario
    usuario_2 = FactoryGirl.create :usuario
    reserva_1 = FactoryGirl.create :reserva, equipamento: equipamento_1, usuario: usuario_1
    reserva_2 = FactoryGirl.create :reserva, equipamento: equipamento_2, usuario: usuario_2
    
    logar(usuario_1)
    visit reservas_path
    
    page.should have_content equipamento_1.nome
    page.should have_content reserva_1.horario_inicial.strftime("%T - %D")
    
    page.should_not have_content equipamento_2.nome
    page.should_not have_content reserva_2.horario_inicial.strftime("%T - %D")
  end

  scenario 'Tentando acessar reserva pela url' do
    equipamento = FactoryGirl.create :equipamento
    usuario_1 = FactoryGirl.create :usuario
    usuario_2 = FactoryGirl.create :usuario
    reserva = FactoryGirl.create :reserva, usuario: usuario_1, equipamento: equipamento
    
    visit equipamento_reserva_path(equipamento, reserva)
    page.should have_content 'Você precisa estar logado para acessar essa página!'
    
    logar(usuario_2)
    
    visit equipamento_reserva_path(equipamento, reserva)
    page.should have_content 'Você não tem permissão para acessar essa página!'

    visit destroy_usuario_session_path

    logar(usuario_1)
    
    visit equipamento_reserva_path(equipamento, reserva)
    page.should have_content equipamento.nome
    page.should have_content reserva.horario_inicial.strftime("%D - %T")
  end
end

feature 'Paginas para administrar as reservas' do
  scenario 'Administrador deve ter uma pagina para ver suas reservas.' do
    admin = FactoryGirl.create :usuario, admin: true
    equipamento = FactoryGirl.create :equipamento
    reservas = FactoryGirl.create_list :reserva, 5, usuario: admin, equipamento: equipamento
    logar(admin)
    visit reservas_path
    page.should have_content 'Minhas Reservas'

    reservas.each do |reserva|
      page.should have_content reserva.horario_inicial.strftime("%T - %D")
    end
  end

  scenario 'Administrador tem acesso a todas as reservas a partir de equipamentos' do
    admin = FactoryGirl.create :usuario, admin: true
    equipamento = FactoryGirl.create :equipamento
    usuarios = FactoryGirl.create_list :usuario, 4
    reservas = []
    usuarios.each{|usuario| reservas << (FactoryGirl.create :reserva, equipamento: equipamento, usuario: usuario)}
    
    logar(admin)
    visit equipamento_reservas_path(equipamento)
    page.should have_content 'Todas as reservas'

    reservas.each do |reserva|
      page.should have_content reserva.horario_inicial.strftime("%T - %D")
    end

    usuarios.each do |usuario|
      page.should have_content usuario.nome
    end
  end

end



feature 'Informações da reserva' do
  scenario 'Apenas usuarios logados podem acessar essa pagina.' do
    equipamento = FactoryGirl.create :equipamento
    reserva = FactoryGirl.create :reserva, equipamento: equipamento
    visit equipamento_reserva_comentarios_path(equipamento, reserva)
    page.should have_content 'Você precisa estar logado para acessar essa página!'
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
end