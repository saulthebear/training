class Post < ApplicationRecord
  validates :title, presence: true

  belongs_to :sub

  belongs_to :author,
             class_name: :User,
             foreign_key: :author_id
end
