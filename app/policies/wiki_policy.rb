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

class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.has_role == 'admin'
        wikis = scope.all # if the user is an admin, show them all the wikis
      elsif user.has_role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.public? || wiki.owner == user || wiki.collaborators.include?(user)
            wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
          end
        end
      else # this is the lowly standard user
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.public? || wiki.collaborators.include?(user)
            wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
          end
        end
      end
      wikis # return the wikis array we've built up
    end
  end
end
