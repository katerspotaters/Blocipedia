class WikisController < ApplicationController
  #include WikisHelper
  #rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.update_attributes(wiki_params)
      @wiki.collaborators = Collaborator.update_collaborators(@wiki, params[:wiki][:collaborators]) if collab_authorized?(@wiki)
      redirect_to [@wiki.user, @wiki], notice: "Wiki updated"
    else
      flash[:alert] = "Unable to update wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      redirect_to user_wikis_path, notice: "Wiki deleted"
    else
      flash[:alert] = "Unable to delete wiki. Try again."
      render :show
    end
  end

  def new
    @user = current_user
    @wiki = @user.wikis.new
  end

  def create
    @wiki = Wiki.new
    #Devise has a special method called current_user that you can use to get the current signed in user!
    @wiki = current_user.wikis.build(wiki_params)

    if @wiki.save
      flash[:notice] = "Wiki was saved successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving your wiki. Please try again."
      render :new
    end
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action"
    redirect_to(request.referer || root_path)
  end

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

end
