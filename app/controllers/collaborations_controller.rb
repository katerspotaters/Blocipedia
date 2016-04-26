class CollaborationsController < ApplicationController

  before_action :set_wiki

  def new
    @collaboration = @wiki.collaborations.new
    authorize @collaboration
  end

  def show
    @collaboration = Collaboration.find(params[:id])
  end

  def create
    wiki = Wiki.find(params[:wiki])
    email = params[:collaborations_email]
    user = User.find_by(email: email)
    @collaboration = @wiki.collaborations.new( collaboration_params )

    collaborator = wiki.collaborators.new(user: user)

     if @collaboration.save
       flash[:notice] = "Collaboration was saved."
       redirect_to @wiki
     else
       flash[:error] = "Error. Could not save the collaboration."
       redirect_to @wiki
     end
  end

  def destroy
    @collaboration = Collaboration.find(params[:id])
    @wiki = @collaboration.wiki

    if @collaboration.destroy
       flash[:notice] = "#{@collaboration.user.email} was successfully removed."
       redirect_to @wiki
     else
       flash[:error] = "Error. Could not remove the collaboration."
       redirect_to @wiki
     end
  end

  private

  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end

  def collaboration_params
    params.require(:collaboration).permit(:wiki_id, :user_id)
  end


end
