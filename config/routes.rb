ActionController::Routing::Routes.draw do |map|
  map.auto_complete ':controller/:action',
                  :requirements => { :action => /auto_complete_for_\S+/ },
                  :conditions => { :method => :get }
  
  map.resources :archivos, :collection => {:actualizar_base => :get, :buscar_archivos_para_entrada => :get, :agregar_a_entrada => :get}
  map.resources :entradas
  map.resources :paginas, :member => {:insertar_clave => [:get, :post]}
  map.resources :usuarios, :collection => {:cambiar_pass => [:get, :post], :guardar_cambio_pass => [:get, :post] }, :member => {:editome => :get}
  
  
#   map.with_options(:controller => 'paginas') do |site|
#     site.root                                                    :action => 'show', :url => '/'
#     site.not_found         'error/404',                          :action => 'not_found'
#     site.error             'error/500',                          :action => 'error'
# 
#     # Everything else
#     site.connect           '*url',                               :action => 'show'
#   end
  map.connect "admin", :controller => "paginas", :action => "admin_main"
  map.connect "login", :controller => "usuarios", :action => "login"
  map.connect "logout", :controller => "usuarios", :action => "logout"
  map.root :controller => "paginas", :action => "show", :url => "/"
  map.connect '*url', :controller => "paginas", :action => "show"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
