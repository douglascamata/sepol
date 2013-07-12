class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
  	if usuario_signed_in?
    	redirect_to root_path, :alert => "Você não tem permissão para acessar essa página!"
    else
    	redirect_to new_usuario_session_path, :alert => "Você precisa estar logado para acessar essa página!"
    end
  end

  protect_from_forgery
  def current_ability
    @current_ability ||= Ability.new(current_usuario)
  end
end
