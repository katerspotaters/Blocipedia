class User < ActiveRecord::Base
  rolify
  after_initialize :before_add_method

      def before_add_method
        self.add_role :standard
      end

  has_many :wikis
  has_many :collaborators
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :timeoutable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

     def standard?
       self.has_role? :standard
     end

     def premium?
       self.has_role? :premium
     end

     def admin?
       self.has_role? :admin
     end

     def downgrade
       self.remove_role :premium
     end

     private

     def make_standard
       self.add_role = 'standard'
     end

end
