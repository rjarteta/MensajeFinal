class Usuario < ActiveRecord::Base
  require 'digest/sha2'
  
  NIVEL_AUTORIZACION = {1 => "administrador", 2 => "colaborador", 3 => "suscriptor"}
  
  has_many :comentarios
  has_many :entradas
  
  validates_length_of :password, :within => 5..40, :unless => :update
  validates_presence_of :password_confirmation, :if => :password_changed
  validates_presence_of :email, :nombre, :autorizacion
  validates_confirmation_of :password, :if => :password_changed
  validates_uniqueness_of :email
  attr_protected :password_salt, :password_hash
  attr :password_changed, true
  attr_reader :password
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :save
  
  def validate_on_create
    errors.add_on_blank("password") if self.password_hash.nil?
  end
  
  def password=(pass)
    unless pass == ""
      self.password_is?(pass) ? self.password_changed = false : self.password_changed = true
      @password = pass
      salt = [Array.new(6){rand(256).chr}.join].pack("m" ).chomp
      self.password_salt, self.password_hash =
        salt, Digest::SHA256.hexdigest(pass + salt)
    end
  end

  def self.authenticate(email, password)
    u = Usuario.find_by_email(email)
    if u.blank? || (not u.password_is?(password))
      raise "Email o clave incorrectos" #I18n.translate "user.wrong_password_on_athethication"
    end
    return u
  end
  
  def password_is?(pass)
    if (password_salt.nil? or password_hash.nil?)
      return false
    else
      return Digest::SHA256.hexdigest(pass + password_salt) == password_hash
    end
  end
  
  def admin?
    self.autorizacion == NIVEL_AUTORIZACION.invert["administrador"]
  end
  
  def colaborador?
    self.autorizacion == NIVEL_AUTORIZACION.invert["colaborador"]
  end
  
  def suscriptor?
    self.autorizacion == NIVEL_AUTORIZACION.invert["suscriptor"]
  end
  
  def tiene_relaciones?
    relaciones = self.entradas.count > 0
    relaciones &= self.comentarios.count > 0
  end
  
end
