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
end