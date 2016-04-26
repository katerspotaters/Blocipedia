class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :wikis

    validates :user_id, presence: true
    validates :wiki_id, presence: true

    after_create :send_collaborator_email

    private
    def send_collaborator_email
      CollaboratorMailer.new_collaborator(self).deliver_now
    end
  end
