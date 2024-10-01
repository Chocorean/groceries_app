# frozen_string_literal: true

# Describe the price of an item at a certain date
class Price < ApplicationRecord
  belongs_to :item

  validates :value, presence: true
  validates :date, presence: true
end
