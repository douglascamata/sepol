class CreateHomes < ActiveRecord::Migration
  def change
    create_table :homes do |t|
      t.string :titulo
      t.text :conteudo

      t.timestamps
    end
  end
end
