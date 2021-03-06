class Equipamento < ActiveRecord::Base
  has_many :reservas
  has_attached_file :imagem, :styles => { :medium => "800x600>", :thumb => "280x200#" }		
  
  validates_presence_of :nome, :descricao, :imagem

  attr_accessible :descricao, :nome, :imagem
  self.per_page = 4
end
