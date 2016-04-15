class User < ActiveRecord::Base
  rolify
  after_initialize :before_add_method

  def before_add_method
    self.add_role :standard
  end

  has_many :wikis
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :timeoutable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
