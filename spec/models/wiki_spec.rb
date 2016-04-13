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
end
