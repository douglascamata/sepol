# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reserva do
    horario_inicial Delorean.now
    Delorean.time_travel_to(1.hour.from_now)
    horario_final Delorean.now
    Delorean.back_to_the_present
    usuario
  end
end
	