class Entrada < ActiveRecord::Base
  has_many :archivo_entradas, :autosave => true
  has_many :archivos, :through => :archivo_entradas
  belongs_to :pagina
  belongs_to :usuario
  
  validates_associated :pagina, :usuario
  validates_presence_of :nombre, :url
  default_scope :order => "updated_at DESC"
  
  def protegida
    self.pagina.clave.to_s != ""
  end
  
  def url=(url_from_param)
    if url_from_param.to_s == "" then write_attribute(:url, self.nombre.parameterize.to_s) else write_attribute(:url, url_from_param.lstrip) end
  end
  
  def display
    self.muestra_contenido ? "block" : "none"
  end
  
  def tiene_relaciones?
    self.archivo_entradas.count > 0
  end
  
end
