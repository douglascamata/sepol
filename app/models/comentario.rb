class Comentario < ActiveRecord::Base
  attr_accessible :reserva_id, :autor, :texto
  belongs_to :reserva
  validates_presence_of :reserva_id, :autor, :texto
end
