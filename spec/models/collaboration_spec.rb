require 'rails_helper'

RSpec.describe Collaboration, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:wiki) }

  let(:user) { User.create!(email: "test@example.com", password: "helloworld")}
  let(:wiki) { Wiki.create!(title: "Test Wiki", body: "This is a test wiki entry.", private: false, user: user)}

  describe "mailer callback" do
    before do
      @collaboration = Collaboration.new(user: user, wiki: wiki)
    end

    it "emails collaborators" do
      expect(CollaborationMailer).to receive(:new_collaboration).with(@collaboration).and_return(double(deliver_now: true))

      @collaboration.save!
    end
  end
end
