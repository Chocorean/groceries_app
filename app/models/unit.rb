class Unit < ApplicationRecord
  has_many :items

  validates :name, presence: true

  # Shortcut to find a unit by name
  def self.by_name(name)
    Unit.find_by(name:)
  end
end
