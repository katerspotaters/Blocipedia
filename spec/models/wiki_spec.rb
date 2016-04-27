require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the WikisHelper. For example:
#
# describe WikisHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end

# end
RSpec.describe Wiki, type: :model do
  let(:wiki) { Wiki.create!(title: "New Wiki Title", body: "New Wiki Body") }
  let(:user) { User.create!(email: "test@example.com", password: "helloworld")}

   describe "attributes" do
     it "has title and body attributes" do
       expect(wiki).to have_attributes(title: "New Wiki Title", body: "New Wiki Body")
     end
   end

  describe User do
    before(:each) { @user = User.new(email: 'user@example.com') }
    subject { @user }
    it { should respond_to(:email) }
    it "#email returns a string" do
      expect(@user.email).to match 'user@example.com'
    end
  end


  describe "scopes" do
    let(:private_wiki) { Wiki.create!(title: "Private Wiki", body: "This is a private wiki.", private: true, user: user)}
    let(:other_user) { User.create!(email: "other@example.com", password: "helloworld")}
    let(:other_user_wiki) { Wiki.create!(title: "Someone else's private wiki", body: "Someone elses wiki.", private: true, user: other_user)}

    describe "visible_to(user)" do
      it "returns all public wikis" do
        expect(Wiki.visible_to(user)).to eq(Wiki.publicly_viewable)
      end

      it "doesnt return a private wiki" do
        expect(Wiki.visible_to(user)).not_to include(private_wiki)
      end

      it "shows premium user all wikis" do
        user.add_role :premium

        expect(Wiki.visible_to(user)).to include(private_wiki)
      end
       end
     end
  end
