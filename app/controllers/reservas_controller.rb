class ReservasController < InheritedResources::Base
	def show
		@equipamento = Equipamento.find(params[:id])
	end
end