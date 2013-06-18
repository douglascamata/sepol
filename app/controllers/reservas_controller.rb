class ReservasController < InheritedResources::Base
	def index
		@equipamento = Equipamento.find(params[:equipamento_id])
		@reservas = Reserva.where('equipamento_id = ?', params[:equipamento_id])
	end

	def new
		@equipamento = Equipamento.find(params[:equipamento_id])
		@reserva = @equipamento.reservas.build
	end

	def show
		@equipamento = Equipamento.find(params[:equipamento_id])
		@comentarios = Reserva.find(params[:id]).comentarios
		@reserva = Reserva.find params[:id]
		@comentario = @reserva.comentarios.build(autor: administrador_signed_in? ? 'Administrador' : current_usuario.nome)
	end

	def create
		@equipamento = Equipamento.find(params[:equipamento_id])
		@reserva = @equipamento.reservas.build(params[:reserva])
		@reserva.save!
		redirect_to equipamento_reservas_path(params[:equipamento_id])
	end
end