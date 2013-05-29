class CreateComentarios < ActiveRecord::Migration
  def change
    create_table :comentarios do |t|
      t.string :autor
      t.references :reserva
      t.text :texto

      t.timestamps
    end
  end
end
