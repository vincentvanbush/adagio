# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

10.times do
  user = User.find_or_create_by!(email: Faker::Internet.email) do |user|
    user.password = 'testtest'
  end
end

5.times do
  category = Category.create!(title: Faker::Commerce.department)

  20.times do |i|
    start_date = Faker::Time.between(1.week.ago, Time.now, :all)
    end_date = Faker::Time.between(Time.now, 2.weeks.from_now, :all)
    print "#{start_date}, #{end_date} \n"
    auction = category.auctions.create!(
      title:        Faker::Commerce.product_name,
      description:  Faker::Lorem.paragraphs(2),
      auction_type: %w(classic instant)[rand 2],
      start_date:   start_date,
      end_date:     end_date,
      price:        Faker::Commerce.price,
      user:         User.all[i % User.count]
    )

    if rand(4) == 0 # for every average of 4 auctions, let it be finished

    end
  end
end
