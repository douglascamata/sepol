class Resultado < ActiveRecord::Base
  belongs_to :reserva
  attr_accessible :imagem
  has_attached_file :imagem, :styles => { :medium => "800x600>", :thumb => "200x200#" }

	attr_accessible :reserva_id
  validates_presence_of :reserva_id
end
