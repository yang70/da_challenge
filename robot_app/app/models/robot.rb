class Robot < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 1 }
  validates :special_attribute, presence: true
  validates :speed, presence: true, numericality: { only_integer: true }
  validates :size, presence: true
end
