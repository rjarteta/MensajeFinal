class CreateRelacionArchivos < ActiveRecord::Migration
  def self.up
    create_table :relacion_archivos do |t|
      t.integer :archivo_orig_id, :limit => 8, :null => false
      t.integer :archivo_dest_id, :limit => 8, :null => false
      t.integer :tipo_relacion, :limit => 2
      t.text :desc_relacion

      t.timestamps
    end
    add_index :relacion_archivos, :archivo_orig_id
    add_index :relacion_archivos, :archivo_dest_id
    
  end

  def self.down
    drop_table :relacion_archivos
  end
end
