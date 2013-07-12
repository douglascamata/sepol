#encoding: utf-8
require 'spec_helper'

describe Reserva do
  context 'Horario da Reserva' do
    horario_inicial = DateTime.now
    horario_final = horario_inicial.hour + 2

  	it{should_not have_valid(:horario_inicial).when('', nil)}
  	it{should_not have_valid(:horario_final).when('', nil)}
    it{should have_valid(:horario_inicial).when(horario_inicial)}
    it{should have_valid(:horario_inicial).when(horario_final)}
  end

  context 'Relacoes' do
    it{should belong_to(:usuario)}
    it{should belong_to(:equipamento)}
    it{should have_one(:resultado)}
    it{should have_many(:comentarios)}
  end

  context 'Nao deve haver mais de 1 reserva no mesmo horario pro mesmo equipamento' do
    it 'Horario inicial não pode estar entre horarios existentes' do
      usuario = FactoryGirl.create :usuario
      equipamento = FactoryGirl.create :equipamento
      time = Time.now
      FactoryGirl.create :reserva, equipamento: equipamento, horario_inicial: time, horario_final: time + 3.hours
      lambda{FactoryGirl.create! :reserva, equipamento: equipamento, horario_inicial: time + 1.hour}.should raise_exception
    end

    it 'Horario final nao pode estar entre horarios ja existentes' do
      equipamento = FactoryGirl.create :equipamento
      FactoryGirl.create :reserva, equipamento: equipamento
      lambda{FactoryGirl.create! :reserva, equipamento: equipamento, horario_inicial: Time.now.yesterday, horario_final: Time.now + 30.minutes}.should raise_exception
    end

    it 'Uma reserva nao pode acabar antes de começar' do
      equipamento = FactoryGirl.create :equipamento
      lambda{FactoryGirl.create! :reserva, equipamento: equipamento, horario_final: Time.now.yesterday}.should raise_exception
    end

    it 'Horario final nao pode ser igual a horario final' do
      horario = Time.now
      lambda{FactoryGirl.create :reserva, equipamento: equipamento, horario_final: horario, horario_final: horario}.should raise_exception
    end

    it 'Deve verificar se nao existe uma reserva no intervalo de tempo solicitado' do
      equipamento = FactoryGirl.create :equipamento
      FactoryGirl.create :reserva, equipamento: equipamento,  horario_inicial: Time.now, horario_final: Time.now + 1.hour
      lambda{FactoryGirl.create :reserva, equipamento: equipamento,  horario_inicial: Time.now - 1.hour, horario_final: Time.now + 2.hours}.should raise_error
    end


    it 'Um equipamento pode ter varias reservas' do
      equipamento = FactoryGirl.create :equipamento
      reservas = FactoryGirl.create_list :reserva, 5, equipamento: equipamento
      equipamento.reservas.should == reservas
    end
  end
end