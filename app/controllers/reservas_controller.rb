class ReservasController < InheritedResources::Base
	load_and_authorize_resource
	def index
		if params[:equipamento_id]
			if current_usuario.admin?
				@equipamento = Equipamento.find(params[:equipamento_id])
				@reservas = @equipamento.reservas
			else
				@equipamento = Equipamento.find(params[:equipamento_id])
				@reservas = current_usuario.reservas.where(equipamento_id: @equipamento.id)
			end
		else
			@reservas = current_usuario.reservas
		end
	end

	def new
		@equipamento = Equipamento.find(params[:equipamento_id])
		@reserva = @equipamento.reservas.build
	end

	def show
		@equipamento = Equipamento.find(params[:equipamento_id])
		@comentarios = Reserva.find(params[:id]).comentarios
		@reserva = Reserva.find params[:id]
		@comentario = @reserva.comentarios.build(autor: current_usuario.admin? ? 'Administrador' : current_usuario.nome)
	end

	def create
		@equipamento = Equipamento.find(params[:reserva][:equipamento_id])
		@reserva = @equipamento.reservas.build(params[:reserva])
		@reserva.save!
		redirect_to equipamentos_path, notice: "Reserva feita com sucesso."
	end

  def buscar
   	@equipamento = Equipamento.find(params[:equipamento])
		respond_to :js
  end
end