class AddPrioridadToPaginas < ActiveRecord::Migration
  def self.up
    add_column :paginas, :prioridad, :integer
  end

  def self.down
    remove_column :paginas, :prioridad
  end
end
