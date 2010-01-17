class ArchivosController < ApplicationController
  layout 'admin'
  
  ATRIBUTOS_COMUNUES = AtributoArchivo.find :all, :select => "nombre", :group => "nombre"
  
  def index
    redirect_to :action => 'index' if params[:page] && params[:page].to_i == 1
    params[:page] ||= 1
    
    conditions = []
    conditions = ["(UPPER(url) LIKE :nombre or UPPER(nombre) LIKE :nombre)", {:nombre => "%#{params[:buscar]}%"}] if params[:clave].to_s != ""
    if params[:tipo].to_s != ""
      if params[:clave].to_s != ""
        conditions[0] += " AND" 
        conditions[0] += " tipo = :tipo"
      else
        conditions[0] = " tipo = :tipo"
        conditions[1] = {}
      end
      conditions[1][:tipo] = params[:tipo].to_i
    end
    @archivos = Archivo.paginate(:all, :page => params[:page], :per_page => 15, :conditions => conditions)
  end
  
  def auto_complete_for_archivo_url
    @carpetas_encontradas = Archivo.all(:limit => 15, :order => "updated_at DESC", :conditions => ["tipo = ? AND UPPER(url) LIKE UPPER(?)", Archivo::TIPO_ARCHIVO["Carpeta"], "%#{params[:archivo][:url]}%"])
    render :partial => "carpetas_encontradas"
  end
  
  #Params: s
  def buscar_archivos_para_entrada
    @s = params[:s]
    conditions = ["UPPER(url) LIKE UPPER(?)", "%#{@s}%"]
    if params[:solo_carpeta].to_i == 1
      conditions[0] += " AND tipo = ?"
      conditions << Archivo::TIPO_ARCHIVO["Carpeta"]
    end
        
    @archivos = Archivo.paginate(:conditions => conditions, :page => params[:page], :per_page => 10, :order => "ID desc")
    respond_to do |format|
      format.js {
        render :update do |page|
        page.replace "resultados_busqueda", :partial => "archivos_para_entrada"
      end
        }
    end
  end
  
  def agregar_a_entrada
    @archivo = Archivo.find params[:archivo_id]
  end

  def edit
    @archivo = Archivo.find params[:id]
  end

  def update
    @archivo = Archivo.find params[:id]
    if @archivo.update_attributes params[:archivo]
      flash[:notice] = "Archivo actualizado"
      redirect_to :action => "index"
    else
      render :action => "edit"
    end
  end

  def actualizar_base
    params[:archivo][:url] == "" ? url="/archivos" : url = params[:archivo][:url]
    begin
      into_db(url)
    rescue SystemCallError
      render :text => "El directorio #{dir} no existe!!"
    else
      flash[:notice] = "Base de datos actualizada satisfactoriamente"
      redirect_to :action => "index"
    end
  end

  def relacionar
  end
  
protected
  def into_db(url) #Busca recursivamente en el directorio dado
    padre = Archivo.find_by_url(url)
    dir = RAILS_ROOT+url
    archivos = Dir.entries(dir)
    archivos.delete_if{|x| x == "." or x == ".."}
    #puts archivos.inspect
    archivos.each do |archivo|
      dirs_hijos = Array.new
      dir_archivo = dir+"/"+%{#{archivo}}
      url_hijo = url+"/"+%{#{archivo}}
      pwf_archivo = Archivo.find_by_url(url_hijo)
      if not pwf_archivo
        a = Archivo.new(:url => url_hijo, :nombre => %{#{archivo}}, :peso => 0, :fecha_fisica => File.new(dir_archivo).mtime)
        if File.directory?(dir_archivo)
          a.tipo = Archivo::TIPO_ARCHIVO["Carpeta"]
          dirs_hijos << url_hijo
        elsif File.file?(dir_archivo)
          a.tipo = Archivo::TIPO_ARCHIVO["Archivo"]
          a.peso = File.size?(dir_archivo).to_i / 1024
        end
        a.padre = padre if padre
        a.save!
        dirs_hijos.each do |d|
          into_db(d)
        end
      elsif pwf_archivo.carpeta?
        into_db(url_hijo)
      end
      mantenedor_consistencia(url)
    end
  end
  
   def mantenedor_consistencia(url)
    raiz = Archivo.find_by_url(url)
    #Otro tipo de mantenedor TODO
    
    return unless raiz
    if not File.exist?(RAILS_ROOT+raiz.url)
      raiz.delete
      Archivo.delete_all ["url LIKE ?", "#{url}/%"]
      return
    else
      Archivo.find_each :conditions => ["url LIKE ?", "#{url}/%"] do |archivo|
        archivo.delete if not File.exist?(RAILS_ROOT+archivo.url)
      end
    end
    super_mantenedor_de_consistencia
  end
  
  def cortar_ext(nombre)
    n = nombre.split(".")
    n.pop; m = String.new
    n.each do |i|
      m += i
      m += "." unless i == n.last
    end
    m
  end

end
