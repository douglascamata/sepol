require 'spec_helper'

describe Comentario do
  context 'Validacoes' do
  	it{should_not have_valid(:texto).when('', nil)}
  	it{should have_valid(:texto).when('Reserva nao foi aceita porque o equipamento esta em manutencao.')}
  	it{should_not have_valid(:autor).when('', nil)}
  	it{should have_valid(:autor).when('Thawan Fidelis')}
  end

  context 'Relacoes' do
    it{should belong_to(:reserva)}
  end
end