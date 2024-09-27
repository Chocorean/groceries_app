class CreatePrices < ActiveRecord::Migration[7.1]
  def change
    create_table :prices do |t|
      t.float :value
      t.float :promo, null: true
      t.date :date, default: Date.today

      t.belongs_to :item, index: true, foreign_key: true
    end
  end
end
