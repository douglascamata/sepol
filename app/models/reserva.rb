class Reserva < ActiveRecord::Base
  belongs_to :usuario 
  belongs_to :equipamento
  attr_accessible :horario_final, :horario_inicial, :usuario_id, :equipamento_id
  validates_presence_of :usuario_id, :equipamento_id, :horario_inicial, :horario_final
end
