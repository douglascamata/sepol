# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reserva do
    sequence(:horario_inicial) {|n| Time.now + n.days} 
    horario_final {horario_inicial + 1.hour}
    usuario
    equipamento
  end
end
	