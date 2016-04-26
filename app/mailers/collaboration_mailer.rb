class CollaborationMailer < ApplicationMailer
  def new_collaboration(collaboration)

    @collaboration = collaboration

    mail(to: collaboration.user.email, subject: "You have been made a collaborator on a wiki at Wikibloc.")
  end
end
