class CollaboratorMailerPreview < ActionMailer::Preview
  def new_collaborator
    CollaboratorMailer.new_collaborator(collaborator.last)
  end
end
