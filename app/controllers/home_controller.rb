#encoding: utf-8
class HomeController < ApplicationController
	load_and_authorize_resource
  def index
  	@home = Home.new titulo: 'Sepol', conteudo: 'Bem vindo a Pagina do Setor de Polímeros da UENF'
  end
end