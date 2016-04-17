class User < ActiveRecord::Base
  rolify
  after_initialize :make_standard
  has_many :wikis
  devise :timeoutable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def downgrade
    self.remove_role :premium
  end

  private

  def make_standard
    self.add_role :standard
  end

end
