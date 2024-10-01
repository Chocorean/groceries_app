class Unit < ApplicationRecord
  has_many :items, dependent: :restrict_with_error

  validates :name, presence: true

  # Shortcut to find a unit by name
  def self.by_name(name)
    Unit.find_by(name:)
  end

  # shortcut for 'Count' unit
  def self.default
    Unit.by_name('ct')
  end
end
