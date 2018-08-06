#FactoryBot.define do
#  factory :card do
#    title "MyString"
#    description "MyText"
#    list nil
#  end
#end

# spec/factories/cards.rb
FactoryBot.define do
  factory :card do
    title { Faker::StarWars.character }
    description { Faker::Lorem.word }
    list_id nil
  end
end
