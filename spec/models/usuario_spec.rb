require 'spec_helper'

describe Usuario do
  context 'Nome' do
  	it{should_not have_valid(:nome).when('', nil)}
  	it{should have_valid(:nome).when("Annabell Del Real")}
  end
  context 'Cargo' do
  	it{should_not have_valid(:cargo).when('', nil)}
  	it{should have_valid(:cargo).when("Pesquisador")}
  end
  context 'Email' do
  	it{should_not have_valid(:email).when('', nil)}
  	it{should have_valid(:email).when("annabell@email.com")}
  end
  context 'lattes' do
  	it{should have_valid(:lattes).when("http://lattes.cnpq.br/7484786835288826")}
  end
end
