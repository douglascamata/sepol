class CreateEquipamentos < ActiveRecord::Migration
  def change
    create_table :equipamentos do |t|
      t.string :nome
      t.text :descricao

      t.timestamps
    end
  end
end
