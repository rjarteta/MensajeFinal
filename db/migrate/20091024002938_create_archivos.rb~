class CreateArchivos < ActiveRecord::Migration
  def self.up
    create_table :archivos do |t|
      t.string :nombre
      t.string :url
      t.integer :tipo
      t.integer :peso, :limit => 8
      t.string :ext
      t.integer :padre_id, :limit => 8
      t.datetime :fecha_fisica

      t.timestamps
    end
    add_index :archivos, :nombre
    add_index :archivos, :url, :unique => true
    add_index :archivos, :tipo
    add_index :archivos, :padre_id
    add_index :archivos, :fecha_fisica
  end

  def self.down
    drop_table :archivos
  end
end
