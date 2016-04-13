require 'faker'

5.times do
  user = User.new(
    name:       Faker::Name.name,
    email:      Faker::Internet.email,
    password:   Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

100.times do
  wiki = Wiki.new(
    user:      users.sample,
    title:     Faker::Lorem.sentence,
    body:      Faker::Lorem.paragraph
    )
  wiki.save!
end
wikis = Wiki.all


puts "Seeds Finished"
puts "#{User.count} users were created"
puts "#{Wiki.count} wikis were created"
