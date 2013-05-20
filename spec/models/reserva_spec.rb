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

    it 'Nao deve haver mais de 1 reserva no mesmo horario pro mesmo equipamento' do
      horario = DateTime.now
      equipamento = FactoryGirl.create :equipamento
      usuario = FactoryGirl.create :usuario
      reserva_1 = FactoryGirl.create :reserva, equipamento: equipamento, horario_inicial: horario
      lambda{FactoryGirl.create :reserva, equipamento: equipamento, horario_inicial: horario}.should raise_exception
    end

    it 'Um equipamento pode ter varias reservas' do
      equipamento = FactoryGirl.create :equipamento
      reserva_1 = FactoryGirl.create :reserva, equipamento: equipamento
      reserva_2 = FactoryGirl.create :reserva, equipamento: equipamento
      equipamento.reservas.should include(reserva_1, reserva_2)
    end
  end
end