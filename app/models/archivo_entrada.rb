class ArchivoEntrada < ActiveRecord::Base
  belongs_to :archivo
  belongs_to :entrada
  
  validates_associated :archivo, :entrada
  default_scope :order => "orden"
  
  #Manda según la relación, si por estilos se muestra en bloque o escondido
  def display
    self.muestra_cont ? "block" : "none"
  end
end
