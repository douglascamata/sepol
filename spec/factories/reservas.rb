# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reserva do
    horario_inicial Time.now
    horario_final {horario_inicial + 2.hours}
    usuario
  end
end
	