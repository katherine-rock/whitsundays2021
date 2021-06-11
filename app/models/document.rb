class Document < ApplicationRecord
  belongs_to :user
  has_one_attached :file
  validates :file, :title, presence: true
end
