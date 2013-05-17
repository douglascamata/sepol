# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :equipamento do
    nome "MyString"
    descricao "MyText"
    imagem {fixture_file_upload('spec/suport/equipamento_default.jpg', 'image/jpg')}
  end
end
