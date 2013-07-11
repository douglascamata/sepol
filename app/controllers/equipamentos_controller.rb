class EquipamentosController < InheritedResources::Base
	load_and_authorize_resource
	def index
		@equipamentos = Equipamento.paginate(:page => params[:page])
	end

	def create
		create! notice: 'Equipamento criado com sucesso!'
	end
end
