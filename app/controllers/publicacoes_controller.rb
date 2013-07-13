#encoding: utf-8
class PublicacoesController < InheritedResources::Base
  load_and_authorize_resource
	def index
		if params[:q]
      params[:q].delete_if{|key, value| value == "-1" || value == ""}
    end
    @q = Publicacao.search(params[:q])
    @publicacao = @q.result(:distinct => true)
  end
		
	
	def buscar
		@q = Publicacao.search(params[:q])
    @publicacao = @q.result(:distinct => true)
  end

  def create
    create! notice: 'Publicação criada com sucesso!'
  end
end
