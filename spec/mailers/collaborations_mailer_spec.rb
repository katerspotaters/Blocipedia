class CollaborationMailerPreview < ActionMailer::Preview
  def new_collaboration
    CollaborationMailer.new_collaboration(Collaboration.last)
  end
end
