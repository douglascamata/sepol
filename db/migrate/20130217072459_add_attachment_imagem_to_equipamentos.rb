class AddAttachmentImagemToEquipamentos < ActiveRecord::Migration
  def self.up
    change_table :equipamentos do |t|
      t.attachment :imagem
    end
  end

  def self.down
    drop_attached_file :equipamentos, :imagem
  end
end
