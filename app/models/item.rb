class Item < ApplicationRecord
  belongs_to :store
  belongs_to :unit, optional: true
  has_many :prices, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :store_id, presence: true
  validates :weight, numericality: { greater_than_or_equal_to: 0 }, allow_nil: false
  validates :unit_id, presence: true
end
