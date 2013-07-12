class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  has_many :reservas

  has_attached_file :avatar, :styles => { :thumb => '170x100>' }, :default_url => "assets/missing.jpg"
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :nome, :cargo, :lattes, :avatar, :admin
  # attr_accessible :title, :body

  validates_presence_of :nome, :cargo
end
