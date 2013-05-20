# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reserva do
    sequence(:horario_inicial) {|n| "2013-05-16 0#{n}:00:52"}
    sequence(:horario_final) {|n| "2013-05-16 0#{n}:00:52"}
    usuario
  end
end
