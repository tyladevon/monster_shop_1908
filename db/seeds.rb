# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Merchant.destroy_all
Item.destroy_all

#merchants
bike_shop = Merchant.create(name: "Luna's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Zadins Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
music_shop = Merchant.create(name: "Phoebe's Music Shop", address: '41 Tune Ave.', city: 'Denver', state: 'CO', zip: 80201)
flower_shop = Merchant.create(name: "Tyla's Flower Shop", address: '987 Flower Lane.', city: 'Boulder', state: 'CO', zip: 80302)

molly_2 = User.create(
  name: "Molly2",
  street_address: "4233 Street",
  city: "Golden",
  state: "CO",
  zip: "80042",
  email: "molly2@gmail.com",
  password: "rainbows",
  role: 2,
  merchant_id: flower_shop.id
)
tilly_0 = User.create(
  name: "Tilly0",
  street_address: "403 Street",
  city: "Golden",
  state: "CO",
  zip: "80042",
  email: "tilly0@gmail.com",
  password: "rainbows",
  role: 0,
  merchant_id: dog_shop.id
)

mike_3 = User.create(
  name: "Mike3",
  street_address: "876 Ave",
  city: "Golden",
  state: "CO",
  zip: "80042",
  email: "mike3@gmail.com",
  password: "rainbows",
  role: 3,
  merchant_id: dog_shop.id
)

tyla = User.create(
  name: "Tyla1",
  street_address: "4233 Street",
  city: "Golden",
  state: "CO",
  zip: "80042",
  email: "tyla1@gmail.com",
  password: "rainbows",
  role: 1,
  merchant_id: flower_shop.id
)

ryan = User.create(
  name: "Ryan0",
  street_address: "123 Street",
  city: "Golden",
  state: "CO",
  zip: "80042",
  email: "ryan@ryan.com",
  password: "ryan",
  role: 0,
  merchant_id: music_shop.id
)

#bike_shop items
bike = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://cdn.shopify.com/s/files/1/0021/1399/4815/products/Sprout-V-Navy-010_b65d1c65-cd5c-4f5a-ab02-6c60d722bfe5_1800x.jpg?v=1572030559", inventory: 8)
helmet = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://images-na.ssl-images-amazon.com/images/I/61xR8UEj%2B-L._SL1500_.jpg", inventory: 12)
tire_tubes = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://images-na.ssl-images-amazon.com/images/I/717Jr3iK1WL._SL1500_.jpg", inventory: 12)
streamers = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://images-na.ssl-images-amazon.com/images/I/71DpVNJMfWL._SL1268_.jpg", inventory: 6)

#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
kong = dog_shop.items.create(name: "KONG", description: "Fun to chew!", price: 13, image: "https://images-na.ssl-images-amazon.com/images/I/71UdnSimAhL._AC_SX679_.jpg", inventory: 21)

#music_shop items
guitar_strings = music_shop.items.create(name: "Guitar Strings", description: "Rich and clear!", price: 9, image: "https://images-na.ssl-images-amazon.com/images/I/81KtifFUPQL._AC_SX679_.jpg", inventory: 15)
drum_sticks = music_shop.items.create(name: "Drum Sticks", description: "High quality!", price: 21, image: "https://images-na.ssl-images-amazon.com/images/I/51csSGxCa2L._AC_SL1005_.jpg", inventory: 20)
ukulele_book = music_shop.items.create(name: "Ukulele Music Book for Kids", description: "Good starter for kids!", price: 49, image: "https://cfcdn.zulily.com/images/cache/product//258309/zu26294486_main_tm1510786790.jpg", inventory: 10)
ukulele = music_shop.items.create(name: "Ukulele for Kids", description: "Good starter for kids!", price: 49, image: "https://cdn.shopify.com/s/files/1/0022/3412/2307/products/mk-ss-grn_720x.jpg?v=1557618873", inventory: 5)

#reviews
review_1 = tire.reviews.create(title: "Amazing!", content: "I'll never buy a different brand.", rating: 5)
review_2 = tire.reviews.create(title: "Pretty good", content: "Overall, I'm satisfied.", rating: 4)
review_3 = tire.reviews.create(title: "Average", content: "Mediocre quality for the price.", rating: 3)
review_4 = tire.reviews.create(title: "So so", content: "Only ok.", rating: 3)
review_5 = tire.reviews.create(title: "Horrible!", content: "Really awful product!", rating: 1)
review_6 = tire.reviews.create(title: "Poor", content: "Unsatisfied.", rating: 2)
review_7 = tire.reviews.create(title: "Superb!", content: "The best ever.", rating: 5)
review_8 = pull_toy.reviews.create(title: "Fun!", content: "My dog loveed it!", rating: 4)
review_9 = drum_sticks.reviews.create(title: "Solid product!", content: "Would buy again.", rating: 4)
review_10 = drum_sticks.reviews.create(title: "These ROCK!", content: "I even bought my mom a pair.", rating: 5)
