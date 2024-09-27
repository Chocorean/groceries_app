require 'date'

%w[lb kg g oz floz gl qt ct].each do |name|
  Unit.create!(name:)
end

['Giant VanNess'].each do |store_name|
  Store.create!(name: store_name)
end
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

# first receipts
[
  [
    Date.new(2024, 9, 19), [
      ['UTZ O&C Chips', 4.79, 3.99, 7.75, Unit.by_name('oz')],
      ['Cat litter', 11.39, nil, 1, Unit.by_name('ct')]
    ]
  ], [
    Date.new(2019, 9, 18), [
      ['XL eggs', 4.99, nil, 12, Unit.by_name('ct')],
      ['Salted butter', 6.69, nil, 16, Unit.by_name('oz')],
      ['Vegetable Oil', 6.79, nil, 64, Unit.by_name('floz')],
      ['Bertolli Olive Oil', 33.99, 28.09, 72, Unit.by_name('floz')],
      ['Basil', 2.99, nil, 1, Unit.by_name('ct')],
      ['Cilantro', 1.49, nil, 1, Unit.by_name('ct')],
      # ['', 2.59, nil, 16, Unit.by_name('oz')],
      ['Sesame seeds', 8.29, nil, 20, Unit.by_name('oz')],
      ['SMG', 5.79, nil, 4.5, Unit.by_name('oz')]
    ]
  ], [
    Date.new(2019, 9, 17), [
      ['Galbani Mozza Log', 10.49, 7.99, 1, Unit.by_name('ct')],
      ['Mild Cheddar shreded', 8.89, nil, 1, Unit.by_name('ct')],
      ['Pizza Supreme', 5.79, nil, 1, Unit.by_name('ct')],
      ['Rice', 11.89, nil, 10, Unit.by_name('lb')],
      ['Rogu Tomato sauce', 6.69, nil, 1, Unit.by_name('ct')],
      ['Lasagna', 2.99, nil, 1, Unit.by_name('ct')],
      ['Penne', 3.19, nil, 12, Unit.by_name('oz')],
      ['Tomato on vine', 4.17, nil, 2.22, Unit.by_name('lb')],
      ['Russet Potato', 3.12, nil, 3.15, Unit.by_name('lb')],
      ['Organic Mushrooms', 3.29, nil, 1, Unit.by_name('ct')],
      ['Gala Apples', 2.39, nil, 0.96, Unit.by_name('lb')],
      ['Organic Beets', 3.99, nil, 1, Unit.by_name('ct')],
      ['Green Squash', 1.27, 1.01, 0.51, Unit.by_name('lb')],
      ['Cauliflower', 3.99, nil, 1, Unit.by_name('ct')],
      ['Rainbow Pepper', 4.99, nil, 3, Unit.by_name('ct')]
    ]
  ]
].each do |date, descs|
  descs.each do |desc|
    name, value, promo, weight, unit = desc
    item = Item.create!(name:, store:, weight:, unit:)
    Price.create!(value:, promo:, item:, date:)
  end
end
