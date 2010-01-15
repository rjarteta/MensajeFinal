class AddTipoToArchivoAtributos < ActiveRecord::Migration
  def self.up
    add_column :atributo_archivos, :tipo, :string
    add_index :atributo_archivos, :tipo
  end

  def self.down
    remove_index :atributo_archivos, :tipo
    remove_column :atributo_archivos, :tipo
  end
end
