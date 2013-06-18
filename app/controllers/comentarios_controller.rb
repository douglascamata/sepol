class ComentariosController < InheritedResources::Base
	def index
		@comentarios = Reserva.find(params[:reserva_id]).comentarios
		@reserva = Reserva.find params[:reserva_id]
		@comentario = @reserva.comentarios.build(autor: administrador_signed_in? ? 'Administrador' : current_usuario.nome)
	end

	def new
		@reserva = Reserva.find params[:reserva_id]
		@comentario = @reserva.comentarios.build
	end

	def create
		@reserva = Reserva.find params[:reserva_id]
		@comentario = @reserva.comentarios.build(params[:comentario])
		@comentario.save!
		
		redirect_to equipamento_reserva_path(params[:equipamento_id], @reserva)
	end
end