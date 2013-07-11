class ResultadosController < InheritedResources::Base
  load_and_authorize_resource
  def new
    @equipamento = Equipamento.find(params[:equipamento_id])
    @reserva = Reserva.find(params[:reserva_id])
    @resultado = Resultado.new
  end

  def create
    @resultado = Resultado.new(params[:resultado])
    @resultado.reserva_id = params[:reserva_id]
    @resultado.save!
    redirect_to equipamento_reserva_path(params[:equipamento_id], params[:reserva_id])
  end
end