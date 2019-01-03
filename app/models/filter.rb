class Filter < ApplicationRecord
  has_many :tags, dependent: :destroy

  validates :title, presence: true, length: { minimum: 3 }, uniqueness: true
end