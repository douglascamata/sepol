class Equipamento < ActiveRecord::Base
  has_attached_file :imagem, :styles => { :medium => "800x600>", :thumb => "200x200#" }		
  
  attr_accessible :descricao, :nome, :imagem
  self.per_page = 12
end
