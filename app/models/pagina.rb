class Pagina < ActiveRecord::Base
  has_many :entradas
  belongs_to :pagina_madre, :class_name => "Pagina", :foreign_key => "pagina_madre_id"
  has_many :paginas_hijas, :class_name => "Pagina", :foreign_key => "pagina_madre_id"
  
  validates_presence_of :nombre, :url
  validates_uniqueness_of :url
  
  default_scope :order => "prioridad"
  
  def to_param
    url
  end
  
  def url=(url_from_param)
    if url_from_param.to_s == ""
      durl = self.nombre.parameterize.to_s
      if self.pagina_madre && self.pagina_madre.url == "/" 
        durl = self.pagina_madre.url+durl
      elsif self.pagina_madre
        durl = self.pagina_madre.url+"/"+durl
      end
      write_attribute(:url, durl)
    else 
      write_attribute(:url, url_from_param.lstrip) 
    end
  end
  
  def clave=(clave_from_param)
    if self.pagina_madre and clave_from_param.to_s == ""
      write_attribute(:clave, self.pagina_madre.clave.to_s)
    else
      write_attribute(:clave,clave_from_param.to_s)
    end
  end
  
  def tiene_relaciones?
    self.entradas.count > 0
  end
  
end
