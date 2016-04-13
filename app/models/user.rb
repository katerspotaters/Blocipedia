class User < ActiveRecord::Base
  has_many :wikis
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :confirmable, :lockable, :timeoutable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         before_save { self.email = email.downcase }

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  validates :password, length: { minimum: 6 }, allow_blank: true
   validates :email,
             presence: true,
             uniqueness: { case_sensitive: false },
             length: { minimum: 3, maximum: 254 }

 # #6
   has_secure_password
end
