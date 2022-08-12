# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

dummy_posts = [
  {
    title: "Why study in the UK?",
    # write article about why you should study in the UK
    tags: [{ name: "study" }, { name: "uk" }, { name: "abroad" }],
    body: "You can study in the UK if you are:
    1. A student of a university in the UK or a university in another country.
    2. A student of a university in the UK and a student of a university in another country.
    3. A student of a university in the UK and a student of a university in another country and a student of a university in the UK.
    4. A student of a university in the UK and a student of a university in another country and a student of a university in the UK and a student of a university in another country.
    5. A student of a university in the UK and a student of a university in another country and a student of a university in the UK and a student of a university in another country and a student of a university in the UK.
    6. A student of a university in the UK and a student of a university in another country and a student of a university in the UK and a student of a university in another country and a student of a university in the UK and a student of a university in another country.
    7. A student of a university in the UK and a student of a university in another country and a student of a university in the UK and a student of a university in another country and a student of a university in the UK and a student of a university in another country and a student of a university in the UK.
    8. A student of a university in the UK and a student of a university in another country and a student of a university in the UK and a student of a university in another country and a student of a university in the UK and a student of a university in another country and a student of a university in the UK and a student of a university in another country.
    9. A student of a university in the UK and a student of a university in another country and a student of a university in the UK and a student of a university in another country and a student of a university in the UK and a student of a university in another country and a student of a university in the UK and a student of a university in another country and a student of a university in the UK.
    10. A student of a university in the UK and a student of a university in another country and a student of a university in the UK and a student of a university in another country and a"
  },
  {
    title: "Why study in the US?",
    tags: [{ name: "study" }, { name: "uk" }, { name: "abroad" }],
    # write article about why you should study in the US

    body: "You can study in the US if you are:
    1. A student of a university in the US.
    2. A student of a university in the US and a student of a university in another country.
    3. A student of a university in the US and a student of a university in another country and a student of a university in the US.
    4. A student of a university in the US and a student of a university in another country and a student of a university in the US and a student of a university in another country.
    5. A student of a university in the US and a student of a university in another country and a student of a university in the US and a student of a university in another country and a student of a university in the US.
    6. A student of a university in the US and a student of a university in another country and a student of a university in the US and a student of a university in another country and a student of a university in the US and a student of a university in another country.
    7. A student of a university in the US and a student of a university in another country and a student of a university in the US and a student of a university in another country and a student of a university in the US and a student of a university in another country and a student of a university in the US.
    8. A student of a university in the US and a student of a university in another country and a student of a university in the US and a student of a university in another country and a student of a university in the US and a student of a university in another country and a student of a university in the US and a student of a university in another country.
    9. A student of a university in the US and a student of a university in another country and a student of a university in the US and a student of a university in another country and a student of a university in the US and a student of a university in another country and a student of a university in the US and a student of a university in another country and a student of a university in the US.
    10. A student of a university in the US and a student of a university in another country and a student of a university in the US and a student of a university in another country and a student of a university in the US"
  },
  {
    title: "Why study in the Finland?",
    tags: [{ name: "study" }, { name: "finland" }, { name: "abroad" }],
    # write article about why you should study in the Finland

    body: "You can study in the Finland if you are:
    1. A student of a university in the Finland.
    2. A student of a university in the Finland and a student of a university in another country.
    3. A student of a university in the Finland and a student of a university in another country and a student of a university in the Finland.
    4. A student of a university in the Finland and a student of a university in another country and a student of a university in the Finland and a student of a university in another country.
    5. A student of a university in the Finland and a student of a university in another country and a student of a university in the Finland and a student of a university in another country and a student of a university in the Finland.
    6. A student of a university in the Finland and a student of a university in another country and a student of a university in the Finland and a student of a university in another country and a student of a university in the Finland and a student of a university in another country.
    7. A student of a university in the Finland and a student of a university in another country and a student of a university in the Finland and a student of a university in another country and a student of a university in the Finland and a student of a university in another country and a student of a university in the Finland.
    8. A student of a university in the Finland and a student of a university in another country and a student of a university in the Finland and a student of a university in another country and a student of a university in the Finland and a student of a university in another country and a student of a university in the Finland and a student of a university in another country.
    9. A student of a university in the Finland and a student of a university in another country and a student of a university in the Finland and a student of a university in another country and a student of a university in the Finland and a student of a university in another country and a student of a university in the Finland and a student of a university in another country and a student of a university in the Finland.
    10. A student of a university in the Finland and a student of a university in another country and a student of a university in the Finland and a student of a university in another country and a student of a university in the Finland"
  },
]

user = User.create(email: 'dumzmybuddy22zz@gamil.com', username: 'dumzmybuddy22zz', password: 'password', password_confirmation: 'password')
user.skip_confirmation!
user.save!
dummy_posts.each do |dummy|
  post = Post.create(title: dummy[:title], body: dummy[:body], user_id: user.id)
  dummy[:tags].each do |tag|
    post.tags.create(name: tag[:name])
  end
end