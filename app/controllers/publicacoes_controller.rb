class PublicacoesController < InheritedResources::Base
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
end