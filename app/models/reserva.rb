class Reserva < ActiveRecord::Base
  belongs_to :usuario 
  belongs_to :equipamento
  attr_accessible :horario_final, :horario_inicial, :usuario_id, :equipamento_id
  validates_presence_of :usuario_id, :equipamento_id, :horario_inicial, :horario_final
	before_save :verificar_disponibilidade_de_horario
end

def verificar_disponibilidade_de_horario
	@horarios_iniciais = []
	@horarios_finais = []
	Reserva.all.each{|reserva| @horarios_iniciais << reserva.horario_inicial; @horarios_finais << reserva.horario_final}
	
	@horarios = @horarios_iniciais.zip @horarios_finais	
	@horarios.each{|inicio, fim| raise ArgumentError if self.horario_inicial.between? inicio, fim}
end