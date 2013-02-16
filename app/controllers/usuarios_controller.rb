#encoding: utf-8
class UsuariosController < ApplicationController
  def index
  	@usuarios = Usuario.all
  end
end