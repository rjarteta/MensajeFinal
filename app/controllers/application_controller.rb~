# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation, :clave
  # filter_parameter_logging :password
  before_filter :set_locale
  def set_locale
    ## if params[:locale] is nil then I18n.default_locale will be used
    I18n.locale = params[:locale]
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end
  
  helper_method :current_user, :logueado?
 
  def current_user
    @current_user ||= ((session[:usuario_id] && Usuario.find_by_id(session[:usuario_id])) || 0)
  end
 
  def logueado?
    current_user != 0
  end
  
  def solo_admins
    if not (logueado? && current_user.admin?)
      flash[:error] = "Usuario no autorizado para navegar acá"
      redirect_to root_url
    end
  end
  
  def solo_colaboradores
    permiso = logueado? && current_user.colaborador?
    if not permiso
      flash[:error] = "Usuario no autorizado para navegar acá"
      redirect_to root_url
    end
  end
  
  def solo_logueados
    if not logueado?
      flash[:error] = "Inicia sesión primero"
      session["requested_uri"] = request.request_uri
      redirect_to "/login"
    end
  end
  
  def super_mantenedor_de_consistencia
    ArchivoEntrada.delete_all("NOT EXISTS (SELECT id FROM archivos WHERE archivo_id = archivos.id)")
    AtributoArchivo.delete_all("NOT EXISTS (SELECT id FROM archivos WHERE archivo_id = archivos.id)")
  end

end
