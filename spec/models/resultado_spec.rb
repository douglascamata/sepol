require 'spec_helper'

describe Resultado do
  context 'Relacoes' do
    it{should belong_to(:reserva)}
    it{should_not have_valid(:reserva_id).when('', nil)}
  end
end
