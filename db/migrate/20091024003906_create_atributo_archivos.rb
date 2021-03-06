class CreateAtributoArchivos < ActiveRecord::Migration
  def self.up
    create_table :atributo_archivos do |t|
      t.integer :archivo_id
      t.string :nombre
      t.text :valor

      t.timestamps
    end
    add_index :atributo_archivos, :archivo_id
    add_index :atributo_archivos, [:archivo_id, :nombre], :unique => true
    
  end

  def self.down
    drop_table :atributo_archivos
  end
end
