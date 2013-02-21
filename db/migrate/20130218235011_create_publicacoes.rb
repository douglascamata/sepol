class CreatePublicacoes < ActiveRecord::Migration
  def change
    create_table :publicacoes do |t|
      t.string :titulo
      t.text :abstract
      t.text :link

      t.timestamps
    end
  end
end
