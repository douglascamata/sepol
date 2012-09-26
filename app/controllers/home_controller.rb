#encoding: utf-8
class HomeController < ApplicationController
  def index
  	@home = Home.new titulo: 'Sepol', conteudo: 'Bem vindo a Pagina do Setor de Polímeros da UENF'
  end
end