class WikiPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def show?
    true
    wiki.private? == false
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    user.present?
  end

  def update?
    user.present?
  end

  def destroy?
    user.present? && (wiki.user == user || user.admin? )
  end

  class Scope < Scope
      def resolve
      if user.admin? || user.moderator?
          scope.all
    else
      scope.where(:user_id => user.id)
     end
   end
end
end
