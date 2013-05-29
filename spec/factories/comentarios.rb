# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comentario do
    autor 'Autor'
    texto "MyText"
    reserva
  end
end
