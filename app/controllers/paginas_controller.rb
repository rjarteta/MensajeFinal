class PaginasController < ApplicationController
  layout 'admin', :except => ["show", "insertar_clave"]
  before_filter :solo_admins, :except => ["show", "insertar_clave"]
  
  def index
    @paginas = Pagina.all
  end

  def show
    if params[:url].kind_of? Array
      url = params[:url].join("/")
    else
      url = params[:url].to_s
    end
    
    url = "/"+url unless url.start_with?("/")
    
    #@pagina = url == "/" ? Pagina.find_by_url("/") : Pagina.find_by_url(url)
    @pagina = Pagina.find_by_url(url)
    
    clave = session[:clave]
    clave ||= ""
    
    
    if @pagina
      if clave == @pagina.clave.to_s
        render :layout => "mensajefinal"
      elsif @pagina.clave.to_s != "" and not logueado?
        redirect_to :action => "insertar_clave", :id => @pagina.id
      else
        render :layout => "mensajefinal"
      end
    else
      render "no_encontrado", :status => 404, :layout => "mensajefinal"
    end
    
  end

  def new
    @pagina = Pagina.new
  end
  
  def create
    @pagina = Pagina.new params[:pagina]
    if @pagina.save
      redirect_to @pagina.url
    else
      render :new
    end
  end

  def edit
    @pagina = Pagina.find params[:id]
  end
  
  def update
    @pagina = Pagina.find params[:id]
    if @pagina.update_attributes(params[:pagina])
      redirect_to @pagina.url
    else
      render :update
    end
  end
  
  def destroy
    @pagina = Pagina.find params[:id]
    unless @pagina.tiene_relaciones?
      @pagina.delete
      flash[:notice] = "Página eliminada"
    else
      flash[:error] = "La página tiene entradas asociadas, no se puede eliminar"
    end
    redirect_to :index
  end
  
  def admin_main
    render :layout => "admin", :text => "Bienvenido a la admin"
  end
  
  def insertar_clave
    @pagina = Pagina.find params[:id]
    if request.post?
      if params[:clave] != @pagina.clave
        flash[:error] = "Clave incorrecta"
        render :layout => "mensajefinal"
      else
        session[:clave] = @pagina.clave.to_s
        redirect_to @pagina.url
      end
    else
      render :layout => "mensajefinal"
    end
  end

end
