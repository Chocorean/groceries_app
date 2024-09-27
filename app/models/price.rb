class Price < ApplicationRecord
  belongs_to :item

  validates :value, presence: true
  validates :date, presence: true
end
