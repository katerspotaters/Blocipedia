class WikiPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def show?
    true
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
    (user.present? && wiki.user == user)
  end

  def destroy?
    user == wiki.user
  end

end
