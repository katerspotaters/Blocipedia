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
       before do
         @public_wiki = Wiki.create!(name: Faker::Hipster.sentence, description: Faker::Lorem.paragraph)
         @private_wiki = Wiki.create!(name: Faker::Hipster.sentence, description: Faker::Lorem.paragraph, public: false)
       end

       describe "visible_to(user)" do
         it "returns all wikis if the user is present" do
           user = User.new
           expect(Wiki.visible_to(user)).to eq(Wiki.all)
         end

         it "returns only public wiki if user is nil" do
           expect(Wiki.visible_to(nil)).to eq([@public_wiki])
         end
       end
     end
  end
