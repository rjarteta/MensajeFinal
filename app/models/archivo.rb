class Archivo < ActiveRecord::Base
  has_many :hijos, :class_name => "Archivo", :foreign_key => "padre_id"
  belongs_to :padre, :class_name => "Archivo", :foreign_key => "padre_id"
  has_many :archivo_entradas
  has_many :entradas, :through => :archivo_entradas
  has_many :atributo_archivos#, :autosave => true
  #accepts_nested_attributes_for :atributo_archivos, :allow_destroy => true
    
  validates_presence_of :nombre, :url, :tipo, :fecha_fisica
  validates_uniqueness_of :url
  
  default_scope :order => "fecha_fisica DESC"
  
  TIPO_ARCHIVO = {"Archivo"=>1,"Carpeta"=>3}
  
  def archivo?
    self.tipo == 1
  end
  
  def carpeta?
    self.tipo == 3
  end
  
  def atributos=(attr_string)
    pares=attr_string.split(';')
    dic = {}
    pares.each{|p| a = p.split('='); dic[a[0]] = a[1]}
    pares = []
    dic.each do |key, val|
      atributo = AtributoArchivo.find_or_create_by_nombre_and_archivo_id(key,self.id)
      atributo.valor = val
      atributo.save false
      pares << atributo
    end
    AtributoArchivo.delete_all(["id not IN ? AND archivo_id = ?", pares.collect{|x| x.id}, self.id])
  end
  
  #informativas
  def liviano?
    self.peso/1024 < 40
  end
end
