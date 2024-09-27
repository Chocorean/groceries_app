# frozen_string_literal: true

store = Store.first

prod_a = Item.create!(name: 'Dummy 1', store:)
prod_b = Item.create!(name: 'Dummy 2', store:)

50.times do |i|
  value = Random.rand(20)
  promo = (i % 7).zero? ? value * Random.rand : nil
  Price.create!(value:, promo:, item: prod_a, date: Time.zone.today - i)
  value = Random.rand(20)
  promo = (i % 7).zero? ? value * Random.rand : nil
  Price.create!(value:, promo:, item: prod_b, date: Time.zone.today - i)
end
