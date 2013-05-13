require 'spec_helper'

describe Publicacao do
	context 'Titulo' do
		it{should_not have_valid(:titulo).when('', nil)}
		it{should have_valid(:titulo).when("Titulo qualquer")}
	end
	context 'Abstract' do
		it{should_not have_valid(:abstract).when('', nil)}
		it{should have_valid(:abstract).when("Abstract qualquer")}
	end
end
