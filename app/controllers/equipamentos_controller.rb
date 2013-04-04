class EquipamentosController < InheritedResources::Base
	def index
		@equipamentos = Equipamento.paginate(:page => params[:page])
	end
end
