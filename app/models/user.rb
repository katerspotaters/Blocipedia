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

     def standard?
       self.has_role? :standard
     end

     def premium?
       self.has_role? :premium
     end

     def admin?
       self.has_role? :admin
     end

     def downgrade_account
       self.remove_role :premium
     end

     private

     def make_standard
       self.role = 'standard'
     end

end
