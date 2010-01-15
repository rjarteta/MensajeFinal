# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100103051935) do

  create_table "archivo_entradas", :force => true do |t|
    t.integer  "archivo_id",   :limit => 8
    t.integer  "entrada_id",   :limit => 8
    t.boolean  "muestra_cont",              :default => true
    t.boolean  "protegido"
    t.integer  "orden",                     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "archivo_entradas", ["archivo_id"], :name => "index_archivo_entradas_on_archivo_id"
  add_index "archivo_entradas", ["entrada_id"], :name => "index_archivo_entradas_on_entrada_id"
  add_index "archivo_entradas", ["orden"], :name => "index_archivo_entradas_on_orden"

  create_table "archivos", :force => true do |t|
    t.string   "nombre"
    t.string   "url"
    t.integer  "tipo"
    t.integer  "peso",         :limit => 8
    t.string   "ext"
    t.integer  "padre_id",     :limit => 8
    t.datetime "fecha_fisica"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "archivos", ["fecha_fisica"], :name => "index_archivos_on_fecha_fisica"
  add_index "archivos", ["nombre"], :name => "index_archivos_on_nombre"
  add_index "archivos", ["padre_id"], :name => "index_archivos_on_padre_id"
  add_index "archivos", ["tipo"], :name => "index_archivos_on_tipo"
  add_index "archivos", ["url"], :name => "index_archivos_on_url", :unique => true

  create_table "atributo_archivos", :force => true do |t|
    t.integer  "archivo_id"
    t.string   "nombre"
    t.text     "valor"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tipo"
  end

  add_index "atributo_archivos", ["archivo_id", "nombre"], :name => "index_atributo_archivos_on_archivo_id_and_nombre", :unique => true
  add_index "atributo_archivos", ["archivo_id"], :name => "index_atributo_archivos_on_archivo_id"
  add_index "atributo_archivos", ["tipo"], :name => "index_atributo_archivos_on_tipo"

  create_table "comentarios", :force => true do |t|
    t.integer  "usuario_id"
    t.text     "contenido"
    t.integer  "respuesta_comentario_id", :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comentarios", ["respuesta_comentario_id"], :name => "index_comentarios_on_respuesta_comentario_id"
  add_index "comentarios", ["usuario_id"], :name => "index_comentarios_on_usuario_id"

  create_table "entradas", :force => true do |t|
    t.string   "nombre"
    t.string   "url"
    t.boolean  "muestra_contenido"
    t.integer  "pagina_id"
    t.text     "contenido",         :limit => 2147483647
    t.integer  "usuario_id",        :limit => 8
    t.boolean  "borrador"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entradas", ["nombre"], :name => "index_entradas_on_nombre"
  add_index "entradas", ["pagina_id"], :name => "index_entradas_on_pagina_id"
  add_index "entradas", ["usuario_id"], :name => "index_entradas_on_usuario_id"

  create_table "paginas", :force => true do |t|
    t.string   "nombre"
    t.string   "url"
    t.integer  "pagina_madre_id"
    t.text     "descripcion",     :limit => 2147483647
    t.string   "clave"
    t.boolean  "borrador"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "prioridad"
  end

  add_index "paginas", ["nombre"], :name => "index_paginas_on_nombre"
  add_index "paginas", ["pagina_madre_id"], :name => "index_paginas_on_pagina_madre_id"
  add_index "paginas", ["url"], :name => "index_paginas_on_url", :unique => true

  create_table "relacion_archivos", :force => true do |t|
    t.integer  "archivo_orig_id", :limit => 8, :null => false
    t.integer  "archivo_dest_id", :limit => 8, :null => false
    t.integer  "tipo_relacion",   :limit => 2
    t.text     "desc_relacion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relacion_archivos", ["archivo_dest_id"], :name => "index_relacion_archivos_on_archivo_dest_id"
  add_index "relacion_archivos", ["archivo_orig_id"], :name => "index_relacion_archivos_on_archivo_orig_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "usuarios", :force => true do |t|
    t.string   "nombre"
    t.string   "localizacion"
    t.integer  "autorizacion"
    t.string   "email"
    t.string   "password_salt"
    t.string   "password_hash"
    t.binary   "imagen"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true
  add_index "usuarios", ["localizacion"], :name => "index_usuarios_on_localizacion"
  add_index "usuarios", ["nombre"], :name => "index_usuarios_on_nombre"

end
