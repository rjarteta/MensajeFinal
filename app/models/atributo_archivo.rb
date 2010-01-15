class AtributoArchivo < ActiveRecord::Base
  belongs_to :archivo
  
  validates_associated :archivo
  validates_presence_of :nombre, :valor
  
end