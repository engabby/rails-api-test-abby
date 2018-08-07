#FactoryBot.define do
#  factory :user do
#    username "MyString"
#    email "MyString"
#    password_digest "MyString"
#    is_admin false
#  end
#end

# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    username { Faker::Name.name }
    email 'foo@bar.com'
    password 'foobar'
    is_admin false
  end
end
