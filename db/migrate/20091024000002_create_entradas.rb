class CreateEntradas < ActiveRecord::Migration
  def self.up
    create_table :entradas do |t|
      t.string :nombre
      t.string :url
      t.boolean :muestra_contenido
      t.integer :pagina_id
      t.column :contenido, :longtext
      t.integer :usuario_id, :limit => 8
      t.boolean :borrador

      t.timestamps
    end
    add_index :entradas, :nombre
    add_index :entradas, :pagina_id
    add_index :entradas, :usuario_id
  end

  def self.down
    drop_table :entradas
  end
end
