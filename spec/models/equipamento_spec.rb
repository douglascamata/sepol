require 'spec_helper'

describe Equipamento do
  context 'Nome' do
  	it{should_not have_valid(:nome).when('', nil)}
  	it{should have_valid(:nome).when("Estufa")}
  end
  context 'Descricao' do
  	it{should_not have_valid(:descricao).when('', nil)}
  	it{should have_valid(:descricao).when("Lorem ipsum dolor sit amet, consectetuer")}
  end
  context 'Imagem' do
  	it{should_not have_valid(:imagem).when(nil)}
  end
end
