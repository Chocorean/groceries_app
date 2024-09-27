class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :units do |t|
      t.string :name, null: false
    end

    create_table :items do |t|
      t.string :name, null: false
      t.float :weight, null: true

      t.belongs_to :unit, null: true, foreign_key: true
      t.belongs_to :store, null: false, foreign_key: true
    end
  end
end
