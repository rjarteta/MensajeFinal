class CreateUsuarios < ActiveRecord::Migration
  def self.up
    create_table :usuarios do |t|
      t.string :nombre
      t.string :localizacion
      t.integer :autorizacion 
      t.string :email
      t.string :password_salt
      t.string :password_hash
      t.binary :imagen

      t.timestamps
    end
    add_index :usuarios, :nombre
    add_index :usuarios, :email, :unique => true
    add_index :usuarios, :localizacion
  end

  def self.down
    drop_table :usuarios
  end
end
