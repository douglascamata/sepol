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
  end

  context 'Nao deve haver mais de 1 reserva no mesmo horario pro mesmo equipamento' do
    it 'Horario inicial não pode estar entre horarios existentes' do
      usuario = FactoryGirl.create :usuario
      equipamento = FactoryGirl.create :equipamento
      FactoryGirl.create :reserva, equipamento: equipamento
      lambda{FactoryGirl.create :reserva, equipamento: equipamento}.should raise_exception
    end

    it 'Horario final nao pode estar entre horarios ja existentes' do
      equipamento = FactoryGirl.create :equipamento
      FactoryGirl.create :reserva, equipamento: equipamento
      lambda{FactoryGirl.create :reserva, equipamento: equipamento, horario_inicial: time_travel_to(1.days.ago){Delorean.now}, horario_final: time_travel_to(30.minutes.from_now){Delorean.now}}.should raise_exception
    end

    it  'Uma reserva nao pode acabar antes de começar' do
      equipamento = FactoryGirl.create :equipamento
      lambda{FactoryGirl.create :reserva, equipamento: equipamento, horario_final: time_travel_to(1.day.ago){Delorean.now}}.should raise_exception
    end

    it 'Horario final nao pode ser igual a horario final' do
      horario = Time.now
      lambda{FactoryGirl.create :reserva, equipamento: equipamento, horario_final: horario, horario_final: horario}.should raise_exception
    end

    it 'Um equipamento pode ter varias reservas' do
      equipamento = FactoryGirl.create :equipamento
      reserva_1 = FactoryGirl.create :reserva, equipamento: equipamento
      reserva_2 = FactoryGirl.create :reserva, equipamento: equipamento, horario_inicial: time_travel_to(2.days.ago){Delorean.now}
      reserva_3 = FactoryGirl.create :reserva, equipamento: equipamento, horario_inicial: time_travel_to(3.days.ago){Delorean.now}
      reserva_4 = FactoryGirl.create :reserva, equipamento: equipamento, horario_inicial: time_travel_to(4.days.ago){Delorean.now}
      reserva_5 = FactoryGirl.create :reserva, equipamento: equipamento, horario_inicial: time_travel_to(5.days.ago){Delorean.now}
      reserva_6 = FactoryGirl.create :reserva, equipamento: equipamento, horario_inicial: time_travel_to(6.days.ago){Delorean.now}
      equipamento.reservas.should include(reserva_1, reserva_2, reserva_3, reserva_4, reserva_5, reserva_6)
    end
  end
end