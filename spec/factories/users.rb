FactoryGirl.define do
  factory :user do
    encrypted_password { Faker::Internet.password(10, 20) }
    email "123@abc.com"
    password "helloworld"
  end
end
