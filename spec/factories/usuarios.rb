# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :usuario do
  	sequence(:nome) {|n| "usuario_%s" % n }
  	sequence(:email) {|n| "usuario#{n}@gmail.com"}
    password "12345678"
    password_confirmation "12345678"
    sequence(:lattes) {|n| "http://buscatextual.cnpq.br/usuario%s" % n}
    cargo 'Pesquisador'
  end
end
