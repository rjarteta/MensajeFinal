class Comentario < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :comentario_incial, :class_name => "Comentario", :foreign_key => "respuesta_comentario_id" 
  has_many :respuestas, :class_name => "Comentario", :foreign_key => "respuesta_comentario_id"
  
  validates_associated :usuario
  validates_presence_of :contenido
end
