class WikisController < ApplicationController
  #include WikisHelper
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    @wikis = Wiki.visible_to(current_user)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Updated the wiki."
      redirect_to @wiki
    else
      flash[:error] = "Could not update wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      redirect_to @wiki, notice: "Wiki deleted"
    else
      flash[:alert] = "Unable to delete wiki. Try again."
      render :show
    end
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.new[:alert] = "There was an error saving the post. Please try again."
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
