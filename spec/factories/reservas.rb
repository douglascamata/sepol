# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reserva do
    horario_inicial "2013-05-16 19:00:52"
    horario_final "2013-05-16 19:00:52"
    usuario nil
  end
end
