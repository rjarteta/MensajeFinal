class CreateArchivoEntradas < ActiveRecord::Migration
  def self.up
    create_table :archivo_entradas do |t|
      t.integer :archivo_id, :limit => 8
      t.integer :entrada_id, :limit => 8
      t.boolean :muestra_cont, :default => true
      t.boolean :protegido
      t.integer :orden, :default => 0

      t.timestamps
    end
    add_index :archivo_entradas, :archivo_id
    add_index :archivo_entradas, :entrada_id
    add_index :archivo_entradas, :orden
  end

  def self.down
    drop_table :archivo_entradas
  end
end
