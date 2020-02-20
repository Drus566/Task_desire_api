# Users

10.times do |i| 
    User.create(
        login: "user#{i}",
        name: Faker::Name.name_with_middle,
        sign: Faker::Name.initials,
        password: '123456'
    )
end

# Articles

50.times do |i|
    @user_id = Random.rand(1..5) 
    @article = Article.create(
        head: Faker::Lorem.words(number: 1, supplemental: true).join,
        announcement: Faker::Lorem.paragraph(sentence_count: 2),
        content: Faker::Lorem.sentences(number: 5, supplemental: true).join,
        status: [true, false].sample,
        user_id: @user_id
    )

    # Authors reads own articles
    
    @author = User.find(@user_id)
    @author.looks.create(article_id: @article.id)
end

# Some non-authors read articles 

@users = User.non_authors
@articles = Article.all

@users.each do |user|
    user.looks.create(article_id: @articles.sample.id)
end

# Add to favorites

@users = User.all

@users.each do |user|
    user.favorites.create(article_id: @articles.sample.id)
end

puts 'Database has been seeded'
