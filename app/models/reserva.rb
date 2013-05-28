#encoding: utf-8
class Reserva < ActiveRecord::Base
  belongs_to :usuario 
  belongs_to :equipamento
  attr_accessible :horario_final, :horario_inicial, :usuario_id, :equipamento_id
  validates_presence_of :usuario_id, :equipamento_id, :horario_inicial, :horario_final
	validate :validar_horario
end

def validar_horario
	unless (self.horario_final and self.horario_inicial) == nil
		if self.horario_final < self.horario_inicial
			errors.add(:horario_inicial, "tem que ser anterior ao horario final.")
		end
		if self.horario_inicial == self.horario_final
			errors.add(:horario_final, "tem que ser maior que o horario inicial")
		end
	end
	@horarios_iniciais, @horarios_finais = [], []
	Reserva.all.find_all{|reserva| reserva.equipamento_id == self.equipamento_id}.each{|reserva| @horarios_iniciais << reserva.horario_inicial; @horarios_finais << reserva.horario_final}
	@horarios = @horarios_iniciais.zip @horarios_finais	
	@horarios.each do |inicio, fim| 
		if self.horario_inicial.between?(inicio, fim)
			errors.add(:horario_inicial, "não disponível.")
		end

		if inicio.between?(self.horario_inicial, self.horario_final) or fim.between?(self.horario_inicial, self.horario_final)
			errors.add(:base, "Já existe uma reserva dentro desse intervalo de tempo")
		end
		
		if self.horario_final.between?(inicio, fim)
			errors.add(:horario_final, "não disponível.")
		end
	end
end