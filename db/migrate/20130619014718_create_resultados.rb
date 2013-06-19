class CreateResultados < ActiveRecord::Migration
  def change
    create_table :resultados do |t|
      t.references :reserva
      t.attachment :imagem

      t.timestamps
    end
    add_index :resultados, :reserva_id
  end
end
