class Item < ApplicationRecord
  belongs_to :store
  belongs_to :unit, optional: true
  has_many :prices

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :store, presence: true
end
