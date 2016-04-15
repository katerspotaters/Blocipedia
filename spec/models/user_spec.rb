require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(email: "user@blocipedia.com", password: "password") }

   it { is_expected.to validate_presence_of(:email) }
   it { is_expected.to validate_uniqueness_of(:email) }
   it { is_expected.to allow_value("user@blocipedia.com").for(:email) }

   it { is_expected.to validate_presence_of(:password) }
   it { is_expected.to validate_length_of(:password).is_at_least(8) }

   describe "attributes" do
     it "should have name and email attributes" do
       expect(user).to have_attributes(email: "user@blocipedia.com")
     end
   end

   describe "invalid user" do
  let(:user_with_invalid_name) { User.new(email: "user@blocipedia.com") }
  let(:user_with_invalid_email) { User.new(email: "") }

  it "should be an invalid user due to blank name" do
    expect(user_with_invalid_name).to_not be_valid
  end

  it "should be an invalid user due to blank email" do
    expect(user_with_invalid_email).to_not be_valid
  end

end
end
