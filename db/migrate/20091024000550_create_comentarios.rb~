class CreateComentarios < ActiveRecord::Migration
  def self.up
    create_table :comentarios do |t|
      t.integer :usuario_id
      t.text :contenido
      t.integer :respuesta_comentario_id, :limit => 8

      t.timestamps
    end
    add_index :comentarios, :usuario_id
    add_index :comentarios, :respuesta_comentario_id
  end

  def self.down
    drop_table :comentarios
  end
end
