# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

ActiveRecord::Base.connection.execute("CREATE OR REPLACE FUNCTION positive_percentage(uid integer) RETURNS FLOAT AS $$ BEGIN IF (select count(*) from comments where user_for_id = uid) = 0 THEN RETURN 0; END IF; RETURN (select cast(count(*) as float) from comments where user_for_id = uid and comment_type = 'positive') / (select cast(count(*) as float) from comments where user_for_id = uid); END; $$ LANGUAGE plpgsql")

puts 'Creating users...'
10.times do
  user = User.find_or_create_by!(email: Faker::Internet.email) do |user|
    user.password = 'testtest'
    user.name = Faker::Name.name
    user.account_number = ISO::IBAN.generate('PL', '', '').compact
    user.city = Faker::Address.city
    user.street = Faker::Address.street_name
    user.house_number = Faker::Address.building_number
    user.postal_code = "12-345"
  end
end

puts 'Creating categories...'
5.times do
  category = Category.create!(title: Faker::Commerce.department)

  puts "Creating auctions for category #{category.title}..."
  100.times do |i|
    auction = category.auctions.create(
      title:        Faker::Commerce.product_name,
      description:  Faker::Lorem.paragraphs(2),
      auction_type: %w(classic instant)[rand 2],
      start_date:   Faker::Time.between(1.week.ago, 3.hours.ago, :all),
      end_date:     Faker::Time.between(Time.now, 2.weeks.from_now, :all),
      price:        Faker::Commerce.price,
      user:         User.all[i % User.count]
    )

    # if rand(4) == 0 # for every average of 4 auctions, give it comments
    #   puts "Creating comments for auction #{auction.title}..."
    #   buyer = User.all[rand(User.count)]
    #   auction.update!(
    #     seller_comment_id: Comment.create!(
    #       comment_type: %w(negative positive neutral)[rand 3],
    #       content:      Faker::Lorem.paragraph(20),
    #       auction:      auction,
    #       author:       auction.user,
    #       user_for:     buyer
    #     ).id,
    #     buyer_comment_id: Comment.create!(
    #       comment_type: %w(negative positive neutral)[rand 3],
    #       content:      Faker::Lorem.paragraph(20),
    #       auction:      auction,
    #       author:       buyer,
    #       user_for:     auction.user
    #     ).id
    #   )
    # end
  end
end
