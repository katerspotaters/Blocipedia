class CollaboratorsController < ApplicationController

  before_action :set_wiki

  def new
    @collaborator = @wiki.collaborators.new
    authorize @collaborator
  end

  def show
    @collaborator = collaborator.find(params[:id])
  end

  def create
    wiki = Wiki.find(params[:wiki])
    email = params[:collaborators_email]
    user = User.find_by(email: email)
    @collaborator = @wiki.collaborators.new( collaborator_params )

    collaborator = wiki.collaborators.new(user: user)

     if @collaborator.save
       flash[:notice] = "collaborator was saved."
       redirect_to @wiki
     else
       flash[:error] = "Error. Could not save the collaborator."
       redirect_to @wiki
     end
  end

  def destroy
    @collaborator = collaborator.find(params[:id])
    @wiki = @collaborator.wiki

    if @collaborator.destroy
       flash[:notice] = "#{@collaborator.user.email} was successfully removed."
       redirect_to @wiki
     else
       flash[:error] = "Error. Could not remove the collaborator."
       redirect_to @wiki
     end
  end

  private

  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end

  def collaborator_params
    params.require(:collaborator).permit(:wiki_id, :user_id)
  end


end
