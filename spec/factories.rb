FactoryBot.define do

    factory :article do
        head { Faker::Lorem.words(number: 1, supplemental: true).join }
        announcement { Faker::Lorem.paragraph(sentence_count: 2) }
        content { Faker::Lorem.sentences(number: 5, supplemental: true).join }
        status { [true, false].sample }
        user
    end

    factory :user do
        login { Faker::Name.name }
        name { Faker::Name.name_with_middle }
        sign { Faker::Name.initials }
        password { "123456" }

        factory :user_with_articles do 
            transient do
                articles_count { 5 }
            end

            after(:create) do |user, evaluator|
                create_list(:article, evaluator.articles_count, user: user)
                # create_list(:look, evaluator.articles_count, user: user,)
            end
        end
    end

    factory :look do 
        user
        article
    end

    factory :favorite do 
        user
        article
    end
end