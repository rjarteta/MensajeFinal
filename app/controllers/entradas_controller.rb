class EntradasController < ApplicationController
  layout 'admin'
  before_filter :solo_admins
  
  def index
    conditions = {}
    conditions ||= ["UPPER(nombre) LIKE UPPER(:s)", {:s => "%#{params[:s]}%"}] if params[:s].to_s != ""
    @entradas = Entrada.paginate :all, :page => params[:page], :per_page => 15, :order => "id DESC", conditions
  end

  def show
    @entrada = Entrada.find params[:id]
  end

  def new
    pagina = {}
    pagina[:pagina_id] = params[:pagina_id].to_i if params[:pagina_id]
    @entrada = Entrada.new pagina
    @archivos = Hash.new
  end
  
  # archivos => {"a1" => {"id" => 2, "muestra_cont" => true}, "a2" => {"id" => 90, "muestra_cont" => false}}
  def create
    @entrada = Entrada.new params[:entrada]
    @archivos = params[:archivos]
    if @entrada.save
      enlazar_archivos @archivos, @entrada
      flash[:notice] = "Entrada creada"
      redirect_to "/"+@entrada.pagina.url+"##{@entrada.url}"
    else
      render :new
    end
  end

  def edit
    @entrada = Entrada.find params[:id]
  end
  
  def update
    @entrada = Entrada.find params[:id]
    @archivos = params[:archivos]
    if @entrada.update_attributes params[:entrada]
      enlazar_archivos @archivos, @entrada
      flash[:notice] = "Entrada actualizada"
      redirect_to "/"+@entrada.pagina.url+"##{@entrada.url}"
    else
      render :edit    
    end
  end
  
  def destroy
    @entrada = Entrada.find params[:id]
    if @entrada.tiene_relaciones?
      flash[:error] = "Entrada no puede ser eliminada"
    else
      flash[:notice] = "Entrada eliminada"
      @entrada.destroy
    end
    redirect_to :action => "index"
  end

private
  def enlazar_archivos(archivos_from_params, entrada)
    archivos_entradas_ids = []
    archivos = {}; archivos ||= archivos_from_params
    archivos.each do |key, value|
      if key =~ /archivo_/
        archivo_id = value.to_i
        archivo_entrada = ArchivoEntrada.find_or_create_by_archivo_id_and_entrada_id(archivo_id,entrada.id)
        archivo_entrada.orden = archivos["orden_#{archivo_id}"].to_i
        archivo_entrada.muestra_cont = archivos["muestra_contenido_#{archivo_id}"] && archivos["muestra_contenido_#{archivo_id}"].to_i == 1 ? true : false
        archivo_entrada.save!
        archivos_entradas_ids << archivo_entrada.id
      end
    end
    options_for_delete = ["entrada_id = ?", entrada.id]
    unless archivos_entradas_ids.empty?
      options_for_delete[0] += " AND id NOT IN (?)"
      options_for_delete << archivos_entradas_ids
    end
    ArchivoEntrada.delete_all(options_for_delete)
  end
   
end
