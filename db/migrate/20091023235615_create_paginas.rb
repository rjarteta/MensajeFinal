class CreatePaginas < ActiveRecord::Migration
  def self.up
    create_table :paginas do |t|
      t.string :nombre
      t.string :url
      t.integer :pagina_madre_id
      t.column :descripcion, :longtext
      t.string :clave
      t.boolean :borrador

      t.timestamps
    end
    
    add_index :paginas, :nombre
    add_index :paginas, :url, :unique => true
    add_index :paginas, :pagina_madre_id
  end

  def self.down
    drop_table :paginas
  end
end
