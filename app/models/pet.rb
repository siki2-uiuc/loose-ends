class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: { greater_than: -1, less_than: 100 }
end
