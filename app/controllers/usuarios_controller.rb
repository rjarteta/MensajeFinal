class UsuariosController < ApplicationController
  layout "admin", :except => ["login", "editome"]
  before_filter :solo_admins, :except => ["login", "logout", "cambiar_pass", "guardar_cambio_pass", "editome", "guardar_editome", "update"]
  
  
  def index
    options = {:page => params[:page], :per_page => 15, :order => "id DESC"}
    options[:conditions] = ["UPPER(email) LIKE :s OR UPPER(nombre) LIKE UPPER(:s)", {:s => "%#{params[:s]}%"}] if params[:s]
    @usuarios = Usuario.paginate :all, options
  end

  def show
    @usuario = Usuario.find params[:id]
  end

  def new
    @usuario = Usuario.new
  end
  
  def create
    @usuario = Usuario.new params[:usuario]
    if @usuario.save
      flash[:notice] = "Usuario Creado"
      redirect_to @usuario
    else
      render :new
    end
  end

  def edit
    @usuario = Usuario.find params[:id]
  end
  
  def update
    @usuario = Usuario.find params[:id]
    if @usuario.update_attributes params[:usuario]
      flash[:notice] = "Usuario Actualizado"
      if @usuario.admin? then redirect_to @usuario else redirect_to root_url end
    else
      if @usuario.admin? then render :edit else render :layout => "mensajefinal", :action => "editome" end
    end
  end
  
  def destroy
    @usuario = Usuario.find params[:id]
    if current_user.admin? && @usuario != current_user
      @usuario.destroy
      flash[:notice] = "Usuario eliminado"
      redirect_to :index
    else
      flash[:error] = "No te pases de listo"
      redirect_to :controller => "admin"
    end
  end

  def cambiar_pass
    if request.post?
      @usuario = Usuario.find_by_email(params[:email])
      if @usuario
        Mailer.deliver_password_olvidado(usuario, usuario.password_hash[7..24])
        flash[:notice] = "Revisa tu correo para terminar el cambio de contraseña"
        redirect_to :login
      else
        flash[:error] = "Usuario no encontrado"
      end
    end
  end
  
  def guardar_cambio_pass
    @cseguridad = params["cseguridad"]
    if request.get?
      @usuario = Usuario.find_by_id params[:id]
      if @usuario && @usuario.password_hash[7..24] == @cseguridad
        flash[:notice] = "Ha solicitado cambio de clave"
      else
        flash["error"] = "Clave de seguridad o usuario desconocidos"
        redirect_to "/login"
      end
    elsif request.post?
      if @usuario.update_attributes params[:usuario]
        flash[:notice] = "Contraseña cambiada exitosamente"
        redirect_to "/login"
      else
        @usuario.reload
      end
    end 
  end
  
  def login
    if request.post?
      begin
        @usuario = Usuario.authenticate(params[:email], params[:password])
        if @usuario
          flash[:notice] = "Bienvenid@ #{@usuario.nombre}"
          session[:usuario_id] = @usuario.id
          if session["requested_uri"]
            redirect_to session["requested_uri"]
          elsif @usuario.admin?
            redirect_to "/admin"
          else
            redirect_to root_url
          end
        end
      rescue
        flash[:error] = $!
        redirect_to "/login"
      end
    else
      render :layout => "mensajefinal"
    end
  end
  
  def logout
    reset_session
    flash[:notice] = "Sesión cerrada."
    redirect_to root_url
  end
  
  def editome
    @usuario = Usuario.find params[:id]
    if not @usuario.id == current_user.id
      flash[:error] = "No puedes modificar los datos de otro usuario"
      redirect_to root_url
    else
      render :layout => "mensajefinal"
    end
  end

end
