class CreateReservas < ActiveRecord::Migration
  def change
    create_table :reservas do |t|
      t.datetime :horario_inicial
      t.datetime :horario_final
      t.references :usuario
      t.references :equipamento
      t.timestamps
    end
    add_index :reservas, :usuario_id
  end
end
