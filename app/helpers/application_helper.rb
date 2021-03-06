# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    
  #Peso de un archivo
  def peso?(archivo)
    if archivo.peso > 1024
      number_with_precision(archivo.peso.to_f / 1024, :precision => 2) + " MB"
    else
      archivo.peso.to_s+" KB"
    end
  end
  
end
