# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

scott = User.create_profile("ScottyLi",
  uid: "473698343",
  via_oauth: true
)

sida = User.create_profile("sidazhang",
  uid: "616934071",
  via_oauth: true
)

content1 = "@sidazhang 0.1 BTC #tippercoin"

tip1 = scott.tips_given.new({
  content: content1,
  screen_name: scott.screen_name,
  api_tweet_id_str: 1,
  recipient_id: sida.id,
  satoshis: 100000,
  tx_hash: SecureRandom.hex(10)
})

tip1.save

content2 = "@ScottyLi 0.2 BTC #tippercoin"

tip2 = sida.tips_given.new({
  content: content2,
  screen_name: sida.screen_name,
  api_tweet_id_str: 1,
  recipient_id: scott.id,
  satoshis: 210000,
  tx_hash: SecureRandom.hex(10)
})

tip2.save
